# Stock price notifications

A Ruby script to notify you when a stock is traded under or over a set price points. 
Price limits are set in the YAML file `investment_watch_list.yml`. 

The [Yahoo Query API](http://query.yahooapis.com/) is used to get the latest prices. 

Errors resulting mainly from connection problems to the Yahoo API are stored in `stock_quote_errors.txt`. 

It makes sense to run this script continuously, e.g. ever 30 min from a cronjob that emails the outputs. 

The bashscript `send_and_delete_errors.sh` is included to be set up with a cronjob as well. It ensure errors are printed to STDOUT (and can be sent via email) and deleted subsequently. 


## Instructions

```
$ bundle install
$ mv investment_watch_list_cp.yml investment_watch_list.yml
# adapt the list in investment_watch_list.yml to your interests 
# and set when you want to be notified
$ ruby stock_notifications.rb
```
