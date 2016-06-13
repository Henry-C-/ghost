#
# Cookbook Name:: henry-ghost
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# --- Attribute Definitions
uservars = node['henry-ghost']['users']
repovars = node['henry-ghost']['repositories']



# --- Add Required Users

uservars.each do |createusers|
  group createusers[:name] do
    gid createusers[:gid]
  end

  user createusers[:name] do
    home createusers[:home]
    uid createusers[:uid]
    gid createusers[:gid]
    system false
    shell '/bin/bash'
  end
end

# --- Install Required Yum Repo's

repovars.each do |createrepos|
  yum_repository createrepos[:reponame] do
    description createrepos[:repodescription]
    baseurl createrepos[:repobaseurl]
    gpgkey createrepos[:repogpgkey]
    action :create
  end
end

# --- Install base packages

node['henry-ghost']['packages'].each do |package_name|
  package package_name do
    action :install
  end
end

# --- Configure Firewalld

service "firewalld" do
  action [:enable, :start]
  only_if { node['firewalld']['enable_firewalld'] }
end

service "firewalld" do
  not_if { node['firewalld']['enable_firewalld'] }
  action [:disable, :stop]
end

fwpvars.each do |fwpconf|
  firewalld_port fwpconf[:fwport] do
    action :add
    zone fwpconf[:fwzone]
    only_if { node['firewalld']['enable_firewalld'] }
  end
end

fwsvars.each do |fwsconf|
  firewalld_service fwsconf[:fwservice] do
    action :add
    zone fwsconf[:fwzone]
    only_if { node['firewalld']['enable_firewalld'] }
  end
end

# --- Beginning of Docker Config

docker_service 'default' do
  action [:create, :start]
end
