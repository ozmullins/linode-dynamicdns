require 'net/http'

##
# Script to update a DNS record on your linode account to provide a dynamic dns service
# this can easily be setup as a cron job.
# 0 * * * * ruby /path/to/script/linode_update.rb

##
# Get the domain ID from going to linode and then 'Zone file', it is the number in the
# brackets next to your domain.
DOMAIN_ID = 1111

##
# Create a AAAA record and give it a name
# record the ?id=#### here
RESOURCE_ID = 12345

##
# You will have to goto your profile and generate a secret API key for this.
# You will be required to set your API_KEY to your key in your environment variables or
# directly replace here
API_KEY = ENV["API_KEY"]

##
# Requests from dyndns and extracts IP address. If you have your own server
# you could setup a page that returns the IP eg:
# @ip = request.remote_ip # in a controller action and display this on the view
# replace url with url to that page.
IP = Net::HTTP.get(URI.parse('http://checkip.dyndns.org:8245/')).
    scan(/\d+\.\d+\.\d+\.\d+/).first

uri = URI("https://api.linode.com/?api_key=#{API_KEY}&" \
    "api_action=domain.resource.update" \
    "&domainid=#{DOMAIN_ID}&resourceid=#{RESOURCE_ID}&target=#{IP}")

puts Net::HTTP.get(uri)
