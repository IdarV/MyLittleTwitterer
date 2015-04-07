require 'rubygems'
require 'open-uri'
require 'simple-rss'
require 'htmlentities'
require 'green_shoes'

puts 'Twitter username: '
#user = gets
user = 'IdarVassdal'
index = 0

rss = SimpleRSS.parse open('http://twitrss.me/twitter_user_to_rss/?user=' + user)
Shoes.app(title: 'myLittleTweeter', width: 600, height: 900) do
  flow do
    @editline = edit_line
    @push = button 'Fetch tweets'
    @push.click {

    }
  end
  rss.entries.each do |entry|
    date_time = "(#{entry.pubDate.strftime('%d %b %Y, %H:%M')})"
    #seperate tweet text and author (first colon does the job)
    tweet = entry.title.to_s.split(':', 2)
    #Run through HTMLEntities to make pretty. Start all new lines with tab
    text = HTMLEntities.new.decode (tweet.first + ' ' + date_time + "\n\t" + tweet.last.gsub("\n", "\n\t"))
    flow do
      if index.even?
        background lightblue
      else
        background lightgreen
      end
      index += 1
      @para = para text
    end
  end


end

