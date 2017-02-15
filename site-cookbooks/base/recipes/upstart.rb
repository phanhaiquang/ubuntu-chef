bash "installing upstart" do
  user    'root'
  code <<-EOH
  sudo apt-get -y install upstart
  sudo apt-get -y install upstart-sysv
  sudo update-initramfs -u
  EOH
end

template '/etc/init/workers.conf' do
  source 'upstart/workers.conf'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/init/puma-manager.conf' do
  source 'upstart/puma-manager.conf'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/init/puma.conf' do
  source 'upstart/puma.conf'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/init/sidekiq.conf' do
  source 'upstart/sidekiq.conf'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/puma.conf' do
  source 'upstart/puma_folder.conf'
  owner 'root'
  group 'root'
  mode '0644'
end
