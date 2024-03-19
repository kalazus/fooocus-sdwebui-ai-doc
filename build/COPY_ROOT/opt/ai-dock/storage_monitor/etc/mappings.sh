# Key is relative to $WORKSPACE/storage/

declare -A storage_map

webui_models="/opt/stable-diffusion-webui/models/"
fooocus_models="/opt/Fooocus/models/"

storage_map["stable_diffusion/models/ckpt"]="${webui_models}Stable-diffusion ${fooocus_models}checkpoints"
storage_map["stable_diffusion/models/codeformer"]="${webui_models}Codeformer"
storage_map["stable_diffusion/models/controlnet"]="${webui_models}ControlNet ${fooocus_models}controlnet"
storage_map["stable_diffusion/models/deepbooru"]="${webui_models}deepbooru"
storage_map["stable_diffusion/models/dreambooth"]="${webui_models}dreambooth"
storage_map["stable_diffusion/models/esrgan"]="${webui_models}ESRGAN"
storage_map["stable_diffusion/models/gfpgan"]="${webui_models}GFPGAN"
storage_map["stable_diffusion/models/hypernetworks"]="${webui_models}hypernetworks"
storage_map["stable_diffusion/models/insightface"]="${webui_models}insightface"
storage_map["stable_diffusion/models/karlo"]="${webui_models}karlo"
storage_map["stable_diffusion/models/ldsr"]="${webui_models}LDSR"
storage_map["stable_diffusion/models/lora"]="${webui_models}Lora ${fooocus_models}loras"
storage_map["stable_diffusion/models/reactor"]="${webui_models}reactor"
storage_map["stable_diffusion/models/swinIR"]="${webui_models}swinIR"
storage_map["stable_diffusion/models/vae"]="${webui_models}VAE ${fooocus_models}vae"
storage_map["stable_diffusion/models/vae_approx"]="${webui_models}VAE-approx ${fooocus_models}vae_approx"

# Add more mappings for other repository directories as needed