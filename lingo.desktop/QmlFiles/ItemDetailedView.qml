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
                color: (!englishTextEditBlock && txtEditEng.focus) ? "#65a8e5" : "#6f8398";
                font.pixelSize: fontSize - 1;
            }
            TTextEditBlock {
                id: englishTextEditBlock
                width: parent.width;
                height: 75
                isReadOnly: true;
                txtEdit.text: english;
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
                color: (txtEditTranslation.focus) ? "#65a8e5" : "#6f8398";
                text: qsTr("Translation:")
                font.pixelSize: fontSize - 1;
            }
            TTextEditBlock {
                id: translationTextEditBlock
                width: parent.width;
                height: 75
                isReadOnly: false;
                txtEdit.text: translation;
            }
        }
    }

    // comment box
    Column {
        id: commentColumn
        width: translationColumn.width*2;
        x: 11
        y: 136
        spacing: 2;
        Text {
            id: txtProjectDesc2
            color: (!commentTextEditBlock && txtEditComment.focus) ? "#65a8e5" : "#6f8398"
            text: qsTr("Comment:")
            font.pixelSize: fontSize - 1;
        }
        TTextEditBlock {
            id: commentTextEditBlock
            width: parent.width;
            height: 45
            txtEdit.text: comment;
        }
    }
}