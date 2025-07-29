#!/bin/bash

set -e

# Try to get API key from environment variable first
if [ -n "$VITE_SKYVERN_API_KEY" ]; then
    echo "Using API key from environment variable"
    export VITE_SKYVERN_API_KEY
elif [ -f ".streamlit/secrets.toml" ]; then
    echo "Using API key from secrets.toml file"
    VITE_SKYVERN_API_KEY=$(sed -n 's/.*cred\s*=\s*"\([^"]*\)".*/\1/p' .streamlit/secrets.toml)
    export VITE_SKYVERN_API_KEY
else
    echo "Warning: No API key found in environment variable or secrets.toml file"
    echo "Please set VITE_SKYVERN_API_KEY environment variable"
    export VITE_SKYVERN_API_KEY=""
fi

npm run start


