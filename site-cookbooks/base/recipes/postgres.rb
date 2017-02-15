bash "create postgres user" do
  user    'root'
  code <<-EOH
    sudo -u postgres psql -c "create user #{settings['postgres']['user']} createdb createuser password '#{settings['postgres']['password']}';"
  EOH
end

template '/etc/postgresql/9.3/main/pg_hba.conf' do
  source 'postgresql/pg_hba.conf.erb'
  owner 'postgres'
  group 'postgres'
  mode '600'
end

bash "create postgres user" do
  user    'root'
  code <<-EOH
    sudo service postgresql restart
  EOH
end
