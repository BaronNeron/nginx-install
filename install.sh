CUR=$(pwd)
sudo apt-get install libyajl-dev
sudo apt-get install libmsgpuck-dev
sudo apt-get install libpcre++0 gcc unzip libpcre3-dev zlib1g-dev libssl-dev libxslt-dev

git clone http://luajit.org/git/luajit-2.0.git
cd luajit-2.0
make && sudo make install
ln -s /usr/local/lib/libluajit-5.1.so.2.0.3 /usr/lib/libluajit-5.1.so.2

cd ../ && git clone https://github.com/tarantool/nginx_upstream_module.git

git clone https://github.com/simplresty/ngx_devel_kit.git

git clone https://github.com/openresty/lua-nginx-module.git

export LUAJIT_LIB=/usr/lib
export LUAJIT_INC=$CUR/luajit-2.0/src

wget https://nginx.ru/download/nginx-1.14.0.tar.gz
tar -xzf nginx-1.14.0.tar.gz
rm nginx-1.14.0.tar.gz
cd nginx-1.14.0

./configure --with-ld-opt="-Wl,-rpath,/usr/lib" \
            --add-module=$CUR/nginx_upstream_module \
            --add-module=$CUR/ngx_devel_kit \
            --add-module=$CUR/lua-nginx-module
make && sudo make install

sudo chmod 777 /usr/local/nginx/conf/nginx.conf
