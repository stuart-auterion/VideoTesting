
GSTREAMER_ROOT_ANDROID = $$(GSTREAMER_ROOT_ANDROID)
isEmpty(GSTREAMER_ROOT_ANDROID): error("GSTREAMER_ROOT_ANDROID not defined")

SOURCES += \
    android/src/gstreamer.cpp \

HEADERS += \
    android/inc/gstreamer.h \

equals(ANDROID_TARGET_ARCH, armeabi-v7a)  {
    GSTREAMER_ARCH=armv7
} else:equals(ANDROID_TARGET_ARCH, arm64-v8a)  {
    GSTREAMER_ARCH=arm64
} else:equals(ANDROID_TARGET_ARCH, x86)  {
    GSTREAMER_ARCH=x86
} else:equals(ANDROID_TARGET_ARCH, x86_64)  {
    GSTREAMER_ARCH=x86_64
} else {
    error("Unsupported Android architecture: $${ANDROID_TARGET_ARCH}")
}
message($(GSTREAMER_ROOT_ANDROID)/$${GSTREAMER_ARCH})

INCLUDEPATH += \
    android/inc \
    $(GSTREAMER_ROOT_ANDROID)/$${GSTREAMER_ARCH}/include \
    $(GSTREAMER_ROOT_ANDROID)/$${GSTREAMER_ARCH}/include/gstreamer-1.0 \
    $(GSTREAMER_ROOT_ANDROID)/$${GSTREAMER_ARCH}/include/glib-2.0 \
    $(GSTREAMER_ROOT_ANDROID)/$${GSTREAMER_ARCH}/lib/glib-2.0/include \

QT += multimediagsttools-private

LIBS += \
    -L$(GSTREAMER_ROOT_ANDROID)/$${GSTREAMER_ARCH}/lib/ \
    -L$(GSTREAMER_ROOT_ANDROID)/$${GSTREAMER_ARCH}/lib/gstreamer-1.0 \
    -lgstcoreelements -lgstplayback -lgstvideotestsrc -lgstaudioconvert -lgstvideoconvert -lgstautodetect -lgsttypefindfunctions \
    -lgstvorbis -lvorbis -lgstivorbisdec -lvorbisenc -lvorbisfile -lgstsubparse -lgstaudioparsers  \
    -lgstgio -lgstapp -lgstisomp4 -lgstavi -lgstogg -lgstwavenc -lgstwavpack -lgstwavparse -lgsttheora -lgstmpg123 -lgstx264 -lgstlibav \
    -lgsttcp -logg -ltheora -lmpg123 -lx264 -lavfilter -lavformat -lavcodec -lavutil -lbz2 -lswresample \
    -lgio-2.0 -lgstrtp-1.0 -lgstriff-1.0 -lgstnet-1.0

DISTFILES += \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/gradle.properties \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml \
