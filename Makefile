# TARGET #

TARGET := 3DS
LIBRARY := 0

ifeq ($(TARGET),$(filter $(TARGET),3DS WIIU))
    ifeq ($(strip $(DEVKITPRO)),)
        $(error "Please set DEVKITPRO in your environment. export DEVKITPRO=<path to>devkitPro")
    endif
endif

# COMMON CONFIGURATION #

VERSION	:=	v1.2.1

NAME := hblauncher_loader $(VERSION)

BUILD_DIR := build
OUTPUT_DIR := output
INCLUDE_DIRS := include
SOURCE_DIRS := source data

#EXTRA_OUTPUT_FILES :=

LIBRARY_DIRS := $(DEVKITPRO)/libctru
LIBRARIES := ctru m

BUILD_FLAGS := -march=armv6k -mtune=mpcore -mfloat-abi=hard -mtp=soft
BUILD_FLAGS_CC := -g -Wall -O2 -mword-relocations -fomit-frame-pointer -ffunction-sections $(BUILD_FLAGS) $(INCLUDE) -DARM11 -D_3DS -DVERSION=\"$(VERSION)\"
BUILD_FLAGS_CXX := $(BUILD_FLAGS_CC) -fno-rtti -fno-exceptions -std=gnu++11
RUN_FLAGS :=

VERSION_MAJOR := 1
VERSION_MINOR := 2
VERSION_MICRO := 1

# 3DS CONFIGURATION #

ifeq ($(TARGET),$(filter $(TARGET),3DS WIIU))
    TITLE := $(NAME)
    DESCRIPTION := This boots the *hax payload
    AUTHOR := yellows8
endif

ifeq ($(TARGET),3DS)
    #LIBRARY_DIRS +=
    #LIBRARIES +=

    PRODUCT_CODE := HBL-LDR
    UNIQUE_ID := 0xd921e

    CATEGORY := Application
    USE_ON_SD := true

    MEMORY_TYPE := Application
    SYSTEM_MODE := 64MB
    SYSTEM_MODE_EXT := 124MB
    CPU_SPEED := 804MHz
    ENABLE_L2_CACHE := true

    ICON_FLAGS := --flags visible,ratingrequired,recordusage --cero 153 --esrb 153 --usk 153 --pegigen 153 --pegiptr 153 --pegibbfc 153 --cob 153 --grb 153 --cgsrr 153

    #ROMFS_DIR :=
    BANNER_AUDIO := meta/audio.wav
    BANNER_IMAGE := meta/banner.cgfx
    ICON := meta/icon.png
endif

# INTERNAL #

include buildtools/make_base