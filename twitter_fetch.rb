require 'rubygems'
require 'open-uri'
require 'simple-rss'
require 'htmlentities'

rss = SimpleRSS.parse open('http://twitrss.me/twitter_user_to_rss/?user=IdarVassdal.json')
rss.entries.each do |entry|
  tweet = entry.title.to_s.split(':', 2)
  puts HTMLEntities.new.decode (tweet.first + "\n\t" + tweet.last.gsub("\n", "\n\t"))
end


