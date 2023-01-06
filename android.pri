QT += androidextras

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

SOURCES += \
    src/mobileScreenManager.cpp

HEADERS += \
    inc/mobileScreenManager.h

RESOURCES += \
    $$PWD/android/android.qrc

DISTFILES += \
    $$PWD/android/AndroidManifest.xml \
    $$PWD/android/build.gradle \
    $$PWD/android/gradle.properties \
    $$PWD/android/gradle/wrapper/gradle-wrapper.jar \
    $$PWD/android/gradle/wrapper/gradle-wrapper.properties \
    $$PWD/android/gradlew \
    $$PWD/android/gradlew.bat \
    $$PWD/android/res/values/libs.xml \
    $$PWD/android/res/xml/file_paths.xml \
    $$PWD/android/src/org/test/test/TestActivity.java \
