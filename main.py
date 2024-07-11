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
