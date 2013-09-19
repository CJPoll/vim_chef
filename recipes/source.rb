#
# Cookbook Name:: vim
# Recipe:: source
#
# Copyright 2013, Cody Poll
#
# All rights reserved - Do Not Redistribute
#

version = node[:version]
Chef::Application.fatal!("Version: #{version}", return_code)
