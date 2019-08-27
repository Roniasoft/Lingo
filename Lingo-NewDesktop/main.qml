import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.1
import FramelessWindow 1.0
import "QmlFiles"

FramelessAppWindow {
    id: window
    width: 640
    height: 680
    visible: true
    title: "lingo"
    windowIcon: runningFromQt ? ":/images/icon.png" : "images/icon.png";

    Material.theme: Material.Dark
    Material.accent: '#4885cc'
    Material.primary: '#4885cc'

    property alias footerLabel: footerLabel;
    property real fontSize: 12;

    // status bar function and timer
    function updateStatusBar(msg) {
        footerLabel.text = msg;
        timerFooterCleaner.start();
    }

    function pathCR(path) {
        if (runningFromQt) {
            return path;
        } else {
            return (path.replace("qrc:/",""));
        }
    }
    function pathCRDepth1(path) {
        if (runningFromQt) {
            return path;
        } else {
            return (path.replace("qrc:/","../"));
        }
    }

    Timer {
        id: timerFooterCleaner;
        interval: 5000;
        repeat: false;

        onTriggered: footerLabel.text = "";
    }

    // title widget
    ToolBar {
        id: header;
        Material.foreground: "#0e1621"
        anchors.top: window.top;
        anchors.left: window.left;
        anchors.right: window.right;
        width: parent.width;
        height: 30

        background: Rectangle {
            color: "#0e1621"
            height: 30;
            width: parent.width;
            anchors.fill: parent

            Image {
                id: imgMenu
                source: !drawer.visible ? (imgMenuMA.containsMouse ? pathCR("qrc:/images/drawer.png") : pathCR("qrc:/images/drawerG.png"))
                                        : (imgMenuMA.containsMouse ? pathCR("qrc:/images/back.png") : pathCR("qrc:/images/backG.png"));
                width: isMax ? 18 : 20;
                fillMode: Image.PreserveAspectFit;
                anchors.bottom: parent.bottom;
                anchors.bottomMargin: isMax ? 2 : 5;
                anchors.left: parent.left;
                anchors.leftMargin: isMax ? 10 : 5;

                MouseArea {
                    id: imgMenuMA;
                    anchors.fill: parent;
                    hoverEnabled: true;
                    cursorShape: Qt.PointingHandCursor;
                    onClicked: {
                        if (drawer.visible)
                            drawer.close();
                        else
                            drawer.open();
                    }
                }
            }

            Label {
                id: titleLabel
                text: "Lingo";
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter;
                anchors.horizontalCenter: parent.horizontalCenter;
                color: "white";
            }

            Row {
                id: rowWindowButtons;
                anchors.right: parent.right;
                anchors.rightMargin: isMax ? 8 : 0;
                anchors.bottom: parent.bottom;
                height: isMax ? 22 : 30
                Rectangle {
                    id: rectMin;
                    height: isMax ? 22 : 30
                    width: 40;
                    color: maMinButton.containsMouse ? "#232e3c" : "#0e1621";
                    Image {
                        id: imgMinButton
                        anchors.verticalCenter: parent.verticalCenter;
                        anchors.horizontalCenter: parent.horizontalCenter;
                        height: 12;
                        source: maMinButton.containsMouse ? pathCR("qrc:/images/WindowIcons/1H.png") :
                                                            pathCR("qrc:/images/WindowIcons/1.png");
                        fillMode: Image.PreserveAspectFit
                    }

                    MouseArea {
                        id: maMinButton;
                        anchors.fill: parent;
                        hoverEnabled: true;
                        cursorShape: Qt.PointingHandCursor;
                        onClicked: showMin();
                    }
                }
                Rectangle {
                    id: rectMax;
                    height: isMax ? 22 : 30
                    width: 40;
                    color: maMaxButton.containsMouse ? "#232e3c" : "#0e1621";
                    Image {
                        id: imgMaxButton
                        anchors.verticalCenter: parent.verticalCenter;
                        anchors.horizontalCenter: parent.horizontalCenter;
                        height: 12;
                        source: maMaxButton.containsMouse ? (isMax ? pathCR("qrc:/images/WindowIcons/4H.png") : pathCR("qrc:/images/WindowIcons/2H.png")) :
                                                            (isMax ? pathCR("qrc:/images/WindowIcons/4.png") : pathCR("qrc:/images/WindowIcons/2.png"));
                        fillMode: Image.PreserveAspectFit
                    }

                    MouseArea {
                        id: maMaxButton;
                        anchors.fill: parent;
                        hoverEnabled: true;
                        cursorShape: Qt.PointingHandCursor;
                        onClicked: {
                            if (isMax) {
                                window.showNormal();
                            } else {
                                window.showMaximized();
                            }
                        }
                    }
                }
                Rectangle {
                    id: rectClose;
                    height: isMax ? 22 : 30
                    width: 40;
                    color: maCloseButton.containsMouse ? "#e92539" : "#0e1621";
                    Image {
                        id: imgCloseButton
                        anchors.verticalCenter: parent.verticalCenter;
                        anchors.horizontalCenter: parent.horizontalCenter;
                        height: 12;
                        source: maCloseButton.containsMouse ? pathCR("qrc:/images/WindowIcons/3H.png") :
                                                              pathCR("qrc:/images/WindowIcons/3.png");
                        fillMode: Image.PreserveAspectFit

                    }

                    MouseArea {
                        id: maCloseButton;
                        anchors.fill: parent;
                        hoverEnabled: true;
                        cursorShape: Qt.PointingHandCursor;
                        onClicked: Qt.quit();
                    }
                }
            }
        }
    }


    // left drawer menu
    Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 6 * 2
        height: window.height -  header.height - footerBar.height;
        y: header.height;
        interactive: true;
        background: Rectangle {
            color: "#0e1621";
        }

        ListView {
            id: lvDrawerMenu
            Material.theme: Material.Dark
            Material.accent: '#4885cc'
            Material.primary: '#4885cc'
            focus: true
            currentIndex: -1
            anchors.fill: parent
            delegate: Rectangle {
                id: wrapper;
                width: lvDrawerMenu.width;
                height: 36;
                color: dlgMouseArea.containsMouse ? "#2b5278" : "#17212b";
                Image {
                    id: imgIcon
                    source: pathCR(model.iconSrc);
                    width: 16;
                    fillMode: Image.PreserveAspectFit;
                    anchors.left: parent.left;
                    anchors.leftMargin: 10;
                    anchors.verticalCenter: parent.verticalCenter;
                }
                Text {
                    id: txtTitle
                    text: model.title;
                    anchors.left: imgIcon.right;
                    anchors.leftMargin: 10;
                    anchors.verticalCenter: parent.verticalCenter;
                    font.pixelSize: 12
                    color: "white";
                }
                MouseArea {
                    id: dlgMouseArea;
                    anchors.fill: parent;
                    hoverEnabled: true;
                    cursorShape: Qt.PointingHandCursor;
                    onClicked: {
                        lvDrawerMenu.currentIndex =index;
                        if (index === 0) {
                            ribbonBar.setCurrentIndex(0);
                            drawer.close();
                            updateStatusBar("Returned to projects...");
                        }
                        if (index === 2) {  // fullscreen
                            if (isFullScreen === false) {
                                btnFullScreen.checked = true;
                                drawer.close();
                            } else {
                                btnFullScreen.checked = false;
                            }
                        }

                        if (index === 1)  {
                            settings.open();
                            updateStatusBar("Settings Opened...");
                        }
                        if (index === 3) {
                            Qt.quit();
                        }
                    }
                }
            }

            model: ListModel {
                ListElement { title: "Open File"; iconSrc: "qrc:/images/Icons/White/open_file.png"}
                ListElement { title: "Hide Completed"; iconSrc: "qrc:/images/Icons/White/Hide.png"}
                ListElement { title: "Full Screen"; iconSrc: "qrc:/images/Icons/White/fullScreen.png"}
                ListElement { title: "Exit"; iconSrc: "qrc:/images/Icons/White/exit.png"}
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    // ribbon bar
    Rectangle {
        id: ribbonBar;
        anchors.top: header.bottom;
        height: 36;
        color: "#17212b"
        width: parent.width;
        z: 5;

        Row {
            id: ribbonBarRow;
            anchors.left: parent.left;
            anchors.leftMargin: 10;
            anchors.verticalCenter: parent.verticalCenter;
            height: parent.height;
            spacing: 5;

            TRibbonButton {
                height: parent.height * 0.8;
                width: height;
                anchors.verticalCenter: parent.verticalCenter;
                imgSource: "qrc:/images/Icons/Grey/open_file.png";
                imgSourceHovered: "qrc:/images/Icons/White/open_file.png";
                tooltipStr: "Open New";
                onButtonClicked: {
                }
            }

            TRibbonButton {
                height: parent.height * 0.8;
                width: height;
                anchors.verticalCenter: parent.verticalCenter;
                imgSource: "qrc:/images/Icons/Grey/Hide.png";
                imgSourceHovered: "qrc:/images/Icons/White/Hide.png";
                tooltipStr: "Hide Completed"
                onButtonClicked: {
                }
            }

            TRibbonButton {
                id: btnFullScreen;
                height: parent.height * 0.8;
                width: height;
                checkable: true;
                anchors.verticalCenter: parent.verticalCenter;
                imgSource: "qrc:/images/Icons/Grey/fullScreen.png";
                imgSourceHovered: "qrc:/images/Icons/White/fullScreen.png";
                tooltipStr: checked ? "Normal" : "Full Screen";

                onCheckedChanged: {
                    if (checked) {
                        isFullScreen = true;
                        window.showFullScreen();
                        header.visible = false;
                        header.height = 0;
                    } else {
                        isFullScreen = false;
                        header.visible = true;
                        header.height = 30;
                        window.showNormal();
                    }
                }
            }


            TRibbonButton {
                height: parent.height * 0.8;
                width: height;
                anchors.verticalCenter: parent.verticalCenter;
                imgSource: "qrc:/images/Icons/Grey/Decrease.png";
                imgSourceHovered: "qrc:/images/Icons/White/Decrease.png";
                tooltipStr: "Decrease font size"
                onButtonClicked: {
                    if (fontSize > 9)
                        fontSize -= 1;
                }
            }


            TRibbonButton {
                height: parent.height * 0.8;
                width: height;
                anchors.verticalCenter: parent.verticalCenter;
                imgSource: "qrc:/images/Icons/Grey/Increase.png";
                imgSourceHovered: "qrc:/images/Icons/White/Increase.png";
                tooltipStr: "Increase font size"
                onButtonClicked: {
                    if (fontSize < 25)
                        fontSize += 1;
                }
            }
        }
    }

    // central view (list)
    CentralListView {
        id: projects;
        width: parent.width
        height: parent.height;
        anchors.top: ribbonBar.bottom;
        anchors.bottom: footerBar.top;
    }

    // status bar
    ToolBar {
        id: footerBar;
        anchors.bottom: parent.bottom;
        anchors.left: parent.left;
        anchors.right: parent.right;
        height: 25;

        background: Rectangle {
            anchors.fill: parent;
            color: "#0e1621";
            Label {
                id: footerLabel;
                anchors.fill: parent;
                anchors.left: parent.left;
                anchors.leftMargin: 10;
                text: "";
                elide: Label.ElideRight
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
                color: "white";
            }
        }
    }

    // shortcuts
    Shortcut {
        sequence: "F11";
        onActivated: {
            btnFullScreen.checked = !btnFullScreen.checked;
        }
    }
}
