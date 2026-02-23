#perl 관련옵션이 컴파일 중 에러가 나서 실제로 perl 관련 컨피그는 제거하고 컴파일했습니다

# 아래 사이트를 참고해서 서비스 스크립트까지 설치하도록 합니다
# https://github.com/utylee/nginx-sysvinit-script
./configure \
--sbin-path=/usr/local/sbin/nginx \
--prefix=/usr/share/nginx \
--conf-path=/etc/nginx/nginx.conf \
--error-log-path=/var/log/error.log \
--http-log-path=/var/log/access.log \
--pid-path=/var/run/nginx.pid \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_xslt_module \
--with-http_image_filter_module \
--with-http_geoip_module \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_auth_request_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_slice_module \
--with-http_degradation_module \
--with-http_stub_status_module \
--with-mail \
--with-mail_ssl_module \
--with-stream \
--with-stream_ssl_module \
--with-google_perftools_module \
--with-cpp_test_module \
--with-debug
#--with-http_perl_module \
