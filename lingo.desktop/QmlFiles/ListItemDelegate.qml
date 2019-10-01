import QtQuick 2.9

Rectangle {
    id: delegate
    color: (highlighted ? "#253646" : "#17212b");
    property alias detailedSection: detailedSection;
    property bool isDetailed: isOpen;
    property int anmDuration: 20

    signal updateRequested(var aName, var aTranslation, var aIsCompleted);

    onIsDetailedChanged: {
        if (isDetailed) {
            detailedSection.txtEditTranslation.focus = true;
        } else {
            detailedSection.txtEditTranslation.focus = false;
        }
    }

    Behavior on height {
        NumberAnimation { easing.type: Easing.OutSine; duration: anmDuration }
    }

    Timer {
        id: flickDetectorTimer;
        interval: 100; //ms
        repeat: false;

        onTriggered: {
            if (listView.dragging === false) {
                if (lastOpened !== -1 && lastOpened !== index) {
                    listModel.get(lastOpened).highlighted = false;
                    listModel.get(lastOpened).isOpen = false;
                }

                listView.currentIndex = index;
                var isOpen = !listModel.get(listView.currentIndex).isOpen;
                listModel.get(listView.currentIndex).isOpen = isOpen;

                lastOpened = index;
            }
        }
    }

    // summary view of the items (when items are closed)
    ItemSummaryView {
        id: summarySection;
        anchors.top: parent.top;
        anchors.topMargin: 17;
        anchors.left: parent.left;
        anchors.right: parent.right;
    }

    // detailed view of the opened item.
    ItemDetailedView {
        id: detailedSection;
        height: isOpen ? 210 : 0;
        opacity: isOpen ? 1 : 0;
        width: isOpen ? parent.width : parent.width;
        color: isOpen ? "#232e3c" : "#253646";
        clip: true;

       txtEditTranslation.onEditingFinished: {
            if (translation != txtEditTranslation.text) {
                translation = txtEditTranslation.text;
                updateRequested(name, translation, completed);
            }
       }

        Behavior on height {
            NumberAnimation { easing.type: Easing.OutSine; duration: anmDuration }
        }

        Behavior on opacity {
            NumberAnimation { easing.type: Easing.OutSine; duration: anmDuration }
        }
        Behavior on color {
            ColorAnimation {
                duration: 350
                easing.type: Easing.OutCubic;
            }
        }
    }

    // index string of each item.
    Text {
        id: txtIndex
        text: (index + 1);
        anchors.left: parent.left;
        anchors.leftMargin: 10;
        font.pixelSize: fontSize - 2;
        color: "#7f7f7f";
        anchors.top: parent.top;
        anchors.topMargin: 24 - fontSize;
    }

    // name id
    Text {
        id: txtName;
        text: name
        anchors.left: parent.left;
        anchors.leftMargin: 35;
        anchors.verticalCenter: txtIndex.verticalCenter;
        clip: true;
        width: isOpen ? parent.width * 0.8 : parent.width * 0.2;
        color: "white";
        font.pixelSize: fontSize;
    }

    // checkbox for displaying completeness of the items.
    TCheckBox {
        id: chckboxCompleted
        anchors.right: delegate.right;
        anchors.rightMargin: 20;
        anchors.verticalCenter: txtIndex.verticalCenter;
        checked: completed;

        onCheckedChanged: {
            completed = chckboxCompleted.checked;
            updateRequested(name, translation, completed);//CHECK. This should'nt be called this way since this is called recursively after model is filled.
        }
    }

    MouseArea {
        id: mouseArea;
        anchors.fill: parent;
        anchors.bottomMargin: isOpen ? parent.height - 36 : 0;
        anchors.rightMargin: chckboxCompleted.width + 20;
        hoverEnabled: true;
        cursorShape: isOpen ? Qt.ArrowCursor : Qt.PointingHandCursor;
        propagateComposedEvents: true;

        onHoveredChanged: {
            if (mouseArea.containsMouse) {
                listModel.get(index).highlighted = true;
            } else {
                listModel.get(index).highlighted = false;
            }
        }

        onPressed: {
            mouse.accepted = false;
            flickDetectorTimer.start();
        }
    }
}
