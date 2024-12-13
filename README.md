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


```bash
docker run --runtime nvidia --gpus all \
-v ./cache:/root/.cache \
-p 8000:8000 \
--ipc=host \
vllm/vllm-openai:latest \
--model Aratako/sarashina2.1-1b-sft
```

```bash
curl http://deep01:8002/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gpt-4o-mini",
    "messages": [
      {
        "role": "user",
        "content": [
          {
            "type": "text",
            "text": "この画像には何人の人がいますか？"
          },
          {
            "type": "image_url",
            "image_url": {
              "url": "data:image/jpeg;base64,'$(base64 -i test.jpg)'"
            }
          }
        ]
      }
    ],
    "max_tokens": 300
  }'
```
