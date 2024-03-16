#!/bin/bash

# Function to update INDEX.md in a directory
update_index() {
    local directory="$1"
    local index_file="$directory/INDEX.md"

    # Check if INDEX.md exists in the directory
    if [ ! -f "$index_file" ]; then
        echo "INDEX.md not found in $directory. Skipping..."
        return
    fi

    # Empty the existing INDEX.md file
    > "$index_file"

    # Add new content to INDEX.md
    echo "# 🗓️ $(basename "$directory")" >> "$index_file"
    echo -e "\n## 📢 Meetups\n" >> "$index_file"
    for meetup_dir in "$directory"/*/; do
        local meetup_name=$(basename "$meetup_dir")
        local meetup_link=$(printf '%s' "$meetup_name" | sed 's/ /%20/g')
        echo "- [$meetup_name]($meetup_link/INDEX.md)" >> "$index_file"
    done

    echo "INDEX.md updated in $directory."
}

# Main loop to update INDEX.md in all directories
root_directory="."
for directory in "$root_directory"/*/; do
    update_index "$directory"
done
