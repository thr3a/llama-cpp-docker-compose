```yaml
lora:
  image: ghcr.io/ggerganov/llama.cpp:server-cuda
  volumes:
    - ./cache:/root/.cache
    - ./:/app
  ports:
    - "8000:8000"
  deploy:
    resources:
      reservations:
        devices:
          - driver: nvidia
            # device_ids: ['0']
            capabilities: [ gpu ]
  tty: true
  stop_grace_period: 0s
  entrypoint: ''
  environment:
    TZ: Asia/Tokyo
  command: >
    /llama-server
    --host 0.0.0.0
    --port 8000
    --hf-repo grapevine-AI/gemma-2-2b-jpn-it-gguf
    --hf-file gemma-2-2B-jpn-it-Q8_0.gguf
    --threads 8
    --n-gpu-layers 99
    --ctx-size 4096
    -a gpt-4o-mini
    --lora /app/zunda-LoRA.gguf
```
