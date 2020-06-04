FROM openjdk:8-jdk
ARG ANDROID_COMPILE_SDK="28"
ARG ANDROID_BUILD_TOOLS="28.0.3" 
ARG ANDROID_SDK_TOOLS="4333796"
ENV ANDROID_HOME=/opt/android

RUN apt-get --quiet update --yes \
    && apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 \
    && wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip \
    && unzip -d $ANDROID_HOME android-sdk.zip \
    && rm -f android-sdk.zip \
    && echo y | $ANDROID_HOME/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null \
    && echo y | $ANDROID_HOME/tools/bin/sdkmanager "platform-tools" >/dev/null \
    && echo y | $ANDROID_HOME/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null \
    && yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses 

ENV PATH=$PATH:$ANDROID_HOME/platform-tools/

# FLUTTER CONFIG
ARG FLUTTER_VERSION=1.17.3
ENV FLUTTER_HOME=/opt/flutter
ENV PATH=$PATH:$FLUTTER_HOME/bin

RUN apt-get --quiet update --yes \
    # When you run "flutter test --coverage", it will generate coverage/lcov.info
    # this dependence is used to convert this file (coverage/lcov.info) to HTML
    && apt-get --quiet install --yes lcov \
    && wget --quiet --output-document=flutter-sdk.tar.xz https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz \
    && tar -C /opt -xf flutter-sdk.tar.xz \
    && rm -f flutter-sdk.tar.xz