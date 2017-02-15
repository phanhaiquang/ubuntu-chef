bash "installing utilities" do
  user    'root'
  code <<-EOH
    sudo apt-get -y install tree
    sudo apt-get -y install postgresql-server-dev-9.3
    sudo apt-get -y install build-essential
    sudo apt-get -y install default-jre
    sudo apt-get -y install default-jdk
    sudo apt-get -y install unzip
  EOH
end
