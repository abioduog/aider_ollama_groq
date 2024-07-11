import os
import requests
import json
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Define the base URL for the API
base_url = "http://localhost:11434/api"

# Define headers
headers = {
    "Content-Type": "application/json",
    "Authorization": f"Bearer {os.getenv('OLLAMA_API_KEY')}"
}

# Define the payload for the generate endpoint
generate_payload = {
    "model": "deepseek-coder-v2",
    "prompt": "Your prompt here"
}

# Define the payload for the chat endpoint
chat_payload = {
    "model": "deepseek-coder-v2",
    "messages": [
        {"role": "user", "content": "Your message here"}
    ]
}

# Function to process streaming responses
def process_streaming_response(response):
    full_response = ""
    try:
        for line in response.iter_lines():
            if line:
                decoded_line = line.decode('utf-8')
                try:
                    data = json.loads(decoded_line)
                    print("Response:", data)
                    if 'response' in data:
                        full_response += data["response"]
                    elif 'message' in data and 'content' in data['message']:
                        full_response += data['message']['content']
                    if data.get("done"):
                        break
                except json.JSONDecodeError as e:
                    print(f"Error decoding JSON: {e}")
    except KeyboardInterrupt:
        print("Interrupted by user")
    return full_response

# Function to test the generate endpoint
def test_generate():
    try:
        response = requests.post(f"{base_url}/generate", json=generate_payload, headers=headers, stream=True, timeout=60)
        response.raise_for_status()
        full_response = process_streaming_response(response)
        print("Full Generate Response:", full_response)
    except requests.exceptions.RequestException as e:
        print(f"Error with generate endpoint: {e}")
    except requests.exceptions.Timeout:
        print("Request timed out")

# Function to test the chat endpoint
def test_chat():
    try:
        response = requests.post(f"{base_url}/chat", json=chat_payload, headers=headers, stream=True, timeout=60)
        response.raise_for_status()
        full_response = process_streaming_response(response)
        print("Full Chat Response:", full_response)
    except requests.exceptions.RequestException as e:
        print(f"Error with chat endpoint: {e}")
    except requests.exceptions.Timeout:
        print("Request timed out")

# Run tests
test_generate()
test_chat()
