# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="libmali-vulkan"
PKG_VERSION="r46p0-01eac1"
PKG_LICENSE="mali_driver"
PKG_ARCH="arm aarch64"
PKG_SITE="https://developer.arm.com/downloads/-/mali-drivers/user-space"
PKG_URL="https://developer.arm.com/-/media/Files/downloads/mali-drivers/user-space/odroid-n2plus/BXODROIDN2PL-${PKG_VERSION}.tar"
PKG_DEPENDS_TARGET="toolchain"
PKG_TOOLCHAIN="manual"
PKG_LONGDESC="Vulkan Mali drivers for s922x soc"

# despite package name implies Vulkan is to be used, it's just general-purpose blobs,
# which may be used for just GLES and GBM
if [ "${VULKAN_SUPPORT}" = "yes" ]
then
  PKG_DEPENDS_TARGET+=" vulkan-loader vulkan-headers"
fi

make_target() {
  :
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/{lib,share}
  tar -xvJf ${PKG_BUILD}/mali.tar.xz -C ${INSTALL}
  mv ${INSTALL}/lib/${TARGET_ARCH}-linux-gnu/* ${INSTALL}/usr/lib
  rm -r ${INSTALL}/lib

  mv ${INSTALL}/usr/lib/libEGL.so.1.4.0 ${INSTALL}/usr/lib/libEGL_mali.so.1.4.0
  mv ${INSTALL}/usr/lib/libGLESv1_CM.so.1.1.0 ${INSTALL}/usr/lib/libGLESv1_CM_mali.so.1.1.0
  mv ${INSTALL}/usr/lib/libGLESv2.so.2.1.0 ${INSTALL}/usr/lib/libGLESv2_mali.so.2.1.0

  rm ${INSTALL}/usr/lib/libEGL.so*
  rm ${INSTALL}/usr/lib/libGLESv1_CM.so*
  rm ${INSTALL}/usr/lib/libGLESv2.so*

  mkdir -p ${INSTALL}/usr/share/
  cp -a ${PKG_DIR}/glvnd ${INSTALL}/usr/share/

  cp ${PKG_DIR}/pkgconfig/* ${SYSROOT_PREFIX}/usr/lib/pkgconfig/
  cp ${INSTALL}/usr/lib/libmali.so ${SYSROOT_PREFIX}/usr/lib/
  ln -s libmali.so ${SYSROOT_PREFIX}/usr/lib/libgbm.so

  if [ "${VULKAN_SUPPORT}" = "yes" ]
  then
	tar -xvJf ${PKG_BUILD}/rootfs_additions.tar.xz -C ${INSTALL}/usr/share
	mv ${INSTALL}/usr/share/etc/vulkan/* ${INSTALL}/usr/share/vulkan/
	rm -r ${INSTALL}/usr/share/etc
  fi
}

