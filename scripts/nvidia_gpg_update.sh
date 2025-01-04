#! /bin/bash
set -e

tmp_gpg_file="/tmp/nvidia.gpg"
gpg_file="/usr/share/keyrings/nvidia.gpg"

# ファイルが存在するか確認
if [ -f "$tmp_gpg_file" ]; then
  # ファイルが存在する場合、削除
  rm "$tmp_gpg_file"
fi

# ファイルが存在するか確認
if [ -f "$gpg_file" ]; then
  # ファイルが存在する場合、削除
  rm "$gpg_file"
fi

# GPG公開鍵の更新
curl -s https://repo.download.nvidia.com/jetson/jetson-ota-public.asc | \
    gpg --no-default-keyring --keyring /tmp/nvidia.gpg --import && \
    gpg --no-default-keyring --keyring /tmp/nvidia.gpg \
    --export --output /usr/share/keyrings/nvidia.gpg

# 編集するsources.listファイルのパス
source_list_file="/etc/apt/sources.list"

# 検索する文字列
search_string="deb https://repo.download.nvidia.com/jetson/common"

# 追加する文字列
add_string="[signed-by=/usr/share/keyrings/nvidia.gpg]"

# 一時ファイル名
temp_file=$(mktemp)

# ファイルが存在するか確認
if [ ! -f "$source_list_file" ]; then
  echo "not found '$source_list_file'"
  exit 1
fi

# ファイルを一行ずつ読み込み、変更を加える
while IFS= read -r line; do
  if [[ "$line" == *"$search_string"* ]]; then
    echo "$line" | sed 's@deb @deb '$add_string' @g' | sed 's@ universe@@g'>> "$temp_file"
  else
    echo "$line" >> "$temp_file"
  fi
done < "$source_list_file"

# 元のファイルをバックアップ
cp "$source_list_file" "$source_list_file.bak"

# 一時ファイルを元のファイルに移動
mv "$temp_file" "$source_list_file"