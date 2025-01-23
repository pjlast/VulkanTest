Vulkan on MacOS seems to have some caveats.

1. We need to enable the VK_KHR_PORTABILITY_ENUMERATION_EXTENSION_NAME extension, as seen in main.cpp
2. There are some environment variables that need to be set, as seen in the Makefile

// Useful for debugging
export VK_LOADER_DEBUG=all
