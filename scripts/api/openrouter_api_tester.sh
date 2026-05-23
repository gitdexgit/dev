while true; do
  TIMESTAMP=$(date '+%H:%M:%S')

  RESPONSE=$(curl -s \
    --max-time 30 \
    -o /dev/null \
    -w "%{http_code}" \
    https://openrouter.ai/api/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $(tr -d '\n' < ~/.key/OPENROUTER_API_KEY)" \
    -d '{
      "model": "nousresearch/hermes-3-llama-3.1-405b:free",
      "messages": [{"role": "user", "content": "test"}],
      "max_tokens": 10
    }')

  case "$RESPONSE" in
    200)
      echo "[$TIMESTAMP] SUCCESS: Slot found. Key works."
      break
      ;;
    401)
      echo "[$TIMESTAMP] FAIL: Auth error. Check key file content."
      break
      ;;
    429)
      echo "[$TIMESTAMP] BUSY: Rate limited/Capacity full. Retrying in 20s..."
      ;;
    000)
      echo "[$TIMESTAMP] NETWORK: Timeout or no connection."
      ;;
    *)
      echo "[$TIMESTAMP] ERROR: HTTP $RESPONSE. Retrying..."
      ;;
  esac

  sleep 20
done
