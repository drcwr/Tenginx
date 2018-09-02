FROM alpine:latest
MAINTAINER Eric.wang wdc-zhy@163.com

LABEL Nginx="nginx镜像"

LABEL description="宿住机器新建好日志目录和网站目录（镜像内有一个/data/htdocs目录可以使用），启动时挂载，\
如果php是sock方式还要挂载一个sock（镜像内有一个/data/php目录可以使用），\
nginx默认配置文件目录：/etc/nginx/和/etc/nginx/conf.d，\
其他部分编译参数：--prefix=/var/lib/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules \
--conf-path=/etc/nginx/nginx.conf --pid-path=/run/nginx/nginx.pid --lock-path=/run/nginx/nginx.lock \
--http-client-body-temp-path=/var/tmp/nginx/client_body --http-proxy-temp-path=/var/tmp/nginx/proxy \
--http-fastcgi-temp-path=/var/tmp/nginx/fastcgi --http-uwsgi-temp-path=/var/tmp/nginx/uwsgi \
--http-scgi-temp-path=/var/tmp/nginx/scgi --with-perl_modules_path=/usr/lib/perl5/vendor_perl"

ADD nginx.conf /root/
ADD localhost.conf /root/

RUN mkdir -p /var/log/nginx /var/run/nginx/ /var/tmp/nginx/uwsgi /var/tmp/nginx/proxy /var/tmp/nginx/scgi /data/htdocs /data/php

ENV TIMEZONE Asia/Shanghai


# apk --update --repository=http://dl-4.alpinelinux.org/alpine/edge/testing add nginx nginx-mod-devel-kit nginx-mod-http-lua nginx-mod-http-lua-upstream  nginx-mod-http-geoip nginx-mod-http-perl nginx-mod-stream-geoip nginx-mod-http-upload-progress nginx-mod-rtmp nginx-mod-http-nchan nginx-mod-http-cache-purge nginx-mod-http-redis2 nginx-mod-http-headers-more nginx-mod-stream nginx-mod-http-xslt-filter  nginx-mod-http-upstream-fair nginx-mod-http-vod


ENV TENGINE_VERSION 2.2.2

ENV CONFIG "\
        --sbin-path=/usr/sbin/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
        --pid-path=/var/run/nginx.pid \
        --lock-path=/var/run/nginx.lock \
        --http-client-body-temp-path=/var/tmp/nginx/client_temp \
        --http-proxy-temp-path=/var/tmp/nginx/proxy_temp \
        --http-fastcgi-temp-path=/var/tmp/nginx/fastcgi_temp \
        --http-uwsgi-temp-path=/var/tmp/nginx/uwsgi_temp \
        --http-scgi-temp-path=/var/tmp/nginx/scgi_temp \
        --with-http_ssl_module \
        --with-http_realip_module \
        --with-http_addition_module \
        --with-http_sub_module \
        --with-http_dav_module \
        --with-http_flv_module \
        --with-http_mp4_module \
        --with-http_gunzip_module \
        --with-http_gzip_static_module \
        --with-http_random_index_module \
        --with-http_secure_link_module \
        --with-http_auth_request_module \
        --with-mail \
        --with-mail_ssl_module \
        --with-file-aio \
        --with-http_v2_module \
        --with-ipv6 \
        --with-jemalloc \
	--with-threads \
	--with-http_xslt_module \
	--with-http_image_filter_module \
	--with-http_geoip_module \
	--with-http_degradation_module \
	--with-http_slice_module \
	--with-http_stub_status_module \
	--with-http_dyups_module \  
	--with-http_lua_module \  
	--with-md5-asm \  
	--with-pcre \  
	--with-sha1-asm \  
	--with-http_dyups_lua_api "
RUN apk update && \
  apk add tzdata curl && \
  cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
  echo "${TIMEZONE}" > /etc/timezone && \
  apk add --no-cache --virtual .build-deps \
        gcc \
        libc-dev \
        make \
        openssl-dev \
        pcre-dev \
        zlib-dev \
        linux-headers geoip-dev \
        curl libxml2-dev libxslt-dev gd-dev\
	lua-dev \
        jemalloc-dev \
    && curl "http://tengine.taobao.org/download/tengine-$TENGINE_VERSION.tar.gz" -o tengine.tar.gz \
    && mkdir -p /usr/src \
    && tar -zxC /usr/src -f tengine.tar.gz \
    && rm tengine.tar.gz \
    && cd /usr/src/tengine-$TENGINE_VERSION/src/os/unix/ \
    && cd ../../../ \
#    && cd /usr/src/tengine-$TENGINE_VERSION \
    && ./configure $CONFIG --with-debug \
    && make \
    && mv objs/nginx objs/nginx-debug \
    && ./configure $CONFIG \
    && make \
    && make install \
    && rm -rf /etc/nginx/html/ \
    && mkdir /etc/nginx/conf.d/ \
    && mkdir -p /usr/share/nginx/html/ \
    && install -m644 html/index.html /usr/share/nginx/html/ \
    && install -m644 html/50x.html /usr/share/nginx/html/ \
    && install -m755 objs/nginx-debug /usr/sbin/nginx-debug \
    && strip /usr/sbin/nginx* \
    && runDeps="$( \
        scanelf --needed --nobanner /usr/sbin/nginx \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | sort -u \
            | xargs -r apk info --installed \
            | sort -u \
    )" \
    && apk add --virtual .nginx-rundeps $runDeps \
    && apk del .build-deps && apk del make && apk del wget && apk del curl && rm -rf /var/cache/apk/* \
    && rm -rf /usr/src/nginx-$NGINX_VERSION \
    && apk add --no-cache gettext \
    \
    # forward request and error logs to docker log collector
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

RUN \cp /root/nginx.conf /etc/nginx/nginx.conf && \cp /root/localhost.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]