bash "creating www folder" do
  user    'root'
  code <<-EOH
    mkdir /var/www
    chmod 777 /var/www
  EOH
end
