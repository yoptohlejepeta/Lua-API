# FROM openresty/openresty:1.25.3.1-0-jammy AS base
FROM openresty/openresty:1.21.4.1-0-jammy AS base
WORKDIR /app
# RUN luarocks init
COPY . .
# RUN luarocks install lapis
# RUN ls /usr/lib | grep libcrypto
# RUN find /usr -name 'libcrypto*.so*'
# RUN luarocks install lapis CRYPTO_DIR=/usr/local/openresty/openssl/lib/libcrypto.so
# RUN luarocks install lapis CRYPTO_DIR=/usr/local/openresty/openssl/include
# RUN luarocks install lapis CRYPTO_INCDIR=/usr/local/openresty/openssl/include
# RUN luarocks install lapis CRYPTO_INCDIR=/usr/local/openresty/openssl/include OPENSSL_INCDIR=/usr/local/openresty/openssl/include
# RUN luarocks install lapis CRYPTO_INCDIR=/usr/local/openresty/openssl/include
# RUN find /usr -name 'libcrypto*.so*'
# RUN find /usr -name 'crypto*.h'
# RUN sudo apt install liblua5.1-dev
# TODO: luajit only
# RUN apt install libluajit-5.1-dev lua5.1 -y

RUN apt update
RUN apt install libsqlite3-dev git build-essential openssl -y

RUN luarocks install lapis CRYPTO_INCDIR=/usr/local/openresty/openssl/include OPENSSL_DIR=/usr/local/openresty/openssl
# RUN apk add mysql mysql-client
# RUN apk search mysql-dev
# RUN luarocks install luasql-sqlite3
# RUN luarocks install lapis LUA_INCDIR=/usr/local/include
RUN luarocks install --only-deps lua-api-dev-1.rockspec
# ENTRYPOINT [ "echo", "hello" ]
ENTRYPOINT [ "lapis", "server" ]