# Detect operating system
UNAME_S := $(shell uname -s)

# Common flags
CFLAGS = -std=c++17 -O2

# OS-specific configuration
ifeq ($(UNAME_S),Darwin)
    # macOS configuration
    BREW_PREFIX := $(shell brew --prefix)
    LDFLAGS = -I$(BREW_PREFIX)/include -L$(BREW_PREFIX)/lib -lglfw -lglm -lvulkan
    
    # Vulkan SDK configuration for macOS
    export VULKAN_SDK := $(BREW_PREFIX)/share/vulkan
    export VK_ICD_FILENAMES := $(VULKAN_SDK)/icd.d/MoltenVK_icd.json
    export VK_LAYER_PATH := $(VULKAN_SDK)/explicit_layer.d
    export DYLD_LIBRARY_PATH := $(BREW_PREFIX)/Cellar/vulkan-validationlayers/1.4.305/lib
else
    # Linux configuration
    LDFLAGS = -lglfw -lvulkan -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi
    
    # Vulkan SDK configuration for Linux (assuming standard installation)
    export VULKAN_SDK := /usr/share/vulkan
    export VK_LAYER_PATH := $(VULKAN_SDK)/explicit_layer.d
endif

# Build target
VulkanTest: main.cpp
	g++ $(CFLAGS) -o VulkanTest main.cpp $(LDFLAGS)

# Phony targets
.PHONY: test clean

test: VulkanTest
	./VulkanTest

clean:
	rm -f VulkanTest
