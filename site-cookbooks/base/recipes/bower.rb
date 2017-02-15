bash "install bower" do
  user    'deploy'
  code <<-EOH
    npm install bower -g
  EOH
end
