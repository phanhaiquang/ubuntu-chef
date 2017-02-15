ruby_block "set_rails_env" do
  block do
    file = Chef::Util::FileEdit.new("/home/deploy/.bashrc")
    [
      'export RAILS_ENV="production"',
      'export RACK_ENV="production"'
    ].each do |line|
      file.insert_line_if_no_match(line, line)
    end
    file.write_file
  end
end

template '/home/deploy/.bash_aliases' do
  source 'bash_alias'
  owner 'deploy'
  group 'deploy'
  mode '700'
end
