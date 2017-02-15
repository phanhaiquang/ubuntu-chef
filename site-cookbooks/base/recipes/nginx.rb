bash "installing nginx" do
  user    'root'
  code <<-EOH
    sudo apt-get install -y nginx
    sudo apt-get install -y nginx-extras passenger
  EOH
end

template '/etc/nginx/sites-available/default' do
  source 'nginx/default.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

#bash "restart nginx" do
#  user    'root'
#  code <<-EOH
#    sudo service nginx restart
#  EOH
#end
