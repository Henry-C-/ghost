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
