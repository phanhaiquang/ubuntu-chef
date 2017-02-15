# this should be installed after "npm"
bash "install webpack" do
  user    'deploy'
  code <<-EOH
    sudo npm -g i webpack
  EOH
end


