FROM clairtonluz/flutter:latest
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.4.0.2170-linux.zip -O sonar-scanner.zip \
    && unzip sonar-scanner.zip -d /opt \
    && mv /opt/sonar-scanner-4.4.0.2170-linux /opt/sonar-scanner

ENV PATH=$PATH:/opt/sonar-scanner/bin
