# 端口设置
EXPORT_SERVER_PORT=7080
WP_CONTAINER_PORT=80

# DB 设置
WORDPRESS_DB_HOST="qiushaocloud-wordpress-db-server:3306"
MYSQL_ROOT_PASSWORD="rootpassword"
WORDPRESS_DB_NAME="wordpress"
WORDPRESS_DB_USER="wordpress"
WORDPRESS_DB_PASSWORD="wordpress"
WORDPRESS_DEBUG=0

# ssl 配置【注: 当从外部映射 ssl_cetrts 所需的 key 和 pem 文件进入容器后, 则会认为需要开启 https】
SSL_KEY_PATH="" # 为 "" 则使用默认路径 /ssl_cetrts/server.key
SSL_CRT_PATH="" # 为 "" 则使用默认路径 /ssl_cetrts/server.pem

# volume 设置
WORDPRESS_DB_DATA_PATH="/mnt/wordpress_db_data"
WORDPRESS_DATA_PATH="/mnt/wordpress_data"