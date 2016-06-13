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
