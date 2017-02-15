bash "installing nvm" do
  user 'deploy'
  code <<-EOH
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh"  ] && . "$NVM_DIR/nvm.sh"
    nvm install v7.5.0
  EOH
end
