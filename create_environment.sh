#!/bin/bash

# Prompt user for their name
echo "Enter your name:"
read user_name

# Define the main directory
dir_name="submission_reminder_${user_name}"

# Create the main directory
mkdir -p "$dir_name"/{app,modules,assets,config}

# Create required files
touch "$dir_name/app/reminder.sh"
touch "$dir_name/modules/functions.sh"
touch "$dir_name/assets/submissions.txt"
touch "$dir_name/config/config.env"
touch "$dir_name/startup.sh"

# Populate submissions.txt with sample records
cat << EOF > "$dir_name/assets/submissions.txt"
Student,Assignment,Submission Status
Chinemerem,Shell Navigation,Not Submitted
Chiagoziem,Git,Submitted
Divine,Shell Navigation,Not Submitted
Anissa,Shell Basics,Submitted
Kamali Shell Navigation,Submitted
Keza, Shell Navigation,Submitted
John, Shell Navigation, Not Submitted
Ruth,Shell Navigation, Not Submitted 
Joy, Shell Nvigation, Not Submitted
EOF

# Populate functions.sh with logic to check submissions
cat << EOF > "$dir_name/modules/functions.sh"
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=\$1
    echo "Checking submissions in \$submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=\$(echo "\$student" | xargs)
        assignment=\$(echo "\$assignment" | xargs)
        status=\$(echo "\$status" | xargs)

        # Check if assignment matches and status is 'Not Submitted'
        if [[ "\$assignment" == "\$ASSIGNMENT" && "\$status" == "Not Submitted" ]]; then
            echo "Reminder: \$student has not submitted the \$ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "\$submissions_file") # Skip the header
}
EOF
# Make functions.sh executable
chmod +x "$dir_name/modules/functions.sh"

# Populate reminder.sh with script logic
cat << EOF > "$dir_name/app/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: \$ASSIGNMENT"
echo "Days remaining to submit: \$DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions \$submissions_file
EOF

# Make reminder.sh executable
chmod +x "$dir_name/app/reminder.sh"


# Populate config.env with environment variables
cat << EOF > "$dir_name/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Populate startup.sh with logic to start the reminder app
cat << EOF > "$dir_name/startup.sh"
#!/bin/bash

# Navigate to the app directory
cd "\$(dirname "\$0")"

# Run the reminder script
bash app/reminder.sh
EOF

# Make the startup script executable
chmod +x "$dir_name/startup.sh"

# Notify user of completion
echo "Environment setup completed successfully in $dir_name"
cd $dir_name
./startup.sh
