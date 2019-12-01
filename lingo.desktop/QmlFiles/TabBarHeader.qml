import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Universal 2.12
import QtQuick.Controls.Material 2.12

Pane {
    id: control
    property var style
    property var menuOpened
    property int currentIndex: tabBar.currentIndex
    signal menuClicked()
    height: style.height
    Universal.foreground: style.foreground
    Universal.background: style.background
    Universal.accent: style.accent
    Material.foreground: style.foreground
    Material.background: style.background
    Material.accent: style.accent

    topPadding: 0
    bottomPadding: 0
    leftPadding: 0
    rightPadding: 0

    NiceTabBar {
        id: tabBar
        Universal.foreground: style.foregroundTabs
        Material.foreground: style.foregroundTabs
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
    }

    Component {
        id: tabButtonComponent
        TabButton {
            id: tabButton;
            property int projectId
            width: implicitWidth
            height: implicitHeight
            font.pixelSize: fontSize + 1;
            topInset: 0
            topPadding: 5 * scaleFactor;
        }
    }

    function addTab(text, projectId) {
        var tabButton = tabButtonComponent.createObject(tabBar,  {text: text, height: style.height})
        tabButton.projectId = projectId
        tabButton.text = text
        tabBar.insertItem(tabBar.count, tabButton)
    }

    function toMainFeed() {
        tabBar.currentIndex = 0
    }

    function switchTo(projectId) {
        for (var i = 0; i < tabBar.count; i++) {
            if (tabBar.itemAt(i).projectId === projectId) {
                tabBar.currentIndex = i
                return
            }
        }
    }

}
