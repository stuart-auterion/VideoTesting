
linux {
    linux-g++ | linux-g++-64 | linux-g++-32 | linux-clang {
        CONFIG += link_pkgconfig
        packagesExist(gstreamer-1.0) {
            PKGCONFIG += \
                gstreamer-1.0 \
                gstreamer-video-1.0 \
                gstreamer-gl-1.0
            CONFIG += VideoEnabled
        }
    } else : android-clang {
        QT += androidextras
        contains(ANDROID_TARGET_ARCH, arm64-v8a) {
            GST_ROOT = $$PWD/lib/gstreamer-android/arm64
        }
        contains(ANDROID_TARGET_ARCH, armeabi-v7a) {
            GST_ROOT = $$PWD/lib/gstreamer-android/armv7
        }
        contains(ANDROID_TARGET_ARCH, x86) {
            GST_ROOT = $$PWD/lib/gstreamer-android/x86
        }
        contains(ANDROID_TARGET_ARCH, x86_64) {
            GST_ROOT = $$PWD/lib/gstreamer-android/x86_64
        }
        exists($$GST_ROOT) {
            QMAKE_CXXFLAGS  += -pthread
            CONFIG          += VideoEnabled
#            SOURCES += \
#                src/qt_gstreamer_android-1.0.cpp \
#                src/gstreamer_android-1.0.c
#            HEADERS += \
#                inc/gstreamer_android.h
            # We want to link these plugins statically
            #plugins
#            LIBS += $${GST_ROOT}/lib/gstreamer-1.0/libgstcoreelements.a
#            LIBS += $${GST_ROOT}/lib/gstreamer-1.0/libgsttypefindfunctions.a
#            LIBS += $${GST_ROOT}/lib/gstreamer-1.0/libgstvideoconvert.a
#            LIBS += $${GST_ROOT}/lib/gstreamer-1.0/libgstvideorate.a
#            LIBS += $${GST_ROOT}/lib/gstreamer-1.0/libgstvideoscale.a
#            LIBS += $${GST_ROOT}/lib/gstreamer-1.0/libgstvideofilter.a
#            LIBS += $${GST_ROOT}/lib/gstreamer-1.0/libgstautodetect.a
#            LIBS += $${GST_ROOT}/lib/gstreamer-1.0/libgstvideotestsrc.a
#            LIBS += $${GST_ROOT}/lib/gstreamer-1.0/libgstplayback.a
#            LIBS += $${GST_ROOT}/lib/gstreamer-1.0/libgstx264.a
#            LIBS += $${GST_ROOT}/lib/gstreamer-1.0/libgstvideoparsersbad.a
#            LIBS += $${GST_ROOT}/lib/gstreamer-1.0/libgstandroidmedia.a
#            LIBS += $${GST_ROOT}/lib/gstreamer-1.0/libgstopengl.a
#            LIBS += $${GST_ROOT}/lib/gstreamer-1.0/libgstqmlgl.a

#            #plugin libs
#            LIBS += $${GST_ROOT}/lib/liborc-0.4.a
#            LIBS += $${GST_ROOT}/lib/libgstgl-1.0.a
#            LIBS += $${GST_ROOT}/lib/libgraphene-1.0.a
#            LIBS += $${GST_ROOT}/lib/libpng16.a
#            LIBS += $${GST_ROOT}/lib/libjpeg.a
#            LIBS += $${GST_ROOT}/lib/libx264.a
#            LIBS += $${GST_ROOT}/lib/libgstvideo-1.0.a
###            LIBS += $${GST_ROOT}/lib/libgstbadbase-1.0.a
###            LIBS += $${GST_ROOT}/lib/libgstbadvideo-1.0.a
#            LIBS += $${GST_ROOT}/lib/libgstaudio-1.0.a
#            LIBS += $${GST_ROOT}/lib/libgstpbutils-1.0.a
#            LIBS += $${GST_ROOT}/lib/libgsttag-1.0.a
#            LIBS += $${GST_ROOT}/lib/libgstphotography-1.0.a
#            LIBS += $${GST_ROOT}/lib/libgstcontroller-1.0.a
#            LIBS += $${GST_ROOT}/lib/libgstcodecparsers-1.0.a
#            LIBS += -lEGL -lGLESv2


#            #gstreamer libs
#            LIBS += -L$$GST_ROOT/lib \
#                    -lgstbase-1.0 \
#                    -lgstreamer-1.0 \
#                    -lgstpbutils-1.0 \
#                    -lgsttag-1.0 \
#                    -lgstvideo-1.0 \
#                    -lgstcontroller-1.0 \
#                    -lgstapp-1.0 \
#                    -lbz2 \
#                    -lgobject-2.0 \
#                    -Wl,--export-dynamic -lgmodule-2.0


#            LIBS += $${GST_ROOT}/lib/libglib-2.0.a
#            LIBS += $${GST_ROOT}/lib/libgio-2.0.a
#            LIBS += $${GST_ROOT}/lib/libffi.a
###            LIBS += $${GST_ROOT}/lib/libpcre.a
#            LIBS += $${GST_ROOT}/lib/libiconv.a
#            LIBS += $${GST_ROOT}/lib/libintl.a
#            LIBS += $${GST_ROOT}/lib/libz.a

#            LIBS += \
#                -L$$GST_ROOT/lib/gstreamer-1.0 \
#                -L$$GST_ROOT/lib \

#            LIBS += \
#                -lgstvideo-1.0 \
#                -lgstcoreelements \
#                -lgstplayback \
#                -lgstudp \
#                -lgstrtp \
#                -lgstrtsp \
#                -lgstx264 \
#                -lgstlibav \
#                -lgstsdpelem \
#                -lgstvideotestsrc \
#                -lgstvideoparsersbad \
#                -lgstrtpmanager \
#                -lgstisomp4 \
#                -lgstmatroska \
#                -lgstmpegtsdemux \
#                -lgstandroidmedia \
#                -lgstopengl \
#                -lgsttypefindfunctions \
#                -lgstvideoconvert \
#                -lgstvideorate \
#                -lgstvideoscale \
#                -lgstvideofilter \
#                -lgstautodetect \
#                -lgstvideotestsrc \
#                -lgstqmlgl \
#                -lgraphene-1.0 \
#                -ljpeg \
#                -lpng16 \
#                -lgstmpegts-1.0 \
#                -lgstfft-1.0 \
#                -lm \
#                -lc \
#                -lgstnet-1.0 \
#                -lgio-2.0 \
#                -lgstphotography-1.0 \
#                -lgstgl-1.0 -lEGL \
#                -lgstaudio-1.0 \
#                -lgstcodecparsers-1.0 \
#                -lgstbase-1.0 \
#                -lgstreamer-1.0 \
#                -lgstrtp-1.0 \
#                -lgstpbutils-1.0 \
#                -lgstrtsp-1.0 \
#                -lgsttag-1.0 \
#                -lgstvideo-1.0 \
#                -lavformat \
#                -lavcodec \
#                -lavutil \
#                -lx264 \
#                -lavfilter \
#                -lswresample \
#                -lgstriff-1.0 \
#                -lgstcontroller-1.0 \
#                -lgstapp-1.0 \
#                -lgstsdp-1.0 \
#                -lbz2 \
#                -lgobject-2.0 \
#                -Wl,--export-dynamic -lgmodule-2.0 \
#                -pthread \
#                -lgcc \
#                -lglib-2.0 \
#                -lorc-0.4 \
#                -liconv \
#                -lffi \
#                -lintl \

#            INCLUDEPATH += \
#                $$GST_ROOT/include/gstreamer-1.0 \
#                $$GST_ROOT/lib/gstreamer-1.0/include \
#                $$GST_ROOT/include/glib-2.0 \
#                $$GST_ROOT/lib/glib-2.0/include \
#                $$GST_ROOT/include

#            ANDROID_EXTRA_LIBS += \
#                $$GST_ROOT/lib/libgstvideo-1.0.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstcoreelements.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstplayback.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstudp.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstrtp.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstrtsp.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstx264.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstlibav.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstsdpelem.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstvideotestsrc.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstvideoparsersbad.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstrtpmanager.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstisomp4.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstmatroska.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstmpegtsdemux.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstandroidmedia.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstopengl.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgsttypefindfunctions.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstvideoconvert.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstvideorate.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstvideoscale.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstvideofilter.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstautodetect.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstvideotestsrc.so \
#                $$GST_ROOT/lib/gstreamer-1.0/libgstqmlgl.so \
#                $$GST_ROOT/lib/libgstbase-1.0.so \
#                $$GST_ROOT/lib/libgobject-2.0.so \
#                $$GST_ROOT/lib/libgmodule-2.0.so \
#                $$GST_ROOT/lib/libglib-2.0.so \
#                $$GST_ROOT/lib/libiconv.so \
#                $$GST_ROOT/lib/libffi.so \
#                $$GST_ROOT/lib/libintl.so \
#                $$GST_ROOT/lib/libgraphene-1.0.so \
#                $$GST_ROOT/lib/libjpeg.so \
#                $$GST_ROOT/lib/libpng16.so \
#                $$GST_ROOT/lib/libgstmpegts-1.0.so \
#                $$GST_ROOT/lib/libgstfft-1.0.so \
#                $$GST_ROOT/lib/libgstnet-1.0.so \
#                $$GST_ROOT/lib/libgio-2.0.so \
#                $$GST_ROOT/lib/libgstphotography-1.0.so \
#                $$GST_ROOT/lib/libgstgl-1.0.so \
#                $$GST_ROOT/lib/libgstaudio-1.0.so \
#                $$GST_ROOT/lib/libgstcodecparsers-1.0.so \
#                $$GST_ROOT/lib/libgstbase-1.0.so \
#                $$GST_ROOT/lib/libgstreamer-1.0.so \
#                $$GST_ROOT/lib/libgstrtp-1.0.so \
#                $$GST_ROOT/lib/libgstpbutils-1.0.so \
#                $$GST_ROOT/lib/libgstrtsp-1.0.so \
#                $$GST_ROOT/lib/libgsttag-1.0.so \
#                $$GST_ROOT/lib/libgstvideo-1.0.so \
#                $$GST_ROOT/lib/libavformat.so \
#                $$GST_ROOT/lib/libavcodec.so \
#                $$GST_ROOT/lib/libavutil.so \
#                $$GST_ROOT/lib/libx264.so \
#                $$GST_ROOT/lib/libavfilter.so \
#                $$GST_ROOT/lib/libswresample.so \
#                $$GST_ROOT/lib/libgstriff-1.0.so \
#                $$GST_ROOT/lib/libgstcontroller-1.0.so \
#                $$GST_ROOT/lib/libgstapp-1.0.so \
#                $$GST_ROOT/lib/libgstsdp-1.0.so \
#                $$GST_ROOT/lib/libbz2.so \
#                $$GST_ROOT/lib/libgobject-2.0.so \
#                $$GST_ROOT/lib/libgmodule-2.0.so \
#                $$GST_ROOT/lib/libglib-2.0.so \
#                $$GST_ROOT/lib/liborc-0.4.so \
#                $$GST_ROOT/lib/libiconv.so \
#                $$GST_ROOT/lib/libffi.so \
#                $$GST_ROOT/lib/libintl.so \
#                /home/stuart/Qt/Android/ndk/21.3.6528147/platforms/android-29/arch-arm64/usr/lib/libc.so \
                # libm, egl

        } else {
            message("Could not find Android gstreamer libs")
        }
    }
}

