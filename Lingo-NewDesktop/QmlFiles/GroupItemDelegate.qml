import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Universal 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

ItemDelegate {
    id: control
    property var style

    Universal.background: style.feedBackground
    Material.background: style.feedBackground


    contentItem: Pane {
        id: itemControl
        width: parent.width

        verticalPadding : 13;//control.style.itemsVPadding
        horizontalPadding : 13;//control.style.itemsHPadding

        topInset: verticalPadding - control.style.insetVDiff
        bottomInset: verticalPadding - control.style.insetVDiff
        leftInset: horizontalPadding - control.style.insetHDiff
        rightInset: horizontalPadding - control.style.insetHDiff

        Row {
            id: rootItem
            spacing: control.style.imageSpacing
            anchors.fill: parent

            Image {
                id: previewImg
                anchors.verticalCenter: parent.verticalCenter
                source: imageURL
                fillMode: Image.PreserveAspectFit
                height: 64;
                antialiasing: true;
            }

            Column {
                id: textColumn
                anchors.top: parent.top
                spacing: control.style.titleSpacing
                width: parent.width - parent.spacing - previewImg.width
                RowLayout {
                    id: titleHeader
                    width: parent.width

                    Label {
                        id: titleLabel
                        verticalAlignment: Text.AlignTop
                        text: title
                        Layout.fillWidth: true
                        font {
                            weight: Font.DemiBold
                            pixelSize: control.style.titleFontPixelSize
                        }
                    }
                    Label {
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignTop
                        text: updateTime
                        font {
                            italic: true
                            pixelSize: control.style.timeFontPixelSize
                        }
                    }
                }
                Label {
                    id: summaryLabel
                    width: parent.width
                    verticalAlignment: Text.AlignTop
                    font.pixelSize: control.style.summaryFontPixelSize
                    text: summary
                    wrapMode: Text.WordWrap
                }
            }
        } // Row rootItem
    }
}
