FROM clairtonluz/android-sdk
ARG FLUTTER_VERSION=1.2.1
ENV FLUTTER_HOME=/opt/flutter
ENV PATH=$PATH:$FLUTTER_HOME/bin

RUN apt-get --quiet update --yes \
    && wget --quiet --output-document=flutter-sdk.tar.xz https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v${FLUTTER_VERSION}-stable.tar.xz \
    && tar -C /opt -xf flutter-sdk.tar.xz \
    && rm -f flutter-sdk.tar.xz