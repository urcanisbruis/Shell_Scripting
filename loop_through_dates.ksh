#!/bin/bash

# Start and end dates
start_date="2024-01-01"
end_date="2024-01-10"

# Convert start and end dates to seconds since 1970-01-01
start_seconds=$(date -d "$start_date" +%s)
end_seconds=$(date -d "$end_date" +%s)

# Loop through each day from start date to end date
current_seconds=$start_seconds
while [ $current_seconds -le $end_seconds ]; do
  # Convert current seconds to date in yyyy-mm-dd format
  current_date=$(date -d "@$current_seconds" +%Y-%m-%d)

  # Run SQL query using bteq with the current date as a parameter
  bteq <<EOF
  .LOGON your_server/your_user, your_password;

  SELECT * FROM your_table
  WHERE your_date_column = '$current_date';

  .LOGOFF;
  .QUIT;
EOF

  # Move to the next day (add 86400 seconds = 1 day)
  current_seconds=$(($current_seconds + 86400))
done
