#
# Cookbook Name:: vim
# Recipe:: source
#
# Copyright 2013, Cody Poll
#
# All rights reserved - Do Not Redistribute
#

version = node['vim']['version']

packages = case node['platform_family']
		   when 'rhel'
			   %w(python-devel)
		   else
			   %w(python-dev)
		   end

bash "install_cmake" do
	user 'root'
	code <<-EOH
	wget http://www.cmake.org/files/v2.8/cmake-2.8.11.2.tar.gz
	tar -zxf cmake-*
	cd cmake-* && ./configure && make && make install
	EOH
end

bash "install_vim" do 
	user 'root'
	code <<-EOH
	hg clone https://code.google.com/p/vim/
	cd vim
	hg checkout v#{version}
	./configure --with-features=huge \
				--enable-pythoninterp \
				--enable-cscope --prefix=/usr
	make VIMRUNTIMEDIR=/usr/share/vim/vim73
	make install
	EOH
end
