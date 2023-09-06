output_file="output.csv"

# input csv file
input_file="events.csv"

# if statement for avoid error in ts column
if ./clickhouse client --query "INSERT INTO EventsTest FORMAT CSV" < "$input_file"; then
    echo "Success"
else
    if [ $? -eq 27 ]; then
        echo "Error type: 27"
        # Path to python script
	      python_script="./fix_date_format.py"
	      # launch python script
	      python3 "$python_script"
        echo "Date format fixed, file -  $output_file"
        ./clickhouse client --query "INSERT INTO EventsTest FORMAT CSV" < "$output_file"
        echo "Success after fix"
    else
        echo  "Something went wrong, pls check"
    fi
fi

