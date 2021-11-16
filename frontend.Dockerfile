FROM dart:2.14.4

RUN apt-get update && apt-get install -y \
  protobuf-compiler \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN groupadd --system dart && \
  useradd --no-log-init --system --home /home/dart --create-home -g dart dart
RUN chown dart:dart /app

# Work around https://github.com/dart-lang/sdk/issues/47093
RUN find /usr/lib/dart -type d -exec chmod 755 {} \;

USER dart

RUN dart pub global activate protoc_plugin

COPY --chown=dart:dart frontend/pubspec.* /app/
COPY --chown=dart:dart frontend/third_party /app/third_party
RUN ls -al
RUN dart pub get
COPY --chown=dart:dart frontend/. /app
RUN dart pub get --offline

COPY --chown=dart:dart frontend.sh /entrypoint.sh

CMD []
ENTRYPOINT ["/entrypoint.sh"]
