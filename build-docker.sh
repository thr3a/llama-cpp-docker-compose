# docker build --pull=never -f ./amd-strix-halo-toolboxes/toolboxes/Dockerfile.vulkan-amdvlk -t vulkan-amdvlk:1.0 ./amd-strix-halo-toolboxes/toolboxes
DOCKER_BUILDKIT=1 docker build --pull=false -f ./amd-strix-halo-toolboxes/toolboxes/Dockerfile.vulkan-amdvlk -t vulkan-amdvlk:1.0 ./amd-strix-halo-toolboxes/toolboxes
# DOCKER_BUILDKIT=1 docker build --pull=false -f ./amd-strix-halo-toolboxes/toolboxes/Dockerfile.vulkan-amdvlk -t vulkan-amdvlk:1.0 ./amd-strix-halo-toolboxes/toolboxes
# docker build -f ./amd-strix-halo-toolboxes/toolboxes/Dockerfile.rocm-6.4.4 -t rocm-6.4.4:1.0 ./amd-strix-halo-toolboxes/toolboxes
# docker build -f ./amd-strix-halo-toolboxes/toolboxes/Dockerfile.rocm-7.2 -t rocm-7.2:1.0 ./amd-strix-halo-toolboxes/toolboxes
