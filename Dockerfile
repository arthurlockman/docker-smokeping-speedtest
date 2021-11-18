FROM linuxserver/smokeping:latest as release

# Copy in default speedtest probe/target config
COPY conf / /speedtest-conf/

# Install speedtest-cli and it's dependencies
RUN apk add python3 --no-cache \
    && (cd /usr/bin && ln -s python3.8 python) \
    && curl -L -s -S -o /usr/share/perl5/vendor_perl/Smokeping/probes/speedtest.pm https://github.com/mad-ady/smokeping-speedtest/raw/master/speedtest.pm \
    && curl -L -s -S -o /usr/local/bin/speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py \
    && chmod a+x /usr/local/bin/speedtest-cli \
    && cat /speedtest-conf/Probes >> /defaults/smoke-conf/Probes \
    && cat /speedtest-conf/Targets >> /defaults/smoke-conf/Targets

# Install Ookla Speedtest
RUN cd /tmp
RUN curl -o speedtest-cli.tgz https://install.speedtest.net/app/cli/ookla-speedtest-1.1.0-x86_64-linux.tgz
RUN tar zxvf speedtest-cli.tgz -C /usr/local/bin
RUN curl -L -s -S -o /usr/share/perl5/vendor_perl/Smokeping/probes/speedtestcli.pm https://raw.githubusercontent.com/mad-ady/smokeping-speedtest/master/speedtestcli.pm
RUN /usr/local/bin/speedtest --accept-license

# Build image with tests
FROM alpine:latest as test
COPY --from=release / /
COPY test/ /test
WORKDIR /test
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["./tests.sh"]

FROM release
