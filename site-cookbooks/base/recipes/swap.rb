swap_file '/var/swapfile' do
  size    settings['swapfile']
  persist true
end
