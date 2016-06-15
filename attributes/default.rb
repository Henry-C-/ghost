default['henry-ghost']['packages'] = %w(wget tar git curl htop vim firewalld)

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

default['docker']['containers'] = [
  { :name=>"ghost", :repo=>"ghost", :tag=>"latest", :volumes=>"/data/ghost:/var/lib/ghost" },
  { :name=>"caddy", :repo=>"abiosoft/caddy", :tag=>"latest", :port=>['80:80', '443:443'], :link=>"ghost:ghost", :volumes=>"/data/caddy/Caddyfile:/etc/Caddyfile" }
]
