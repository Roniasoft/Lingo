import QtQuick 2.0

Item {
    id: summarySection;
    opacity: modelData.isOpen ? 0 : 1;

    Behavior on opacity {
        NumberAnimation { easing.type: Easing.OutSine; duration: 200 }
    }

    Text {
        id: txtEnglish;
        text: modelData.value
        color: "white";
        font.pixelSize: fontSize;
        anchors.left: parent.left;
        anchors.leftMargin: parent.width * 0.30;
        anchors.verticalCenter: parent.verticalCenter;
    }

    Text {
        id: txtTranslation;
        text: modelData.translation
        color: "#999999";
        font.pixelSize: fontSize;
        anchors.left: parent.left;
        anchors.leftMargin: parent.width * 0.6;
        anchors.verticalCenter: parent.verticalCenter;
    }
}
