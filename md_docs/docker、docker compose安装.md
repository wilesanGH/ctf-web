# Docker 与 Docker Compose 安装教程

## 一、Docker 安装
![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F29%2F10-49-28-23f771e8f95c1362ec98a0c5f80c11ae-20250429104926234-62687c.png)
### 1. Windows 系统

1. 访问 [Docker Desktop 官网](https://www.docker.com/products/docker-desktop/) 下载 Windows 版本安装包。
2. 双击安装包，按照提示完成安装。
3. 安装完成后，启动 Docker Desktop，等待 Docker 图标变为绿色（表示启动成功）。
4. 可在命令行输入 `docker version` 验证安装是否成功。

> 注意：Windows 10 及以上版本建议开启 WSL2 支持，安装过程中可根据提示自动配置。

### 2. MacOS 系统

1. 访问 [Docker Desktop 官网](https://www.docker.com/products/docker-desktop/) 下载 Mac 版本安装包（支持 Intel 和 Apple 芯片）。
2. 双击 `.dmg` 文件，将 Docker 拖入 Applications 文件夹。
3. 启动 Docker Desktop，等待 Docker 图标变为绿色。
4. 打开终端，输入 `docker version` 验证安装。

### 3. Linux 系统（以 Ubuntu 为例）
1. 编写/生成安装脚本,会在当前目录下生成docker_docker-compose_install.sh文件
    ```bash
    sudo cat << EOF > ./docker_docker-compose_install.sh
    #!/bin/sh
    # -*- coding: utf-8 -*-

    
    apt install -y firewalld apt-transport-https ca-certificates curl software-properties-common gcc
    
    apt -y install docker.io
    
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config && setenforce 0
    
    apt -y install docker-compose
    
    systemctl enable --now docker.service
    EOF
    ```
2. 运行脚本，运行docker_docker-compose_install.sh，执行完成后删除docker_docker-compose_install.sh
    ```bash
    sudo sh ./docker_docker-compose_install.sh && rm -rf ./docker_docker-compose_install.sh
    ```
3. 验证 Docker 是否安装成功：
   ```bash
   sudo docker version

    ss@ss:~$ sudo docker version
    Client:
    Version:           26.1.3
    API version:       1.45
    Go version:        go1.22.2
    Git commit:        26.1.3-0ubuntu1~24.04.1
    Built:             Mon Oct 14 14:29:26 2024
    OS/Arch:           linux/amd64
    Context:           default

    Server:
    Engine:
    Version:          26.1.3
    API version:      1.45 (minimum version 1.24)
    Go version:       go1.22.2
    Git commit:       26.1.3-0ubuntu1~24.04.1
    Built:            Mon Oct 14 14:29:26 2024
    OS/Arch:          linux/amd64
    Experimental:     false
    containerd:
    Version:          1.7.24
    GitCommit:        
    runc:
    Version:          1.1.12-0ubuntu3.1
    GitCommit:        
    docker-init:
    Version:          0.19.0
    GitCommit: 

   sudo docker run hello-world
   sudo docker-compose version

   ss@ss:~$ sudo docker-compose version
    docker-compose version 1.29.2, build unknown
    docker-py version: 5.0.3
    CPython version: 3.12.3
    OpenSSL version: OpenSSL 3.0.13 30 Jan 2024

   ```

