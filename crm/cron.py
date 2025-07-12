from datetime import datetime
import requests

def log_crm_heartbeat():
    # Format timestamp
    timestamp = datetime.now().strftime("%d/%m/%Y-%H:%M:%S")
    message = f"{timestamp} CRM is alive"

    # Append to log file
    with open("/tmp/crm_heartbeat_log.txt", "a") as f:
        f.write(message + "\n")

    # Optional: GraphQL ping
    try:
        response = requests.post("http://localhost:8000/graphql", json={
            "query": "{ hello }"
        })
        if response.status_code == 200:
            print("GraphQL hello field responded")
        else:
            print("GraphQL response error")
    except Exception as e:
        print(f"GraphQL query failed: {e}")
