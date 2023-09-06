# path to output file
output_file="output.csv"

# path to input file
input_file="events.csv"

# if statement to avoid error in ts column
if ./clickhouse client --query "INSERT INTO EventsTest FORMAT CSV" < "$input_file"; then
    echo "Success"
else
    if [ $? -eq 27 ]; then
        echo "Error type - 27"
        # Use awk for for change date format
        awk -F, 'BEGIN {OFS=","} {gsub(/\.[0-9]+/,"",$3); print}' "$input_file" > "$output_file"
        echo "Date format fixed, file - $output_file"
        ./clickhouse client --query "INSERT INTO EventsTest FORMAT CSV" < "$output_file"
        echo "Success after fix"
    else
        echo "Something went wrong, pls check"
    fi
fi

