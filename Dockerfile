# 使用rclone镜像
FROM rclone/rclone:latest

# 安装 supercronic
ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/latest/download/supercronic-linux-amd64
RUN wget -O /usr/local/bin/supercronic "$SUPERCRONIC_URL" \
    && chmod +x /usr/local/bin/supercronic

# 配置时区（可选）
ENV TZ=Asia/Shanghai

# 直接运行 supercronic
ENTRYPOINT ["/usr/local/bin/supercronic"]
CMD ["/etc/crontab"]