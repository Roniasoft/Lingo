import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls 2.10
// import QtQuick.VirtualKeyboard 2.0
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.0

Dialog {
    id: control;
    width: 420
    height: 450
    modal: true
    focus: true
    title: "Shortcuts";
    standardButtons: Dialog.Ok

    GridLayout {
            x: 0
            y: 28
            width: 266
            height: 275
            columnSpacing: 18
            rows: 6
            columns: 2

            Text {
                text: "Up/Down:"
                font.bold: true
                Layout.preferredHeight: 18
                Layout.preferredWidth: 76
                font.pointSize: 10
                color: "white";
            }

            Text {
                color: "#ffffff"
                text: "Move highlighted Row Up/Down."
                Layout.preferredHeight: 18
                Layout.preferredWidth: 76
                styleColor: "#07d336"
                font.pointSize: 10
            }

            Text {
                color: "#ffffff"
                text: "Return/Enter:"
                font.bold: true
                Layout.preferredHeight: 18
                Layout.preferredWidth: 76
                font.pointSize: 10
            }

            Text {
                color: "#ffffff"
                text: "Expand Highlighted Row."
                Layout.preferredHeight: 18
                Layout.preferredWidth: 76
                font.pointSize: 10
                styleColor: "#07d336"
            }

            Text {
                color: "#ffffff"
                text: "Escape:"
                font.bold: true
                Layout.preferredHeight: 18
                Layout.preferredWidth: 76
                font.pointSize: 10
            }

            Text {
                color: "#ffffff"
                text: "Collapse Opened Row."
                Layout.preferredHeight: 18
                Layout.preferredWidth: 76
                font.pointSize: 10
                styleColor: "#07d336"
            }

            Text {
                color: "#ffffff"
                text: "Tab:"
                font.bold: true
                Layout.preferredHeight: 18
                Layout.preferredWidth: 76
                font.pointSize: 10
            }

            Text {
                color: "#ffffff"
                text: "Move Down and Open."
                Layout.preferredHeight: 18
                Layout.preferredWidth: 76
                font.pointSize: 10
                styleColor: "#07d336"
            }

            Text {
                color: "#ffffff"
                text: "Ctrl+Return/Ctrl+Enter:"
                font.bold: true
                Layout.preferredHeight: 18
                Layout.preferredWidth: 136
                font.pointSize: 10
            }

            Text {
                color: "#ffffff"
                text: "Toggle Completed."
                Layout.preferredHeight: 18
                Layout.preferredWidth: 76
                font.pointSize: 10
                styleColor: "#07d336"
            }

            Text {
                color: "#ffffff"
                text: "Ctrl+Del:"
                font.bold: true
                Layout.preferredHeight: 18
                Layout.preferredWidth: 76
                font.pointSize: 10
            }

            Text {
                color: "#ffffff"
                text: "Uncheck Completed."
                Layout.preferredHeight: 18
                Layout.preferredWidth: 76
                font.pointSize: 10
                styleColor: "#07d336"
            }
    }
}