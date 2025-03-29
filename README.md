# docker快速部署rclone

使用docker集成rclone和定时任务环境，只需简单修改配置，即可实现rclone定时自动同步文件，实现本地文件与各大云盘同步一致。

## 功能特点

- 集成文件同步驱动rclone
- 集成定时任务驱动supercronic

## 安装说明

1. 安装docker和docker-compose
2. 拉代码，进入目录：

```bash
//拉代码
git clone https://github.com/luler/rclone_docker.git
//进入目录  
cd rclone_docker
```

3. 修改config/rclone.conf，配置远程存储驱动，这里使用webdav为例，其他驱动请参考rclone官方文档：https://rclone.org/docs/

```
[mywebdav]
type = webdav # 驱动类型，还有很多，如：onedrive、google drive等
url = https://alist.xxx.top/dav/ # webdav地址
vendor = other # 一般默认这个即可
user = admin  # webdav用户名
pass = xxxxxxx  # webdav密码，注意：这里需要使用rclone的混淆密码，如：rclone obscure "你的明文密码"

#no_check_certificate=true  # 如果需要跳过SSL验证
```
4. 修改config/crontab，配置定时任务，如下示例：
```
# 每分钟执行备份，flock防止重复执行
* * * * * flock -n /tmp/rclone.lock rclone sync mywebdav:nas/我的文件/ /data --log-file=/var/log/rclone-sync.log --log-level=INFO --stats=10m
```

5. 启动容器

```bash
docker-compose up -d
```