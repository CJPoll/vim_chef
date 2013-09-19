#
# Cookbook Name:: vim
# Recipe:: source
#
# Copyright 2013, Cody Poll
#
# All rights reserved - Do Not Redistribute
#

version = node['vim']['version']
bash "download_vim" do 
	code <<-EOH
	hg clone https://code.google.com/p/vim/
	cd vim
	hg checkout v#{version}
	./configure --with-features=huge \
				--enable-rubyinterp \
				--enable-pythoninterp \
				--with-python-config-dir=/usr/lib/python2.7-config \
				--enable-perlinterp \
				--enable-gui=gtk2 --enable-cscope --prefix=/usr
	make VIMRUNTIMEDIR=/usr/share/vim/vim73
	sudo make install
	EOH
end
