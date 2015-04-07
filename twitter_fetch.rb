require 'rubygems'
require 'open-uri'
require 'simple-rss'
require 'htmlentities'
require 'green_shoes'

puts 'Program started'
$user = 'justinbieber'

def get_rss_feed_as_string(name)
  puts 'fetching RSS for user ' + name
  begin
    rss = SimpleRSS.parse open('http://twitrss.me/twitter_user_to_rss/?user=' + name)
  rescue
    return 'User not found'
  end
  puts '..successful'
  all_tweets = ''
  rss.entries.each do |entry|
    date_time = "(#{entry.pubDate.strftime('%d %b %Y, %H:%M')})"
    #seperate tweet text and author (first colon does the job)
    tweet = entry.title.to_s.split(':', 2)
    #Run through HTMLEntities to make pretty. Start all new lines with tab
    text = tweet.first + ' ' + date_time + "\n\t" + tweet.last.gsub("\n", "\n\t")
    all_tweets += text + "\n\n"
  end
  puts all_tweets
  all_tweets.to_s
end

Shoes.app(title: 'myLittleTweeter', width: 600, height: 900) do
  flow do
    @para = para 'Enter twitter username: '
    @edit_line = edit_line
    @push = button 'Fetch tweets'
    @para = para "\n"
    @push.click {
      nextusername = @edit_line.text.to_s
      puts 'next username is ' + nextusername
      nextText = get_rss_feed_as_string(nextusername.to_s)
      @para.replace nextText
    }
    @para = para get_rss_feed_as_string($user)
  end

end



