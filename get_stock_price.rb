class StockInformation
  require 'httparty'

  def initialize(symbol)
    @symbol = symbol
    @base_uri = "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20IN%20(%22#{@symbol}%22)&format=json&env=http://datatables.org/alltables.env"
  end

  def last_trade_price
    begin
      json_stock_information_quote["LastTradePriceOnly"].to_f
    rescue NoMethodError => e
      File.open("#{__dir__}/stock_quote_errors.txt", 'a+') { |file| file.write("#{Time.now}: #{e.inspect} Couldn't parse the Json received. Probably because the API didn't return the correct object.\n\n") }
      puts
    end
  end

  private

  def yahoo_response
    tries ||= 3
    HTTParty.get(@base_uri)
  rescue
    retry unless (tries -= 1).zero?
  end

  def yahoo_response_body
    loop do
      response = yahoo_response.body
      if response != "{\"error\":{\"lang\":\"en-US\",\"description\":\"No definition found for Table yahoo.finance.quotes\"}}"
        return response
        break
      end
    end
  end

  def json_stock_information
    JSON.parse(yahoo_response_body)
  end

  def json_stock_information_quote
    json_stock_information["query"]["results"]["quote"]
  end
end
