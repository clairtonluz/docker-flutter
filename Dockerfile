FROM openjdk:11-jdk
ARG ANDROID_COMPILE_SDK="28"
ARG ANDROID_BUILD_TOOLS="28.0.3" 
ARG ANDROID_SDK_TOOLS="4333796"
ENV ANDROID_HOME=/opt/android

RUN apt-get --quiet update --yes \
    && apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 \
    && wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip \
    && unzip -d $ANDROID_HOME android-sdk.zip \
    && rm -f android-sdk.zip \
    && mkdir $ANDROID_HOME/tools/bin/jaxb_lib \
    && wget https://repo1.maven.org/maven2/javax/activation/activation/1.1.1/activation-1.1.1.jar -O $ANDROID_HOME/tools/bin/jaxb_lib/activation.jar \
    && wget https://repo1.maven.org/maven2/com/sun/xml/bind/jaxb-impl/2.3.3/jaxb-impl-2.3.3.jar -O $ANDROID_HOME/tools/bin/jaxb_lib/jaxb-impl.jar \
    && wget https://repo1.maven.org/maven2/com/sun/istack/istack-commons-runtime/3.0.11/istack-commons-runtime-3.0.11.jar -O $ANDROID_HOME/tools/bin/jaxb_lib/istack-commons-runtime.jar \
    && wget https://repo1.maven.org/maven2/org/glassfish/jaxb/jaxb-xjc/2.3.3/jaxb-xjc-2.3.3.jar -O $ANDROID_HOME/tools/bin/jaxb_lib/jaxb-xjc.jar \
    && wget https://repo1.maven.org/maven2/org/glassfish/jaxb/jaxb-core/2.3.0.1/jaxb-core-2.3.0.1.jar -O $ANDROID_HOME/tools/bin/jaxb_lib/jaxb-core.jar \
    && wget https://repo1.maven.org/maven2/org/glassfish/jaxb/jaxb-jxc/2.3.3/jaxb-jxc-2.3.3.jar -O $ANDROID_HOME/tools/bin/jaxb_lib/jaxb-jxc.jar \
    && wget https://repo1.maven.org/maven2/javax/xml/bind/jaxb-api/2.3.1/jaxb-api-2.3.1.jar -O $ANDROID_HOME/tools/bin/jaxb_lib/jaxb-api.jar \
    && sed -i '/^CLASSPATH=$APP_HOME/s/$/:$APP_HOME\/bin\/jaxb_lib\/activation\.jar/' $ANDROID_HOME/tools/bin/sdkmanager \
    && sed -i '/^CLASSPATH=$APP_HOME/s/$/:$APP_HOME\/bin\/jaxb_lib\/jaxb-impl\.jar/' $ANDROID_HOME/tools/bin/sdkmanager \
    && sed -i '/^CLASSPATH=$APP_HOME/s/$/:$APP_HOME\/bin\/jaxb_lib\/istack-commons-runtime\.jar/' $ANDROID_HOME/tools/bin/sdkmanager \
    && sed -i '/^CLASSPATH=$APP_HOME/s/$/:$APP_HOME\/bin\/jaxb_lib\/jaxb-xjc\.jar/' $ANDROID_HOME/tools/bin/sdkmanager \
    && sed -i '/^CLASSPATH=$APP_HOME/s/$/:$APP_HOME\/bin\/jaxb_lib\/jaxb-core\.jar/' $ANDROID_HOME/tools/bin/sdkmanager \
    && sed -i '/^CLASSPATH=$APP_HOME/s/$/:$APP_HOME\/bin\/jaxb_lib\/jaxb-jxc\.jar/' $ANDROID_HOME/tools/bin/sdkmanager \
    && sed -i '/^CLASSPATH=$APP_HOME/s/$/:$APP_HOME\/bin\/jaxb_lib\/jaxb-api\.jar/' $ANDROID_HOME/tools/bin/sdkmanager \
    && echo y | $ANDROID_HOME/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null \
    && echo y | $ANDROID_HOME/tools/bin/sdkmanager "platform-tools" >/dev/null \
    && echo y | $ANDROID_HOME/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null \
    && yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses 

ENV PATH=$PATH:$ANDROID_HOME/platform-tools/

# FLUTTER CONFIG
ARG FLUTTER_VERSION=1.20.3
ENV FLUTTER_HOME=/opt/flutter
ENV PATH=$PATH:$FLUTTER_HOME/bin

ENV DART_HOME=${FLUTTER_HOME}/bin/cache/dart-sdk
ENV PATH=$PATH:${DART_HOME}/bin


RUN apt-get --quiet update --yes \
    # When you run "flutter test --coverage", it will generate coverage/lcov.info
    # this dependence is used to convert this file (coverage/lcov.info) to HTML
    && apt-get --quiet install --yes lcov \
    && wget --quiet --output-document=flutter-sdk.tar.xz https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz \
    && tar -C /opt -xf flutter-sdk.tar.xz \
    && rm -f flutter-sdk.tar.xz