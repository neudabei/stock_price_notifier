class WatchListReader
  require 'yaml'

  attr_reader :watch_list

  def initialize
    @watch_list = YAML.load_file("#{__dir__}/investment_watch_list.yml")
  end
end
