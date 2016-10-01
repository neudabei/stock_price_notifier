class StockInformation
  require 'httparty'

  def initialize(symbol)
    @symbol = symbol
    @base_uri = base_uri = "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20IN%20(%22#{@symbol}%22)&format=json&env=http://datatables.org/alltables.env"
  end

  def last_trade_price
    json_stock_information_quote["LastTradePriceOnly"].to_f
  end

  private

  def yahoo_response
    tries ||= 3
    HTTParty.get(@base_uri)
  rescue
    retry unless (tries -= 1).zero?
  end

  def yahoo_response_body
    yahoo_response.body
  end

  def json_stock_information
    JSON.parse(yahoo_response_body)
  end

  def json_stock_information_quote
    json_stock_information["query"]["results"]["quote"]
  end
end
