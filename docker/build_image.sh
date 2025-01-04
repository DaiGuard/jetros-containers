#!/bin/bash
set -e

# カレントディレクトリの取得
cd $(dirname $0)/..

# ベースイメージのビルド
docker build \
    -t jetros:base \
    -f docker/Dockerfile.base .