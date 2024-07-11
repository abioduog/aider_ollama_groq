#!/bin/bash

# Set up the project directory
PROJECT_DIR="/Users/abiodunogunlabi/Documents/aider"
mkdir -p $PROJECT_DIR
cd $PROJECT_DIR

# Create a virtual environment
python3 -m venv venv
source venv/bin/activate

# Install Aider and python-dotenv
pip install aider-chat python-dotenv

# Create .env file with API keys
cat <<EOL > .env
OLLAMA_API_KEY=<your_ollama_api_key>
GROQ_API_KEY=<your_groq_api_key>
EOL

# Create the main Python script
cat <<EOL > main.py
import os
import subprocess
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Access the API keys
ollama_api_key = os.getenv('OLLAMA_API_KEY')
groq_api_key = os.getenv('GROQ_API_KEY')

# Ensure the API keys are set in the environment
if ollama_api_key:
    os.environ['OLLAMA_API_KEY'] = ollama_api_key
if groq_api_key:
    os.environ['GROQ_API_KEY'] = groq_api_key

# Function to run Aider with the specified model
def run_aider(model):
    subprocess.run(['aider', '--model', model])

# Command-line argument to select the model
import argparse
parser = argparse.ArgumentParser(description='Run Aider with a specified model.')
parser.add_argument('--model', type=str, required=True, help='Specify the model to use: ollama or groq')
args = parser.parse_args()

# Run Aider with the selected model
if args.model == 'ollama':
    run_aider('ollama/deepseek-coder-v2')
elif args.model == 'groq':
    run_aider('groq/llama3-70b-8192')
else:
    print("Invalid model specified. Use 'ollama' or 'groq'.")
EOL

# Create the guide.txt file
cat <<EOL > guide.txt
### Detailed Guide to Implement Aider with Ollama and the DeepSeek-Coder-V2 Model

#### 1. Introduction
This guide will walk you through setting up and using Aider with Ollama's DeepSeek-Coder-V2 model, as well as integrating Groq's Llama 3 model. Aider is an AI pair programming tool that integrates with various language models (LLMs) to enhance your coding workflow.

#### 2. Prerequisites
- **Python**: Ensure Python is installed on your system.
- **Virtual Environment**: It's recommended to use a virtual environment to manage dependencies.

#### 3. Setting Up the Project Directory

1. **Create the Project Directory**:
   \`\`\`bash
   mkdir -p /Users/abiodunogunlabi/Documents/aider
   cd /Users/abiodunogunlabi/Documents/aider
   \`\`\`

2. **Create a Virtual Environment**:
   \`\`\`bash
   python3 -m venv venv
   source venv/bin/activate
   \`\`\`

3. **Install Aider**:
   \`\`\`bash
   pip install aider-chat
   \`\`\`

#### 4. Configuring Environment Variables

1. **Create a `.env` File**:
   \`\`\`bash
   echo 'OLLAMA_API_KEY=<your_ollama_api_key>' > .env
   echo 'GROQ_API_KEY=<your_groq_api_key>' >> .env
   \`\`\`

2. **Install `python-dotenv` to Load Environment Variables**:
   \`\`\`bash
   pip install python-dotenv
   \`\`\`

#### 5. Create a Script to Switch Between Models

1. **Create a Python Script to Load Environment Variables and Run Aider**:
   Create a file named `main.py`:
   \`\`\`python
   import os
   import subprocess
   from dotenv import load_dotenv

   # Load environment variables from .env file
   load_dotenv()

   # Access the API keys
   ollama_api_key = os.getenv('OLLAMA_API_KEY')
   groq_api_key = os.getenv('GROQ_API_KEY')

   # Ensure the API keys are set in the environment
   if ollama_api_key:
       os.environ['OLLAMA_API_KEY'] = ollama_api_key
   if groq_api_key:
       os.environ['GROQ_API_KEY'] = groq_api_key

   # Function to run Aider with the specified model
   def run_aider(model):
       subprocess.run(['aider', '--model', model])

   # Command-line argument to select the model
   import argparse
   parser = argparse.ArgumentParser(description='Run Aider with a specified model.')
   parser.add_argument('--model', type=str, required=True, help='Specify the model to use: ollama or groq')
   args = parser.parse_args()

   # Run Aider with the selected model
   if args.model == 'ollama':
       run_aider('ollama/deepseek-coder-v2')
   elif args.model == 'groq':
       run_aider('groq/llama3-70b-8192')
   else:
       print("Invalid model specified. Use 'ollama' or 'groq'.")
   \`\`\`

2. **Run the Script with the Desired Model**:
   To use Ollama:
   \`\`\`bash
   python main.py --model ollama
   \`\`\`

   To use Groq:
   \`\`\`bash
   python main.py --model groq
   \`\`\`

### Example Commands

Here's the complete set of commands to follow:

\`\`\`bash
# Step 1: Create the Project Directory
mkdir -p /Users/abiodunogunlabi/Documents/aider
cd /Users/abiodunogunlabi/Documents/aider

# Step 2: Create a Virtual Environment
python3 -m venv venv
source venv/bin/activate

# Step 3: Install Aider
pip install aider-chat

# Step 4: Create a .env File
echo 'OLLAMA_API_KEY=<your_ollama_api_key>' > .env
echo 'GROQ_API_KEY=<your_groq_api_key>' >> .env

# Step 5: Install python-dotenv
pip install python-dotenv

# Step 6: Create a Python Script to Switch Between Models
cat <<EOL > main.py
import os
import subprocess
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Access the API keys
ollama_api_key = os.getenv('OLLAMA_API_KEY')
groq_api_key = os.getenv('GROQ_API_KEY')

# Ensure the API keys are set in the environment
if ollama_api_key:
    os.environ['OLLAMA_API_KEY'] = ollama_api_key
if groq_api_key:
    os.environ['GROQ_API_KEY'] = groq_api_key

# Function to run Aider with the specified model
def run_aider(model):
    subprocess.run(['aider', '--model', model])

# Command-line argument to select the model
import argparse
parser = argparse.ArgumentParser(description='Run Aider with a specified model.')
parser.add_argument('--model', type=str, required=True, help='Specify the model to use: ollama or groq')
args = parser.parse_args()

# Run Aider with the selected model
if args.model == 'ollama':
    run_aider('ollama/deepseek-coder-v2')
elif args.model == 'groq':
    run_aider('groq/llama3-70b-8192')
else:
    print("Invalid model specified. Use 'ollama' or 'groq'.")
EOL

# Step 7: Run the Script with the Desired Model
# To use Ollama:
python main.py --model ollama

# To use Groq:
python main.py --model groq
\`\`\`

By following these steps, you can set up Aider with the ability to switch between Ollama and Groq models based on your requirements. This setup enhances your flexibility in utilizing different AI models for your coding tasks.
EOL

# Set execute permissions for the shell script
chmod +x setup_project.sh

# Run the setup script
./setup_project.sh
