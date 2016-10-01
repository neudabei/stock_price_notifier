#!/home/pi/.rvm/rubies/ruby-2.3.0/bin/ruby

require_relative 'get_stock_price'
require_relative 'watch_list_reader'

begin
  watch_list = WatchListReader.new
  investments = watch_list.watch_list
  
  investments.each do |name, investment_info|
    symbol = investment_info["symbol"]
    down_price = investment_info["down_price"]
    up_price = investment_info["up_price"]
  
    investment = StockInformation.new(symbol)
    last_trade_price = investment.last_trade_price

    # notification logic
    if  last_trade_price <= down_price
      puts "#{name} was just traded under the down price limit you set at #{down_price}. Last registered trade was at: #{last_trade_price}\n"
    elsif last_trade_price >= up_price
      puts "#{name} was just traded over the up price limit you set at #{up_price}. Last registered trade was at: #{last_trade_price}\n"
    end
  end

rescue => e
  File.open('/home/pi/ruby_scripts/stock_notifications/stock_quote_errors.txt', 'a+') { |file| file.write("#{Time.now}: #{e.inspect}\n\n") }
end
