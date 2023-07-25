# Author: Fariz Muradov
# email:  aze2201@gmail.com

FROM openresty/openresty
RUN apt-get update
# install dependencies
RUN apt-get install make unzip git wget build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev libbrotli-dev -y

# install luarock
WORKDIR /
RUN git clone https://github.com/luarocks/luarocks
WORKDIR luarocks
RUN ./configure && make && make install && mkdir bootstrap
WORKDIR /

# install LUA dependencies
RUN luarocks install lua-resty-http
RUN luarocks install luajit-brotli
RUN luarocks install lua-zlib
RUN luarocks install lua-cjson

# remove unnecessary packages
RUN apt-get remove --purge build-essential git unzip -y
WORKDIR luarocks
RUN mkdir uninstall
RUN make clean
RUN mkdir /etc/openresty/certs
RUN chmod 755 -R /etc/openresty/certs
