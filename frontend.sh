#!/bin/bash

set -euo pipefail

export PATH=$PATH:$HOME/.pub-cache/bin

dart tool/grind.dart build \
  "--pre-null-safety-server-url=${PRE_NULL_SAFETY_SERVER_URL}" \
  "--null-safety-server-url=${NULL_SAFETY_SERVER_URL}"

exec dart bin/serve.dart
