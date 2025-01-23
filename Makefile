CFLAGS = -std=c++17 -O2
LDFLAGS = -I/opt/homebrew/include -L/opt/homebrew/lib -lglfw -lglm -lvulkan

export VULKAN_SDK := $(shell brew --prefix)/share/vulkan
export VK_ICD_FILENAMES := $(VULKAN_SDK)/icd.d/MoltenVK_icd.json
export VK_LAYER_PATH := $(VULKAN_SDK)/explicit_layer.d
export DYLD_LIBRARY_PATH := $(shell brew --prefix)/Cellar/vulkan-validationlayers/1.4.305/lib

VulkanTest: main.cpp
	g++ $(CFLAGS) -o VulkanTest main.cpp $(LDFLAGS)

.PHONY: test clean

test: VulkanTest
	./VulkanTest

clean:
	rm -f VulkanTest
