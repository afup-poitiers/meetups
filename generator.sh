#!/bin/bash

# Function to create folder if it doesn't exist
create_folder() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi
}

# Ask for date in YYYY-MM-DD format
read -p "Date de l'événement (YYYY-MM-DD): " date_input

# Validate date format
if ! [[ $date_input =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    echo "Le format de la date n'est pas correct. Voici le format attendu: YYYY-MM-DD."
    exit 1
fi

# Ask for phrase of 32 characters max
read -p "Description courte (max 32 caractères): " phrase_input

# Validate phrase length
if [[ ${#phrase_input} -gt 32 ]]; then
    echo "La longueur maximale de 32 caractères est dépassée."
    exit 1
fi

# Extract year from input
year=$(echo "$date_input" | cut -d'-' -f1)

# Create folder with year if it doesn't exist
folder_path="$year/$date_input $phrase_input"
create_folder "$folder_path"

# Create default content for INDEX.md
index_content="# $phrase_input

Courte description du meetup

## 📜 Description

Description avancée du sujet du meetup.

- [TWITTER](https://twitter.com/speaker_username)

## 📂 Documents

Documents transmit par le speaker.

## 💖 Sponsors

- ..."

# Write default content to INDEX.md file in the folder
echo "$index_content" > "$folder_path/INDEX.md"

echo "Fichier INDEX.md créé dans le répertoire $folder_path."
