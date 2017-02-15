bash "creating shared folder" do
  user    'deploy'
  code <<-EOH
    mkdir -p /var/www/app/shared/config
  EOH
end

template '/var/www/app/shared/config/application.yml' do
  source 'app/application.yml.erb'
  owner 'deploy'
  group 'deploy'
  mode '750'
end

template '/var/www/app/shared/config/sidekiq.yml' do
  source 'app/sidekiq.yml.erb'
  owner 'deploy'
  group 'deploy'
  mode '750'
end

