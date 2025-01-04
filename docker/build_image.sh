#!/bin/bash
set -e

# カレントディレクトリの取得
cd $(dirname $0)/..

# ベースイメージのビルド
docker build \
    -t jetsonros:base \
    -f docker/Dockerfile.base .