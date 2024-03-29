all:
	pwd

install:
	mkdir -p ${DESTDIR}/usr/lib
	cp libmali.so.1 ${DESTDIR}/usr/lib/
	ln -s libmali.so.1 ${DESTDIR}/usr/lib/libmali.so
	ln -s libmali.so.1 ${DESTDIR}/usr/lib/libEGL.so.1
	ln -s libEGL.so.1 ${DESTDIR}/usr/lib/libEGL.so
	ln -s libmali.so.1 ${DESTDIR}/usr/lib/libGLESv1_CM.so.1
	ln -s libGLESv1_CM.so.1 ${DESTDIR}/usr/lib/libGLESv1_CM.so
	ln -s libmali.so.1 ${DESTDIR}/usr/lib/libGLESv2.so.2
	ln -s libGLESv2.so.2 ${DESTDIR}/usr/lib/libGLESv2.so
	cp -a pkgconfig ${DESTDIR}/usr/lib/
	cp -a include ${DESTDIR}/usr/
