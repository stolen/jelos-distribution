# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="libmali"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/JustEnoughLinuxOS/libmali"
PKG_VERSION="b9619b998cd9a019dacd6f5a4058c757ec0ed382"

if [ "${TARGET_ARCH}" = "aarch64" ]; then
  INSTARCH="aarch64-linux-gnu"
elif [ "${TARGET_ARCH}" = "arm" ]; then
  INSTARCH="arm-linux-gnueabihf"
fi

PKG_URL="https://github.com/tsukumijima/libmali-rockchip/raw/${PKG_VERSION}/lib/${INSTARCH}/libmali-bifrost-${MALI_FAMILY}-${MALI_VERSION}-wayland-gbm.so"
PKG_TOOLCHAIN="make"
MALI_LIB_VERSION="1.9.0"
PKG_DEPENDS_TARGET="toolchain libdrm"


if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" vulkan-tools"
fi

PKG_LONGDESC="OpenGL ES user-space binary for the ARM Mali GPU family"


unpack() {
  declare -p | grep -F 'sources'
  echo "${PKG_NAME}" "${PKG_UNPACK_DIR}"
  mkdir -p "${PKG_BUILD}"
  cp "${SOURCES}/${PKG_NAME}/${PKG_SOURCE_NAME}" "${PKG_BUILD}/libmali.so.1"
}
