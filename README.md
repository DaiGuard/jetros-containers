# JetRos-Containers

Container with ROS installed running on Jetson

---

### Build Image

```bash
cd jetros-containers
./docker/build_image.sh
```

### Test Run

```bash
docker run -it --rm --net=host --runtime nvidia -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix jetros:base
```

### To-Do

* [ ] GPG鍵の更新を入れる
* [ ] IsaacROS + NITROSが実行できるようにする

----

### Sample Script

```bash
# Ubuntu 22.04用のDockerイメージ起動
docker run -it --rm --net=host --runtime nvidia -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix nvcr.io/nvidia/l4t-base:r36.2.0
```