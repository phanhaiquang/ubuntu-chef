bash "installing utilities" do
  user    'root'
  code <<-EOH
    apt install npm
    cd ~ ; curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh ; sudo bash nodesource_setup.sh
    sudo apt-get -y install nodejs
    sudo ln -s /usr/bin/nodejs /usr/bin/node
    sudo npm install -g gulp
  EOH
end


