# JetRos-Containers

Container with ROS installed running on Jetson

---

### Sample Script

```bash
# Ubuntu 22.04用のDockerイメージ起動
docker run -it --rm --net=host --runtime nvidia -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix nvcr.io/nvidia/l4t-base:r36.2.0
```