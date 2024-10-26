docker run --rm --entrypoint=/app/convert_lora_to_gguf.py \
-v /home/thr3a/zundamon/output/zunda:/input \
-v ./:/output \
ghcr.io/ggerganov/llama.cpp:full \
--base /output/gemma-2-2b-jpn-it --outfile /output/zunda-LoRA.gguf /input
