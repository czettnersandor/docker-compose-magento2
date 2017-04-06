#!/usr/bin/env ruby

# this library can be used to fetch files from sftp. Install it by
# `gem install net-sftp`
require 'net/sftp'

devdir = File.dirname(__FILE__)
password = File.open(Dir.home+"/.cohesion-db-password") {|f| f.readline}
password.gsub!(/(\r|\n)+/,"")

session = Net::SSH.start('git.healthywebsites.co.uk', 'databases', {:password => password, :port => 2222, :non_interactive => true})
sftp = Net::SFTP::Session.new(session).connect!
sftp.download!('/uploads/cotswold/data.tar.gz', devdir+'/data.tar.gz')

Dir.chdir(devdir)
system('tar xf data.tar.gz')
