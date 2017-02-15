# system packages
%w( deployer ftp utilities ).map do |r|
  include_recipe "base::#{r}"
end

# npm packages
%w( npm package webpack ).map do |r|
  include_recipe "base::#{r}"
end

# independant packages
%w( rvm nvm ).map do |r|
  include_recipe "base::#{r}"
end

# has template & config
%w( bash swap upstart nginx postgres capistrano ).map do |r|
  include_recipe "base::#{r}"
end


