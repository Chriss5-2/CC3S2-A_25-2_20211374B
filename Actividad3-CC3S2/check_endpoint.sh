#!/usr/bin/env bash

URL="http://127.0.0.1:8080"
HOST=$(echo "$URL" | awk -F/ '{print $3}' | cut -d: -f1)
PORT=$(echo "$URL" | awk -F/ '{print $3}' | cut -d: -f2)
THRESHOLD_LATENCY=0.5   # segundos

echo "Verificando endpoint: $URL"

# 1. DNS/Reachability
if ! ping -n 1 "$HOST" >/dev/null 2>&1; then
  echo "Fallo en resolución DNS/host $HOST"; exit 1
fi
echo "Host $HOST alcanzable"

# 2. TLS (solo si es https)
if [[ "$URL" == https* ]]; then
  if ! echo | openssl s_client -connect "$HOST:$PORT" -tls1_3 2>/dev/null | grep -q "Protocol  : TLSv1.3"; then
    echo "TLS < 1.3 o handshake fallido"; exit 1
  fi
  echo "TLS 1.3 válido"
else
  echo "Saltando verificación TLS (URL es HTTP)"
fi

# 3. HTTP status
HTTP_CODE=$(curl -sk -o /dev/null -w "%{http_code}" "$URL")
if [[ "$HTTP_CODE" -ne 200 ]]; then
  echo "HTTP code $HTTP_CODE"; exit 1
fi
echo "HTTP 200 recibido"

# 4. Latencia
LATENCY=$(curl -sk -o /dev/null -w "%{time_total}" "$URL")
if awk "BEGIN {exit !($LATENCY > $THRESHOLD_LATENCY)}"; then
  echo "Latencia $LATENCY s > umbral $THRESHOLD_LATENCY s"; exit 1
fi
echo "Latencia $LATENCY s dentro del umbral"


echo "Endpoint validado con éxito"
