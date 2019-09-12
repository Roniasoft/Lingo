QT += core gui quick quickcontrols2
CONFIG += c++11


greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    QmlFiles/FlatButton.qml \
    QmlFiles/TRibbonButton.qml \
    QmlFiles/TCheckBox.qml \
    main.qml \
    QmlFiles/TTextEditBlock.qml \
    QmlFiles/TListModel.qml \
    QmlFiles/ListItemDelegate.qml \
    QmlFiles/CentralListView.qml \
    QmlFiles/ItemSummaryView.qml \
    QmlFiles/ItemDetailedView.qml \
    QmlFiles/MainGroups.qml \
    QmlFiles/MainGroups.qml \
    QmlFiles/NiceTabBar.qml \
    QmlFiles/TabBarHeader.qml \
    QmlFiles/AppStyle.qml \
    QmlFiles/GroupItemDelegate.qml

HEADERS += \

FORMS += \


