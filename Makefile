# Detect operating system
UNAME_S := $(shell uname -s)

# Common flags
CFLAGS = -std=c++17 -O2

# OS-specific configuration
ifeq ($(UNAME_S),Darwin)
    # macOS configuration
    BREW_PREFIX := $(shell brew --prefix)
    VULKAN_SDK_PREFIX := /Users/pjlast/VulkanSDK/1.4.304.0/macOS
    LDFLAGS = -I$(BREW_PREFIX)/include -L$(BREW_PREFIX)/lib -I$(VULKAN_SDK_PREFIX)/include -L$(VULKAN_SDK_PREFIX)/lib -lglfw -lglm -lvulkan
    
    # Vulkan SDK configuration for macOS
    export VULKAN_SDK := $(VULKAN_SDK_PREFIX)/share/vulkan
    export VK_ICD_FILENAMES := $(VULKAN_SDK)/icd.d/MoltenVK_icd.json
    export VK_LAYER_PATH := $(VULKAN_SDK)/explicit_layer.d
    export DYLD_LIBRARY_PATH := $(BREW_PREFIX)/Cellar/vulkan-validationlayers/1.4.305/lib:$(VULKAN_SDK_PREFIX)/lib
    # export VK_LOADER_DEBUG=all
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
