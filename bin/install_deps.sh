# This is here so we can build with Travis; if you just want to use the
# library then you would probably be better off linking to a packaged
# version of libmarquise.

sudo apt-get install -y autoconf libtool automake build-essential libglib2.0-dev libprotobuf-c0-dev protobuf-c-compiler protobuf-compiler
mkdir -p deps/
cd deps

wget http://download.zeromq.org/zeromq-4.0.4.tar.gz
tar -xf zeromq-4.0.4.tar.gz
cd zeromq-4.0.4
./configure 
make
sudo make install
echo '/usr/local/lib' > /etc/ld.so.conf.d/local.conf
sudo ldconfig
cd ..

git clone https://github.com/anchor/libmarquise
cd libmarquise
autoreconf -i
./configure --prefix=/usr && make && make check 
sudo make install
go get code.google.com/p/goprotobuf/{proto,protoc-gen-go}
