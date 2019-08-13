import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.1

ApplicationWindow {
    id: window
    width: 640
    height: 680
    visible: true
    title: "Project Management"
    flags: Qt.FramelessWindowHint | Qt.Window // Disable window frame

    Material.theme: Material.Dark
    Material.accent: '#4885cc'
    Material.primary: '#4885cc'
    property alias footerLabel: footerLabel;

    property int previousX
    property int previousY

    property bool isMaximized: false;

    function updateStatusBar(msg) {
        footerLabel.text = msg;
        timerFooterCleaner.start();
    }

    Timer {
        id: resizingWindowTimer;
        interval: 500;
        repeat: false;
    }

    Timer {
        id: timerFooterCleaner;
        interval: 5000;
        repeat: false;

        onTriggered: footerLabel.text = "";
    }

    Component {
        id: tabButtonComponent
        TTabButton { }
    }
    Component {
        id: projectDetsComponent
        ProjectDetails { }
    }

    Settings {
        id: settings
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        onOption1DialogReq: {
            dlgOption.open();
            updateStatusBar("Option1 Dialog Opened!");
        }
        onOption2DialogReq: {
            dlgOption2.open();
            updateStatusBar("Option2 Dialog Opened!");
        }
    }

    Dialog {
        id: dlgOption
        width: parent.width;
        x: 0;
        clip: false
        dim: true
        modal: true;
        height: 200;
        y: (parent.height - height) / 2

        header: Rectangle {
            height: 35;
            width: parent.width;
        }

        background: Rectangle {
            Text {
                id: txtContent
                text: qsTr("Please choose one option!?")
                anchors.horizontalCenter: parent.horizontalCenter;
                y: 65;
            }

            Row {
                anchors.top: txtContent.bottom;
                anchors.topMargin: 25;
                anchors.horizontalCenter: parent.horizontalCenter;
                spacing: 20;

                FlatButton {
                    labelString: "Yes";
                    onButtonClicked: dlgOption.close();
                }

                FlatButton {
                    labelString: "No";
                    onButtonClicked: dlgOption.close()
                }
            }
        }
    }


    Dialog {
        id: dlgOption2
        width: parent.width;
        x: 0;
        clip: false
        dim: true
        modal: true;
        height: 240;
        y: (parent.height - height) / 2

        header: Rectangle {
            height: 35;
            width: parent.width;
        }

        background: Rectangle {

            Text {
                id: txtContent2
                text: qsTr("Progressing....")
                anchors.horizontalCenter: parent.horizontalCenter;
                y: 65;
            }

            ProgressBar {
                id: progressbar;
                anchors.top: txtContent2.bottom;
                anchors.topMargin: 20;
                anchors.horizontalCenter: parent.horizontalCenter;
                from: 0;
                to: 100;
                indeterminate: true;
                height: 30;
                width: 250;
            }

            FlatButton {
                anchors.top: progressbar.bottom;
                anchors.topMargin: 20;
                anchors.horizontalCenter: parent.horizontalCenter;
                labelString: "Cancel";
                onButtonClicked: {
                    dlgOption2.close();

                    updateStatusBar("Operation Cancelled by User...");
                }
                labelIcon: "images/Icons/CancelH.png";
                labelIconHovered: "images/Icons/CancelH.png";
            }
        }

    }

    header: ToolBar {
        id: header;
        Material.foreground: "#0e1621"
        height: 30

        background: Rectangle {
            color: "#0e1621"
            height: 30;
            anchors.fill: parent
            width: parent.width;

            Image {
                id: imgMenu
                source: "images/Icons/MenuH.png"
                width: 20;
                fillMode: Image.PreserveAspectFit;
                anchors.verticalCenter: parent.verticalCenter;
                anchors.left: parent.left;
                anchors.leftMargin: 5;

                MouseArea {
                    anchors.fill: parent;
                    cursorShape: Qt.PointingHandCursor;
                    onClicked: {
                        drawer.open();
                    }
                }
            }

            Label {
                id: titleLabel
                text: "Project Management";
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter;
                anchors.horizontalCenter: parent.horizontalCenter;
                color: "white";
            }

            Row {
                id: rowWindowButtons;
                anchors.right: parent.right;
                anchors.rightMargin: 0;
                anchors.top: parent.top;
                height: parent.height;
                Rectangle {
                    height: 30
                    width: 40;
                    color: maMinButton.containsMouse ? "#2c3847" : "#0e1621";
                    Image {
                        id: imgMinButton
                        anchors.verticalCenter: parent.verticalCenter;
                        anchors.horizontalCenter: parent.horizontalCenter;
                        height: 12;
                        source: maMinButton.containsMouse ? "images/WindowIcons/1H.png" :
                                                            "images/WindowIcons/1.png";
                        fillMode: Image.PreserveAspectFit
                    }

                    MouseArea {
                        id: maMinButton;
                        anchors.fill: parent;
                        hoverEnabled: true;
                        cursorShape: Qt.PointingHandCursor;
                        onClicked: window.showMinimized();
                    }
                }
                Rectangle {
                    height: 30
                    width: 40;
                    color: maMaxButton.containsMouse ? "#2c3847" : "#0e1621";
                    Image {
                        id: imgMaxButton
                        anchors.verticalCenter: parent.verticalCenter;
                        anchors.horizontalCenter: parent.horizontalCenter;
                        height: 12;
                        source: maMaxButton.containsMouse ? (isMaximized ? "images/WindowIcons/4H.png" : "images/WindowIcons/2H.png") :
                                                            (isMaximized ? "images/WindowIcons/4.png" : "images/WindowIcons/2.png");
                        fillMode: Image.PreserveAspectFit
                    }

                    MouseArea {
                        id: maMaxButton;
                        anchors.fill: parent;
                        hoverEnabled: true;
                        cursorShape: Qt.PointingHandCursor;
                        onClicked: {
                            resizingWindowTimer.start();
                            if (isMaximized) {
                                window.showNormal();
                            } else {
                                window.showMaximized();
                            }
                            isMaximized = !isMaximized;
                        }
                    }
                }
                Rectangle {
                    height: 30
                    width: 40;
                    color: maCloseButton.containsMouse ? "#e92539" : "#0e1621";
                    Image {
                        id: imgCloseButton
                        anchors.verticalCenter: parent.verticalCenter;
                        anchors.horizontalCenter: parent.horizontalCenter;
                        height: 12;
                        source: maCloseButton.containsMouse ? "images/WindowIcons/3H.png" :
                                                              "images/WindowIcons/3.png";
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

            MouseArea {
                id: maHeader;
                anchors.fill: parent;
                anchors.leftMargin:  5 + imgMenu.width + 5;
                anchors.rightMargin: rowWindowButtons.width + 5;
                anchors.topMargin: 5;

                onPressed: {

                    if (!resizingWindowTimer.running && isMaximized == false) {
                        previousX = mouseX
                        previousY = mouseY
                    }
                }

                onMouseXChanged: {
                    if (resizingWindowTimer.running || isMaximized)
                        return;

                    var dx = mouseX - previousX
                    window.setX(window.x + dx)
                }

                onMouseYChanged: {
                    var dy = mouseY - previousY
                    if (!resizingWindowTimer.running && dy > 5 && isMaximized) {
                        window.showNormal();
                        window.setY(mouseY);
                        isMaximized = false;
                        return;
                    }

                    if (resizingWindowTimer.running == false)
                        window.setY(window.y + dy)
                }

                onDoubleClicked: {
                    resizingWindowTimer.start();
                            if (isMaximized) {
                                window.showNormal();
                            } else {
                                window.showMaximized();
                            }
                            isMaximized = !isMaximized;
                }
            }

            MouseArea {
                id: topArea
                height: 5
                anchors {
                    top: parent.top
                    left: parent.left
                    right: maHeader.right;
                }
                // We set the shape of the cursor so that it is clear that this resizing
                cursorShape: Qt.SizeVerCursor

                onPressed: {
                    // We memorize the position along the Y axis
                    previousY = mouseY
                }

                // When changing a position, we recalculate the position of the window, and its height
                onMouseYChanged: {
                    var dy = mouseY - previousY
                    window.setY(window.y + dy)
                    window.setHeight(window.height - dy)
                }
            }
        }
    }


    Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 6 * 2
        height: window.height
        interactive: stackView.depth === 1
        background: Rectangle {
            color: "#0e1621";
        }
        ListView {
            id: listView
            Material.theme: Material.Dark
            Material.accent: '#4885cc'
            Material.primary: '#4885cc'
            focus: true
            currentIndex: -1
            anchors.fill: parent
            delegate: Rectangle {
                id: wrapper;
                width: listView.width;
                height: 36;
                color: dlgMouseArea.containsMouse ? "#2b5278" : "#17212b";
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
                    font.pixelSize: 12
                    color: "white";
                }
                MouseArea {
                    id: dlgMouseArea;
                    anchors.fill: parent;
                    hoverEnabled: true;
                    cursorShape: Qt.PointingHandCursor;
                    onClicked: {
                        listView.currentIndex =index;
                        if (index === 0) {
                            bar.setCurrentIndex(0);
                            drawer.close();
                            updateStatusBar("Returned to projects...");
                        }
                        if (index === 1)  {
                            settings.open();
                            updateStatusBar("Settings Opened...");
                        }
                        if (index === 2) {
                            Qt.quit();
                        }
                    }
                }
            }

            model: ListModel {
                ListElement { title: "Projects"; source: "Projects.qml"; iconSrc: "images/Icons/ProjectH.png" }
                //                ListElement { title:  "  "; source: "" }
                ListElement { title: "Preferences"; source: "" ; iconSrc: "images/Icons/SettingsH.png"}
                ListElement { title: "Exit"; source: "" ; iconSrc: "images/Icons/ExitH.png"}
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: Item{}
    }

    TabBar {
        id: bar;
        anchors.top: header.bottom;
        background: Rectangle {
            color: "#464748"
        }

        //            TabBar {
        width: parent.width;
        TTabButton {
            text: qsTr("Projects")
            closeable: false;
        }
        //            }
    }

    StackLayout {
        id: stacklayout;
        width: parent.width
        height: parent.height;
        //        anchors.fill: parent;
        anchors.top: bar.bottom;
        currentIndex: bar.currentIndex

        Projects {
            id: projectsTab;
            height: parent.height * 0.8;

            onOpenRequested: {
                var tab = tabButtonComponent.createObject(bar, {text: projName});
                tab.projectIndex = index;
                bar.addItem(tab);

                tab.closeTab.connect(tabCloseRequested);



                var projectDets = projectDetsComponent.createObject(stacklayout, {});
                projectDets.txtProjectTitle.text = projName;
                projectDets.txtProjectDetails.text = projDetail;
                stacklayout.children.push(projectDets);


                updateStatusBar("Project tab (" + projName + ") opened...");
            }

            onCloseRequested: {
                for (var i = 0; i < bar.count; i++) {
                    if (bar.itemAt(i).projectIndex === index) {
                        bar.removeItem(i);
                        updateStatusBar("Project tab (" + stacklayout.itemAt(i).txtProjectTitle.text + ") closed...");
                        stacklayout.itemAt(i).destroy();
                    }
                }

            }
        }
    }

    function tabCloseRequested(projIndex) {
        projectsTab.closeProject(projIndex);
        for (var i = 0; i < bar.count; i++) {
            if (bar.itemAt(i).projectIndex === projIndex) {
                bar.removeItem(i);
                updateStatusBar("Project tab (" + stacklayout.itemAt(i).txtProjectTitle.text + ") closed...");
                stacklayout.itemAt(i).destroy();
            }
        }
    }

    Dialog {
        id: aboutDialog
        modal: true
        focus: true
        title: "About"
        x: (window.width - width) / 2
        y: window.height / 6
        width: Math.min(window.width, window.height) / 3 * 2

        Label {
            width: aboutDialog.availableWidth
            text: "Qml.Net is a bridge between .NET and Qml, allowing you to build powerfull user-interfaces driven by the .NET Framework."
            wrapMode: Label.Wrap
            font.pixelSize: 12
        }
    }

    footer: ToolBar {
        id: footerBar;
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

            // Similar calculations for the remaining three areas of resize
            MouseArea {
                id: bottomArea
                height: 5
                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                }
                cursorShape: Qt.SizeVerCursor

                onPressed: {
                    previousY = mouseY
                }

                onMouseYChanged: {
                    var dy = mouseY - previousY
                    window.setHeight(window.height + dy)
                }
            }
        }
    }


    MouseArea {
        id: leftArea
        width: 5
        anchors {
            top: footerBar.bottom
            bottom: header.bottom;
            left: parent.left
        }
        cursorShape: Qt.SizeHorCursor

        onPressed: {
            previousX = mouseX
        }

        onMouseXChanged: {
            var dx = mouseX - previousX
            window.setX(window.x + dx)
            window.setWidth(window.width - dx)
        }
    }

    MouseArea {
        id: rightArea
        width: 5
        anchors {
            top: header.bottom
            bottom: footerBar.top
            right: parent.right
        }
        cursorShape:  Qt.SizeHorCursor

        onPressed: {
            previousX = mouseX
        }

        onMouseXChanged: {
            var dx = mouseX - previousX
            window.setWidth(window.width + dx)
        }
    }
}
