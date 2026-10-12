docker rm -f NuevaNetWEB


docker run -d --name NuevaNetWEB -p 80:80 \
  --cpus="0.5" \
  --memory="80m" \
  --memory-swap="128m" \
  --pids-limit=100 \
  --read-only \
  --tmpfs /usr/local/apache2/logs:rw,size=16m \
  dockerfile:tercera

