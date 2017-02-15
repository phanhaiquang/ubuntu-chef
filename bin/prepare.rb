#!/usr/bin/ruby

require 'json'

fn = ARGV[0]
data = JSON.parse(File.read(fn))
ip = data['deployment']['host']
`cp #{fn} ./nodes/#{ip}.json`
puts `knife solo prepare deploy@#{ip} | tee tmp/#{ip}-knife-solo-prepare.log`
