errors_file=/home/pi/ruby_scripts/stock_notifications/stock_quote_errors.txt

if [ -f $errors_file ]
then
    cat $errors_file
    rm  $errors_file
fi