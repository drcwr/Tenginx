```
docker pull registry.cn-hangzhou.aliyuncs.com/server_repertory/nginx:latest
```
### 启动命令
```
docker run -dit -p 80:80 -p 443:443 --net host -v /data/htdocs:/data/htdocs -v /data/nginx/logs:/var/log/nginx -v /data/nginx/conf/nginx.conf:/etc/nginx/nginx.conf -v /data/nginx/conf/include:/etc/nginx/conf.d registry.cn-hangzhou.aliyuncs.com/server_repertory/nginx:latest
```

### 宿住机器新建好日志目录和网站目录（镜像内有一个/data/htdocs目录可以使用），启动时挂载，
### 如果php是sock方式还要挂载一个sock（镜像内有一个/data/php目录可以使用），
### nginx默认配置文件目录：/etc/nginx/和/etc/nginx/conf.d，
### nginx默认配置文件：/etc/nginx/nginx.conf和/etc/nginx/conf.d/www.conf，
### 日志目录：/var/log/nginx
### 开放端口：80,443

**nginx -V**:
```
Tengine version: Tengine/2.2.2 (nginx/1.8.1)
built by gcc 6.4.0 (Alpine 6.4.0) 
TLS SNI support enabled
configure arguments: 
--sbin-path=/usr/sbin/nginx 
--conf-path=/etc/nginx/nginx.conf 
--error-log-path=/var/log/nginx/error.log 
--http-log-path=/var/log/nginx/access.log 
--pid-path=/var/run/nginx.pid 
--lock-path=/var/run/nginx.lock 
--http-client-body-temp-path=/var/tmp/nginx/client_temp 
--http-proxy-temp-path=/var/tmp/nginx/proxy_temp 
--http-fastcgi-temp-path=/var/tmp/nginx/fastcgi_temp 
--http-uwsgi-temp-path=/var/tmp/nginx/uwsgi_temp 
--http-scgi-temp-path=/var/tmp/nginx/scgi_temp --with-http_ssl_module 
--with-http_realip_module 
--with-http_addition_module 
--with-http_sub_module 
--with-http_dav_module 
--with-http_flv_module 
--with-http_mp4_module 
--with-http_gunzip_module 
--with-http_gzip_static_module 
--with-http_random_index_module 
--with-http_secure_link_module 
--with-http_auth_request_module 
--with-mail 
--with-mail_ssl_module 
--with-file-aio 
--with-http_v2_module 
--with-ipv6 
--with-jemalloc 
--with-threads 
--with-http_xslt_module 
--with-http_image_filter_module 
--with-http_geoip_module 
--with-http_degradation_module 
--with-http_slice_module 
--with-http_stub_status_module 
--with-http_dyups_module 
--with-http_lua_module 
--with-md5-asm 
--with-pcre 
--with-sha1-asm 
--with-http_dyups_lua_api


nginx: loaded modules:
nginx:     ngx_core_module (static)
nginx:     ngx_errlog_module (static)
nginx:     ngx_conf_module (static)
nginx:     ngx_dso_module (static)
nginx:     ngx_events_module (static)
nginx:     ngx_event_core_module (static)
nginx:     ngx_epoll_module (static)
nginx:     ngx_procs_module (static)
nginx:     ngx_proc_core_module (static)
nginx:     ngx_thread_pool_module (static)
nginx:     ngx_openssl_module (static)
nginx:     ngx_regex_module (static)
nginx:     ngx_http_module (static)
nginx:     ngx_http_core_module (static)
nginx:     ngx_http_log_module (static)
nginx:     ngx_http_upstream_module (static)
nginx:     ngx_http_v2_module (static)
nginx:     ngx_http_static_module (static)
nginx:     ngx_http_gzip_static_module (static)
nginx:     ngx_http_dav_module (static)
nginx:     ngx_http_autoindex_module (static)
nginx:     ngx_http_index_module (static)
nginx:     ngx_http_random_index_module (static)
nginx:     ngx_http_auth_request_module (static)
nginx:     ngx_http_auth_basic_module (static)
nginx:     ngx_http_access_module (static)
nginx:     ngx_http_limit_conn_module (static)
nginx:     ngx_http_limit_req_module (static)
nginx:     ngx_http_realip_module (static)
nginx:     ngx_http_geo_module (static)
nginx:     ngx_http_geoip_module (static)
nginx:     ngx_http_map_module (static)
nginx:     ngx_http_split_clients_module (static)
nginx:     ngx_http_referer_module (static)
nginx:     ngx_http_rewrite_module (static)
nginx:     ngx_http_ssl_module (static)
nginx:     ngx_http_proxy_module (static)
nginx:     ngx_http_fastcgi_module (static)
nginx:     ngx_http_uwsgi_module (static)
nginx:     ngx_http_scgi_module (static)
nginx:     ngx_http_memcached_module (static)
nginx:     ngx_http_empty_gif_module (static)
nginx:     ngx_http_browser_module (static)
nginx:     ngx_http_user_agent_module (static)
nginx:     ngx_http_secure_link_module (static)
nginx:     ngx_http_degradation_module (static)
nginx:     ngx_http_flv_module (static)
nginx:     ngx_http_slice_module (static)
nginx:     ngx_http_mp4_module (static)
nginx:     ngx_http_upstream_hash_module (static)
nginx:     ngx_http_upstream_ip_hash_module (static)
nginx:     ngx_http_upstream_consistent_hash_module (static)
nginx:     ngx_http_upstream_check_module (static)
nginx:     ngx_http_upstream_least_conn_module (static)
nginx:     ngx_http_upstream_keepalive_module (static)
nginx:     ngx_http_upstream_dynamic_module (static)
nginx:     ngx_http_dyups_module (static)
nginx:     ngx_http_stub_status_module (static)
nginx:     ngx_http_write_filter_module (static)
nginx:     ngx_http_header_filter_module (static)
nginx:     ngx_http_chunked_filter_module (static)
nginx:     ngx_http_v2_filter_module (static)
nginx:     ngx_http_range_header_filter_module (static)
nginx:     ngx_http_gzip_filter_module (static)
nginx:     ngx_http_postpone_filter_module (static)
nginx:     ngx_http_ssi_filter_module (static)
nginx:     ngx_http_charset_filter_module (static)
nginx:     ngx_http_xslt_filter_module (static)
nginx:     ngx_http_image_filter_module (static)
nginx:     ngx_http_sub_filter_module (static)
nginx:     ngx_http_addition_filter_module (static)
nginx:     ngx_http_gunzip_filter_module (static)
nginx:     ngx_http_userid_filter_module (static)
nginx:     ngx_http_footer_filter_module (static)
nginx:     ngx_http_trim_filter_module (static)
nginx:     ngx_http_headers_filter_module (static)
nginx:     ngx_http_upstream_session_sticky_module (static)
nginx:     ngx_http_reqstat_module (static)
nginx:     ngx_http_lua_module (static)
nginx:     ngx_http_copy_filter_module (static)
nginx:     ngx_http_range_body_filter_module (static)
nginx:     ngx_http_not_modified_filter_module (static)
nginx:     ngx_mail_module (static)
nginx:     ngx_mail_core_module (static)
nginx:     ngx_mail_ssl_module (static)
nginx:     ngx_mail_pop3_module (static)
nginx:     ngx_mail_imap_module (static)
nginx:     ngx_mail_smtp_module (static)
nginx:     ngx_mail_auth_http_module (static)
nginx:     ngx_mail_proxy_module (static)
```

