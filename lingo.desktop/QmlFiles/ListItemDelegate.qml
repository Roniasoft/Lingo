import QtQuick 2.9
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Rectangle {
    id: delegate
    color: (highlighted ? "#253646" : "#17212b");
    property alias detailedSection: detailedSection;
    property bool isDetailed: isOpen;
    property int anmDuration: 20

    signal updateRequested(var aName, var aTranslation, var aIsCompleted);

    onIsDetailedChanged:{
        if (isDetailed) {
            detailedSection.txtEditTranslation.focus = true;
            detailedSection.txtEditTranslation.cursorPosition = detailedSection.txtEditTranslation.text.length
            detailedSection.txtEditTranslation.forceActiveFocus();
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
                    proxyModel.set(lastOpened, "highlighted", false);
                    proxyModel.set(lastOpened, "isOpen", false);
                }

                listView.currentIndex = index;
                var isOpen = !proxyModel.get(listView.currentIndex).isOpen;
                proxyModel.set(listView.currentIndex, "isOpen", isOpen);

                lastOpened = index;
            }
        }
    }

    // summary view of the items (when items are closed)
    // ItemSummaryView {
    //     id: summarySection;
    //     anchors.top: parent.top;
    //     anchors.topMargin: 17;
    //     anchors.left: parent.left;
    //     anchors.right: parent.right;
    // }

    // detailed view of the opened item.
    ItemDetailedView {
        id: detailedSection;
        height: isOpen ? 210 * scaleFactor : 0;
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

       Text {
        id: txtEnglish;
        text: english.replace(/(\r\n|\n|\r)/gm, " ");
        color: "white";
        font.pixelSize: fontSize;
        width: 0.25 * parent.width;
        anchors.left: parent.left;
        anchors.leftMargin: parent.width * 0.30;
        anchors.verticalCenter: txtIndex.verticalCenter;
        // height: 36;
        opacity: isOpen ? 0 : 1;
        clip: true;
        wrapMode: Text.NoWrap
    Behavior on opacity {
        NumberAnimation { easing.type: Easing.OutSine; duration: 200 }
    }
    }

    Text {
        id: txtTranslation;
        text: translation.replace(/(\r\n|\n|\r)/gm, " ");
        color: "#999999";
        width: 0.30 * parent.width;
        font.pixelSize: fontSize;
        anchors.left: parent.left;
        anchors.leftMargin: parent.width * 0.6;
        anchors.verticalCenter: txtIndex.verticalCenter;
        // height: 36;
        opacity: isOpen ? 0 : 1;
        clip: true;
        wrapMode: Text.NoWrap
    Behavior on opacity {
        NumberAnimation { easing.type: Easing.OutSine; duration: 200 }
    }
    }

    // checkbox for displaying completeness of the items.
    CheckBox {
        id: chckboxCompleted
        anchors.right: delegate.right;
        anchors.rightMargin: 20;
        anchors.verticalCenter: txtIndex.verticalCenter;
        checked: completed;
        Material.accent: "#00B10D";

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
                proxyModel.set(index, "highlighted", true);
            } else {
                proxyModel.set(index, "highlighted", false);
            }
        }

        onPressed: {
            mouse.accepted = false;
            flickDetectorTimer.start();
        }
    }
}
