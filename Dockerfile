# syntax=docker/dockerfile:1
FROM debian:stable

# Set up the default locale
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"
ENV ANDROID_HOME=/usr/lib/android-sdk

# Install system commands, Android SDK, and Ruby
RUN apt-get update  \
    && apt-get install -y coreutils git wget locales android-sdk android-sdk-build-tools \
    && apt-get -y autoclean

# Download the SDK Manager
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip \
	&& unzip commandlinetools-linux-6858069_latest.zip && rm commandlinetools-linux-6858069_latest.zip \
	&& mkdir /usr/lib/android-sdk/cmdline-tools \
	&& mv cmdline-tools /usr/lib/android-sdk/cmdline-tools/latest

ENV PATH="//usr/lib/android-sdk/cmdline-tools/latest/bin:${PATH}"

RUN sdkmanager "platforms;android-30" "system-images;android-30;google_apis_playstore;x86_64" "build-tools;30.0.0"

RUN yes | sdkmanager --licenses

