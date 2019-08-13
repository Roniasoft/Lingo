import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.0

Item {
    id: root;
    property date currentTime: new Date();
    property alias txtProjectDetails: txtProjectDetails
    property alias txtProjectTitle: txtProjectTitle

    Timer {
        id: timer;
        repeat: false;
        interval: 10000;
        onTriggered: {
            txtDateTime.text = currentTime.toLocaleTimeString(locale, Locale.LongFormat);
        }

    }

    Image {
        id: image
        x: 42
        y: 29
        width: 153
        antialiasing: true
        fillMode: Image.PreserveAspectFit
        source: "images/project.png"
    }

    Text {
        id: txtProjectTitle;
        x: 201
        y: 29
        width: 239
        height: 58
        text: qsTr("Project Title")
        font.bold: true
        font.pixelSize: 35
        color: "#0e1621";
    }

    Text {
        id: txtProjectDetails
        x: 205
        y: 78
        width: 73
        height: 21
        text: qsTr("Project Details")
        font.bold: true
        font.pixelSize: 12
        color: "#0e1621";
    }

    Text {
        id: text2
        x: 205
        y: 117
        width: 73
        height: 19
        text: qsTr("Last updated:")
        font.pixelSize: 12
        color: "#17212b";
    }


    Row {
        spacing: 15;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 50
        AnimatedImage {
            id: animation;
            width: 40
            source: "images/loader.gif"
            height: 32;
            fillMode: Image.PreserveAspectFit
            playing: timer.running;
            visible: playing;
        }

        FlatButton {
            id: button;
            height: 35;
            labelString: timer.running ? "Publishing..." : qsTr("Publish");
            enabled: !timer.running;
//            labelIcon: "images/Icons-filled/openedFolderHovered.png";
//            labelIconHovered: "images/Icons-filled/openedFolderHovered.png";
            anchors.verticalCenter: animation.verticalCenter;
            onButtonClicked: {
                timer.start();
            }
        }
    }

    Label {
        id: label
        x: 67
        y: 206
        width: parent.width * 0.85;
        height: 202

        text: qsTr("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida. Nisl nunc mi ipsum faucibus vitae aliquet nec ullamcorper. Amet luctus venenatis lectus magna fringilla. Volutpat maecenas volutpat blandit aliquam etiam erat velit scelerisque in. Egestas egestas fringilla phasellus faucibus scelerisque eleifend. Sagittis orci a scelerisque purus semper eget duis. Nulla pharetra diam sit amet nisl suscipit. Sed adipiscing diam donec adipiscing tristique risus nec feugiat in. Fusce ut placerat orci nulla. Pharetra vel turpis nunc eget lorem dolor. Tristique senectus et netus et malesuada.

Etiam tempor orci eu lobortis elementum nibh tellus molestie. Neque egestas congue quisque egestas. Egestas integer eget aliquet nibh praesent tristique. Vulputate mi sit amet mauris. Sodales neque sodales ut etiam sit. Dignissim suspendisse in est ante in. Volutpat commodo sed egestas egestas. Felis donec et odio pellentesque diam. Pharetra vel turpis nunc eget lorem dolor sed viverra. Porta nibh venenatis cras sed felis eget. Aliquam ultrices sagittis orci a. Dignissim diam quis enim lobortis. Aliquet porttitor lacus luctus accumsan. Dignissim convallis aenean et tortor at risus viverra adipiscing at.")
        clip: false
        wrapMode: Text.WordWrap
        fontSizeMode: Text.Fit
        textFormat: Text.PlainText
        Layout.fillWidth: true


        horizontalAlignment: Text.AlignJustify
        anchors.horizontalCenter: parent.horizontalCenter;
        color: "#2b5278";
    }

    Text {
        id: txtDateTime
        x: 288
        y: 117
        width: 73
        height: 19
        text: qsTr("04:34:33 AM")
        font.bold: true
        font.pixelSize: 12
        color: "#17212b";
    }

}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
