#
# Cookbook Name:: henry-ghost
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

repovars = node['henry-ghost']['repositories']
imgvars  = node['docker']['images']
contvars = node['docker']['containers']
fwsvars  = node['firewalld']['firewalld_services']

selinux_state "Disable SELinux" do
  action :disabled
end

repovars.each do |createrepos|
  yum_repository createrepos[:reponame] do
    description createrepos[:repodescription]
    baseurl createrepos[:repobaseurl]
    gpgkey createrepos[:repogpgkey]
    action :create
  end
end

node['henry-ghost']['packages'].each do |package_name|
  package package_name do
    action :install
  end
end

service "firewalld" do
  action [:enable, :start]
  only_if { node['firewalld']['enable_firewalld'] }
end

service "firewalld" do
  not_if { node['firewalld']['enable_firewalld'] }
  action [:disable, :stop]
end

fwsvars.each do |fwsconf|
  firewalld_service fwsconf[:fwservice] do
    action :add
    zone fwsconf[:fwzone]
    only_if { node['firewalld']['enable_firewalld'] }
  end
end

directory "/data" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

execute "untar data" do
  command "/bin/tar xzf /root/data.tar.gz -C /data/ ."
end

docker_service 'default' do
  action [:create, :start]
end

imgvars.each do |dimages|
  docker_image dimages[:name] do
    tag dimages[:tag]
    action :pull
  end
end

contvars.each do |containers|
 docker_container containers[:name] do
   repo containers[:repo]
   tag containers[:tag]
   port containers[:port]
   links containers[:link]
   volumes containers[:volumes]
   restart_policy 'always'
 end
end
