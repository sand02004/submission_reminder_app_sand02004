#!/bin/bash

# Ask for user's name
echo -n "Enter your name: "
read userName

# Define the base directory with user's name
BASE_DIR="submission_reminder_${userName}"

# Define the required directories
DIRS=(
    "$BASE_DIR/app"
    "$BASE_DIR/config"
    "$BASE_DIR/modules"
    "$BASE_DIR/assets"
)

# Define the required files and their locations
FILES=(
    "$BASE_DIR/assets/submissions.txt"
    "$BASE_DIR/config/config.env"
    "$BASE_DIR/app/reminder.sh"
    "$BASE_DIR/modules/functions.sh"
    "$BASE_DIR/startup.sh"
)

# Create directories
for dir in "${DIRS[@]}"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo "Created directory: $dir"
    else
        echo "Directory already exists: $dir"
    fi
done

# Create empty files
for file in "${FILES[@]}"; do
    if [ ! -f "$file" ]; then
        touch "$file"
        echo "Created file: $file"
    else
        echo "File already exists: $file"
    fi
done

# Populate submissions.txt with sample data
echo -e "StudentID,Name,Assignment,Deadline,Status" > "$BASE_DIR/assets/submissions.txt"
echo -e "001,John Doe,Math,2024-02-20,Pending" >> "$BASE_DIR/assets/submissions.txt"
echo -e "002,Jane Smith,Science,2024-02-22,Submitted" >> "$BASE_DIR/assets/submissions.txt"
echo -e "003,Mark Lee,History,2024-02-25,Pending" >> "$BASE_DIR/assets/submissions.txt"
echo -e "004,Susan Brown,English,2024-02-18,Submitted" >> "$BASE_DIR/assets/submissions.txt"
echo -e "005,Tom Hanks,Physics,2024-02-27,Pending" >> "$BASE_DIR/assets/submissions.txt"

echo "Populated submissions.txt with sample student records."

# Set executable permissions for script files
chmod +x "$BASE_DIR/app/reminder.sh"
chmod +x "$BASE_DIR/modules/functions.sh"
chmod +x "$BASE_DIR/startup.sh"

echo "Environment setup complete."
