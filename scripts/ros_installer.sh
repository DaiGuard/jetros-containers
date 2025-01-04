#! /bin/bash
set -e

# tzdataインストール回避
export DEBIAN_FRONTEND=noninteractive

# locale設定
locale  # check for UTF-8
apt-get update && apt-get install locales -y
locale-gen en_US en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
locale  # verify settings

# ROS2のインストール
apt-get install software-properties-common -y
add-apt-repository universe -y

apt-get update && apt-get install curl -y
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

apt-get update && apt-get install ros-humble-ros-base python3-argcomplete -y

# キャッシュ削除
apt-get clean && rm -rf /var/lib/apt/lists/*