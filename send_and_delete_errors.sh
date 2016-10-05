DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
errors_file=$DIR/stock_quote_errors.txt

if [ -f $errors_file ]
then
    echo `cat $errors_file`
    rm  $errors_file
fi