### 提供一个默认的nginx.conf,可通过-v挂在容器的/etc/nginx/nginx.conf上：
```

worker_processes 2;
worker_cpu_affinity auto;
worker_rlimit_nofile 65530;
error_log  /var/log/nginx/nginx_error.log  crit;

events
{
  use epoll;
  worker_connections 65530;
}

http {
    include       mime.types;
    default_type  application/octet-stream;
    sendfile on;
    tcp_nopush on;
    keepalive_timeout 60;
    tcp_nodelay on;
    server_tokens off;
    server_names_hash_bucket_size 128;
    client_header_buffer_size 32k;
    large_client_header_buffers 4 32k;
    client_max_body_size 8m;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for" "$request_time"';

    log_format  post  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for" "$request_time" "$request_body"';

    access_log  /var/log/nginx/access.log  main;


    gzip  on;
    gzip_min_length 1k;
    gzip_buffers 16 64k;
    gzip_http_version 1.1;
    gzip_comp_level 6;
    gzip_types text/plain application/x-javascript text/css application/xml;
    gzip_vary on;

    limit_req_zone $binary_remote_addr zone=one:3m rate=1r/s;
    limit_req_zone $binary_remote_addr $uri zone=two:3m rate=1r/s;
    limit_req_zone $binary_remote_addr $request_uri zone=thre:3m rate=1r/s;
    include conf.d/*.conf;
}
```

### 再提供一个conf.d/localhost.conf，可通过-v挂到容器的/etc/nginx/conf.d目录后，放置到宿主机对应的目录即可：
### 该配置文件已经配置了php文件的请求，向php-cgi.sock请求php文件，所以要提前将php的sock文件指定到该容器内（建议通过IP:PORT方式）
```
server {
    listen 80;
    server_name  localhost;
    root "/data/htdocs";
    index index.html index.htm index.php;

    charset utf-8;

    add_header Strict-Transport-Security max-age=63072000;
    add_header X-Frame-Options DENY;
    add_header X-Content-Type-Options nosniff;

    gzip on;
    gzip_min_length 1k;
    gzip_comp_level 2;
    gzip_types application/json text/plain application/javascript application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png;
    gzip_vary on;

    if  ( $uri ~* "^/favicon\.ico" ) {
        break;
    }

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log /var/log/nginx/localhost-access.log main;
    error_log  /var/log/nginx/localhost-error.log error;

    sendfile off;

    client_max_body_size 100m;

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/data/php/php-cgi.sock;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        fastcgi_param DOCUMENT_ROOT $realpath_root;
        fastcgi_intercept_errors off;
        fastcgi_buffer_size 16k;
        fastcgi_buffers 4 16k;
        fastcgi_connect_timeout 300;
        fastcgi_send_timeout 300;
        fastcgi_read_timeout 300;
    }

    location ~ /\.ht {
        deny all;
    }
}
```
