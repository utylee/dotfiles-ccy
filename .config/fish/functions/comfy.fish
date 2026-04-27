function comfy
	# AMD_SERIALIZE_KERNEL=3 TORCH_USE_HIP_DSA=1 \
    # env LC_ALL=C.UTF-8 \
    #     LANG=C.UTF-8 \
    #     PYTHONIOENCODING=utf-8 \
        python /home/utylee/ComfyUI/main.py \
			--max-upload-size 10240 \
            --lowvram \
			# --highvram \
            --disable-pinned-memory \
			# --dont-upcast-attention \
			# --gpu-only \
            --disable-smart-memory \
			--disable-async-offload \
            --force-fp16 \
			# --use-pytorch-cross-attention \
			# --use-split-cross-attention \
			--use-quad-cross-attention \
            --listen 0.0.0.0 $argv
end
