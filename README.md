# 在搭载 Apple Silicon 芯片的 Mac 上利用 OrbStack 使用 Vivado 的方法

本教程及 `Dockerfile` 内容为高德昊总结整理，示例基于 Vivado 2023.2，对于不再提供 Web Installer 的版本（例如2019.2），可以自行调整 `Dockerfile`。

1. 在 macOS 上安装 OrbStack 和 XQuartz。

2. 自己想办法配置网络，使 Mac 能访问 Docker 官方源。

3. 将你的 Vivado 安装包（`.bin` 文件）放入 `Dockerfile` 同目录下，运行如下命令构建镜像，按照提示安装 Vivado：

   ```zsh
   # 在宿主机执行授权（每次重启后需要重新执行）
   xhost +local:root
   # 构建镜像
   docker build -t vivado-gui:2023.2 \
     --build-arg DISPLAY=host.docker.internal:0 \
     --progress=plain \
     .
   ```
   
3. 以后运行容器：

   ```zsh
   xhost +local:docker
   docker run -it --rm \
     -e DISPLAY=host.docker.internal:0 \
     -e XAUTHORITY=/tmp/.Xauthority \
     -v /tmp/.X11-unix:/tmp/.X11-unix \
     -v ~/vivado:/vivado/project \
     vivado-gui:2023.2 \
     /tools/Xilinx/Vivado/2023.2/bin/vivado
   ```
   
   

