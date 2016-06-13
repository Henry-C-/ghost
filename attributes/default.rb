
default['henry-ghost']['users']          = [
  { :name=>"apps", :uid=>1550, :gid=>1550, :home=>"/home/apps" },
  { :name=>"henry", :uid=>1551, :gid=>1551, :home=>"/home/henry"}
]

default['appserver']['packages'] = %w(wget tar git autofs samba samba-client cifs-utils curl htop vim firewalld)

default['henry-ghost']['repositories']   = [
  { :reponame=>"epel", :repodescription=>"Extra Packages for Enterprise Linux", :repobaseurl=>"http://mirrors.ukfast.co.uk/sites/dl.fedoraproject.org/pub/epel/7/x86_64/", :repogpgkey=>"http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7"}
]

default['firewalld']['enable_firewalld'] = true

default['firewalld']['firewalld_services']       =  [
  { :fwservice=>"ssh", :fwzone=>"public" }, # SSH
  { :fwservice=>"http", :fwzone=>"public" }, # Caddy
  { :fwservice=>"https", :fwzone=>"public" } # Caddy
]

default['docker']['images']    = [
  { :name=>"ghost", :tag=>"latest" },
  { :name=>"abiosoft/caddy", :tag=>"latest" }
]
