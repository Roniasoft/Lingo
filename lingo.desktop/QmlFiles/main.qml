import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import QtQuick.Controls.Universal 2.12
import QtQuick.Controls.Material 2.12
import FramelessWindow 1.0

import NetViewModels 1.0

FramelessAppWindow {
    id: window
    width: 640
    height: 680
    visible: true
    title: "lingo"
    windowIcon: "../images/icon.png";

    Universal.theme: Universal.Dark
    Universal.background: appStyle.background
    Universal.foreground: appStyle.foreground

    Material.theme: Material.Dark
    Material.background: appStyle.background
    Material.foreground: appStyle.foreground
    
	NetAppContext {
		id: netContext

        Component.onCompleted: {
            if (netContext.loadingError() != "") {
                loadingErrorPopUp.msg = netContext.loadingError();
                loadingErrorPopUp.open();
            }
        }
	}


    AppStyle {
        id: appStyle
    }

    property alias footerLabel: footerLabel;
    property real fontSize: 12;
    property real scaleFactor: fontSize / 12.0;
    property bool hideCompleteds: false;
    property alias rbtnHideCompleteds: rbtnHideCompleteds;

    onHideCompletedsChanged: {
        if (hideCompleteds === true) {
            lvDrawerMenu.model.get(1).checked = true;
            rbtnHideCompleteds.checked = true;
            updateStatusBar("Completed records are hidden now!");
        } else {
            lvDrawerMenu.model.get(1).checked = false;
            rbtnHideCompleteds.checked = false;
            updateStatusBar("َAll records are visible now!");
        }
    }


    // status bar function and timer
    function updateStatusBar(msg) {
        footerLabel.text = msg;
        timerFooterCleaner.start();
    }

    function pathCR(path) {
        return path;
    }
    function pathCRDepth1(path) {
        return path;
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
                        source: maMinButton.containsMouse ? "../images/WindowIcons/1H.png" :
                                                            "../images/WindowIcons/1.png";
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
                        source: maMaxButton.containsMouse ? (isMax ? ("../images/WindowIcons/4H.png") : ("../images/WindowIcons/2H.png")) :
                                                            (isMax ? ("../images/WindowIcons/4.png") : ("../images/WindowIcons/2.png"));
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
                        source: maCloseButton.containsMouse ? "../images/WindowIcons/3H.png" :
                                                              "../images/WindowIcons/3.png";
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
        y: header.height + ribbonBar.height;
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
                color: model.checked ? "#364451" : (dlgMouseArea.containsMouse ? "#2b5278" : "#17212b");
                Image {
                    id: imgIcon
                    source: model.iconSrc;
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
                    font.pixelSize: fontSize + 2;
                    color: "white";
                }
                MouseArea {
                    id: dlgMouseArea;
                    anchors.fill: parent;
                    hoverEnabled: true;
                    cursorShape: Qt.PointingHandCursor;
                    onClicked: {
                        lvDrawerMenu.currentIndex = index;
                        if (index === 0) {
                            drawer.close();
                            headerBar.switchTo(-1); // switch to the groups
                            updateStatusBar("Drawer Closed.");
                        }

                        if (index === 1)  {
                            hideCompleteds = !hideCompleteds;
                        }

                        if (index == 2) {
                            drawer.close();
                            helpPopUp.open();
                        }
                        if (index === 3) {
                            Qt.quit();
                        }
                    }
                }
            }

            model: ListModel {
                ListElement { title: "Groups"; iconSrc: "../images/Icons/White/open_file.png"; checked: false}
                ListElement { title: "Hide Completed"; iconSrc: "../images/Icons/White/HideCompleted.png"; checked: false}
                ListElement { title: "Help"; iconSrc: "../images/Icons/White/help.png"; checked: false}
                ListElement { title: "Exit"; iconSrc: "../images/Icons/White/exit.png"; checked: false}
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
                id: imgMenu
                height: parent.height * 0.8;
                tooltipOnBottom: drawer.visible ? false : true;
                width: height;
                anchors.verticalCenter: parent.verticalCenter;
                imgSource: drawer.visible ? "../images/backG.png" : "../images/drawerG.png";
                imgSourceHovered: drawer.visible ? "../images/back.png" : "../images/drawer.png";
                tooltipStr: drawer.visible ? "Show Drawer" : "Hide Drawer"

                onButtonClicked: {
                        if (drawer.visible) {
                            drawer.close();
                        } else {
                            drawer.open();
                        }
                }
            }

            Item {
                width: 3;
                height: 20;
            }

            
            Rectangle {
                width: 2
                height: 20
                anchors.verticalCenter: parent.verticalCenter;
                color: "#6C7883"
                opacity: 0.3;
            }

            Item {
                width: 3;
                height: 20;
            }


            TRibbonButton {
                id: rbtnHideCompleteds;
                height: parent.height * 0.8;
                width: height;
                tooltipOnBottom: !drawer.visible;
                anchors.verticalCenter: parent.verticalCenter;
                imgSource: /*hideCompleteds ? "../images/Icons/Grey/Show.png" : */"../images/Icons/Grey/HideCompleted.png";
                imgSourceHovered: /*hideCompleteds ? "../images/Icons/White/ShowAll.png" : */"../images/Icons/White/HideCompleted.png";
                tooltipStr: hideCompleteds ? "Show All" : "Hide Completed"
                checkable: true;
                onButtonClicked: {
                    hideCompleteds = !hideCompleteds;
                }
            }

            TRibbonButton {
                height: parent.height * 0.8;
                width: height;
                tooltipOnBottom: !drawer.visible;
                anchors.verticalCenter: parent.verticalCenter;
                imgSource: "../images/Icons/Grey/Decrease.png";
                imgSourceHovered: "../images/Icons/White/Decrease.png";
                tooltipStr: "Decrease font size"
                onButtonClicked: {
                    if (fontSize > 9) {
                        fontSize -= 1;
                        updateStatusBar("Application font size decremented.");
                    }
                }
            }


            TRibbonButton {
                height: parent.height * 0.8;
                width: height;
                tooltipOnBottom: !drawer.visible;
                anchors.verticalCenter: parent.verticalCenter;
                imgSource: "../images/Icons/Grey/Increase.png";
                imgSourceHovered: "../images/Icons/White/Increase.png";
                tooltipStr: "Increase font size"
                onButtonClicked: {
                    if (fontSize < 22) {
                        fontSize += 1;
                        updateStatusBar("Application font size incremented.");
                    }
                }
            }
        }
    }

    TabBarHeader {
        id: headerBar
        anchors.top: ribbonBar.bottom;
        anchors.left: parent.left;
        anchors.right: parent.right;
        width: parent.width;
        style: appStyle.headerStyle
    }

    TSwipeView {
        id: sv
        anchors.top: headerBar.bottom;
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.bottom: footerBar.top;
        currentIndex: headerBar.currentIndex

        
        MainGroups {
            id: projects;
            style: appStyle.mainFeedStyle
            property int projectId: -1;

            onOpenProjectRequested: {
				headerBar.addTab(project.title, project.projectId)
				sv.addPage(listViewComponent, project)   // project: projectViewModel

				headerBar.switchTo(project.projectId)
                updateStatusBar("Project opened: " + project.title);

			}

			onSwitchToProjectRequested: {
				headerBar.switchTo(project.projectId)
                updateStatusBar("Switch to: " + project.title);
			}
        }
        
        function addPage(comp, projectViewModel) {
            var cListView = comp.createObject(sv);
            cListView.fillModel(projectViewModel);
            sv.children.push(cListView);
        }
    }

    Component {
        id: listViewComponent
        CentralListView {
        }
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
                color: "#364451";
            }
        }
    }

    Component.onCompleted: {
		projects.feedViewModel = netContext.getFeedViewModel()
        headerBar.addTab("Groups", -1)
    }

    HelpPopUp {
        id: helpPopUp;
        anchors.centerIn: parent;
    }

    LoadingErrorPopUp {
        id: loadingErrorPopUp;
        anchors.centerIn: parent;

        onRefreshRequested: {
            netContext.reloadResources();
		    projects.feedViewModel = netContext.getFeedViewModel()
            if (netContext.loadingError() === "") {
                loadingErrorPopUp.close();
            }
        }
    }
}
