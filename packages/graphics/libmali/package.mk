# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="libmali"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/tsukumijima/libmali-rockchip"
PKG_DEPENDS_TARGET="toolchain libdrm patchelf:host"

PKG_VERSION="v1.9-1-b9619b9"
# zip format makes extract very fast (<1s). tgz takes 20 seconds to scan the whole file
PKG_URL="https://github.com/tsukumijima/libmali-rockchip/archive/refs/tags/${PKG_VERSION}.zip"

PKG_TOOLCHAIN="meson"

PKG_LONGDESC="OpenGL ES user-space binary for the ARM Mali GPU family"

case "${DISPLAYSERVER}" in
  wl)
    PLATFORM="wayland-gbm"
    PKG_DEPENDS_TARGET+=" wayland"
    ;;
  x11)
    PLATFORM="x11-gbm"
    ;;
  *)
    PLATFORM="gbm"
    ;;
esac

PKG_BUILD_FLAGS="-strip"
PKG_MESON_OPTS_TARGET+=" -Darch=${ARCH} -Dgpu=${MALI_FAMILY} -Dversion=${MALI_VERSION} -Dplatform=${PLATFORM} \
					     -Dkhr-header=true -Dvendor-package=false -Dwrappers=disabled -Dhooks=true"


unpack() {
  mkdir -p "${PKG_BUILD}"
  cd "${PKG_BUILD}"
  pwd
  # Extract only what is needed
  LIBNAME="libmali-${MALI_FAMILY}-${MALI_VERSION}-${PLATFORM}.so"
  unzip -q "${SOURCES}/${PKG_NAME}/${PKG_SOURCE_NAME}" "*/hook/*" "*/include/*" "*/scripts/*" "*/meson*" "*/${LIBNAME}"
  mv libmali-rockchip-*/* .
  ln -s lib optimize_3
}

pre_make_target() {
  patchelf --rename-dynamic-symbols "${PKG_BUILD}/rename.syms" --add-needed libmali-hook.so.1 libmali-prebuilt.so
}