VideoEnabled {
    DEFINES += \
        QGC_GST_STREAMING
    linux {
        linux-g++ | linux-g++-64 | linux-g++-32 | linux-clang {
            DEFINES += HAVE_QT_X11 HAVE_QT_EGLFS HAVE_QT_WAYLAND
        } else : android-clang {
            DEFINES += HAVE_QT_ANDROID
        }
    }
#    GST_PLUGINS_GOOD_ROOT = $$PWD/lib/gstreamer-plugins-good
#    SOURCES += \
#        $$GST_PLUGINS_GOOD_ROOT/ext/qt/gstplugin.cc \
#        $$GST_PLUGINS_GOOD_ROOT/ext/qt/gstqtelement.cc \
#        $$GST_PLUGINS_GOOD_ROOT/ext/qt/gstqsgtexture.cc \
#        $$GST_PLUGINS_GOOD_ROOT/ext/qt/gstqtglutility.cc \
#        $$GST_PLUGINS_GOOD_ROOT/ext/qt/gstqtoverlay.cc \
#        $$GST_PLUGINS_GOOD_ROOT/ext/qt/gstqtsink.cc \
#        $$GST_PLUGINS_GOOD_ROOT/ext/qt/gstqtsrc.cc \
#        $$GST_PLUGINS_GOOD_ROOT/ext/qt/qtglrenderer.cc \
#        $$GST_PLUGINS_GOOD_ROOT/ext/qt/qtitem.cc \
#        $$GST_PLUGINS_GOOD_ROOT/ext/qt/qtwindow.cc \

#    HEADERS += \
#        $$GST_PLUGINS_GOOD_ROOT/ext/qt/qtitem.h \
#        $$GST_PLUGINS_GOOD_ROOT/ext/qt/qtwindow.h \
#        $$GST_PLUGINS_GOOD_ROOT/ext/qt/gstqsgtexture.h \
#        $$GST_PLUGINS_GOOD_ROOT/ext/qt/qtglrenderer.h \
#        $$GST_PLUGINS_GOOD_ROOT/ext/qt/gstqtgl.h \
#        $$GST_PLUGINS_GOOD_ROOT/ext/qt/gstqtglutility.h \
#        $$GST_PLUGINS_GOOD_ROOT/ext/qt/gstqtsink.h \
#        $$GST_PLUGINS_GOOD_ROOT/ext/qt/gstqtsrc.h \

}
