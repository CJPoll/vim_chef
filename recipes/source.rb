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

packages.each do |name|
	package name
end

uninstall_packages = %w{vim vim-common vim-runtime vim-tiny}

uninstall_packages.each do |name|
	package name do
		action :remove
	end
end

include_recipe "mercurial::default"

bash "install_vim" do 
	user 'root'
	code <<-EOH
	cd ~
	hg clone https://code.google.com/p/vim/
	cd vim
	hg checkout v#{version}
	./configure --with-features=huge \
				--enable-pythoninterp \
				--enable-rubyinterp \
				--enable-perlinterp \
				--enable-cscope --prefix=/usr
	make VIMRUNTIMEDIR=/usr/share/vim/vim73
	sudo make install
	EOH
end
