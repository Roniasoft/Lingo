import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3

Rectangle {
    height: 200
    width: 600;
    clip: true;

    property alias txtEditComment: commentTextEditBlock.txtEdit
    property alias txtEditTranslation: translationTextEditBlock.txtEdit
    property alias txtEditEng: englishTextEditBlock.txtEdit

    // top highlighted rect
    Rectangle {
        id: topHighlightRect;
        color: "#253646";
        width: parent.width;
        height: 36;
    }

    // translation text boxes
    RowLayout {
        id: rowLayout;
        y: 40;
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.leftMargin: 10;
        anchors.rightMargin: 10;

        // english box
        Column {
            id: englishColumn;
            Layout.fillWidth: true;
            Layout.preferredWidth: 290;
            spacing: 2;
            Text {
                id: txtProjectDesc
                text: qsTr("English:")
                color: txtEditEng.focus ? "#65a8e5" : "#6f8398";
            }
            TTextEditBlock {
                id: englishTextEditBlock
                width: parent.width;
                height: 75
                KeyNavigation.tab: txtEditTranslation;
                isReadOnly: false;
            }
        }

        // translation box
        Column {
            id: translationColumn;
            Layout.fillWidth: true;
            Layout.preferredWidth: 290;
            spacing: 2;
            Text {
                id: txtProjectDesc1
                color: txtEditTranslation.focus ? "#65a8e5" : "#6f8398";
                text: qsTr("Translation:")
            }
            TTextEditBlock {
                id: translationTextEditBlock
                width: parent.width;
                height: 75
                KeyNavigation.tab: txtEditComment;
            }
        }
    }

    // comment box
    Column {
        id: commentColumn
        width: rowLayout.width * 0.49;
        x: 11
        y: 136
        spacing: 2;
        Text {
            id: txtProjectDesc2
            color: txtEditComment.focus ? "#65a8e5" : "#6f8398"
            text: qsTr("Comment:")
        }
        TTextEditBlock {
            id: commentTextEditBlock
            width: parent.width;
            height: 45
            KeyNavigation.tab: txtEditEng;
        }
    }
}
