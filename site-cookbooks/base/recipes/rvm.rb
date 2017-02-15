bash "re-install rvm (single user)" do
  user    'deploy'
  code <<-EOH
    curl -sSL https://get.rvm.io | bash -s stable --path $HOME/.rvm
  EOH
end

template '/home/deploy/.rvmrc' do
  source 'rvmrc'
  owner 'deploy'
  group 'deploy'
  mode '0644'
end

bash "install ruby" do
  user    'deploy'
  code <<-EOH
    [[ -s "$HOME/.rvm/scripts/rvm"  ]] && source "$HOME/.rvm/scripts/rvm"
    rvm install #{settings["ruby_version"]}
    rvm use #{settings["ruby_version"]}
    rvm gemset create #{settings["ruby_gemset"]}
    rvm @#{settings["ruby_gemset"]} do gem install bundler
  EOH
end
