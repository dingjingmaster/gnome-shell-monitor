checkcommand()
{
	command -v "$1" > /dev/null 2>&1
}

# This will print three lines. The first one is the the total vRAM available,
# the second one is the used vRAM and the third on is the GPU usage in %.
if checkcommand nvidia-smi; then
	nvidia-smi -i 0 --query-gpu=memory.total,memory.used,utilization.gpu --format=csv,noheader,nounits | while IFS=', ' read -r a b c; do echo "$a"; echo "$b"; echo "$c"; done
elif checkcommand glxinfo; then
	TOTALVRAM=$(glxinfo | grep -A2 -i GL_NVX_gpu_memory_info | grep -E -i "dedicated" | cut -f2- -d ':' | gawk '{print $1}')
	AVAILVRAM=$(glxinfo | grep -A4 -i GL_NVX_gpu_memory_info | grep -E -i "available dedicated" | cut -f2- -d ':' | gawk '{print $1}')
	FREEVRAM=$((TOTALVRAM-AVAILVRAM))
	echo "$TOTALVRAM"
	echo "$FREEVRAM"
fi
