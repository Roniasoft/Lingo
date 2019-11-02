import QtQuick 2.0

Item {
    id: summarySection;
    opacity: isOpen ? 0 : 1;
    

    Text {
        id: txtEnglish;
        text: english
        color: "white";
        font.pixelSize: fontSize;
        width: 0.25 * parent.width;
        anchors.left: parent.left;
        anchors.leftMargin: parent.width * 0.30;
        anchors.top: parent.top;
        height: 36;
        clip: true;
    Behavior on opacity {
        NumberAnimation { easing.type: Easing.OutSine; duration: 200 }
    }
    }

    Text {
        id: txtTranslation;
        text: translation
        color: "#999999";
        width: 0.30 * parent.width;
        font.pixelSize: fontSize;
        anchors.left: parent.left;
        anchors.leftMargin: parent.width * 0.6;
        anchors.top: parent.verticalCenter;
        height: 36;
        clip: true;
    Behavior on opacity {
        NumberAnimation { easing.type: Easing.OutSine; duration: 200 }
    }
    }
}