require 'rubygems'
require 'open-uri'
require 'simple-rss'
require 'htmlentities'

rss = SimpleRSS.parse open('http://twitrss.me/twitter_user_to_rss/?user=IdarVassdal')
rss.entries.each do |entry|
  date_time = '(' + entry.pubDate.strftime('%d %b %Y, %H:%M') + ')'
  #seperate tweet text and author (first colon does the job)
  tweet = entry.title.to_s.split(':', 2)
  #Run through HTMLEntities to make pretty. Start all new lines with tab
  puts HTMLEntities.new.decode (tweet.first + ' ' + date_time + "\n\t" + tweet.last.gsub("\n", "\n\t"))
end


