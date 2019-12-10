import QtQuick 2.12
import QtQuick.Controls 2.12
import NetViewModels 1.0
import QtQuick.Controls.Universal 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

Pane {
    id: control
	property var feedViewModel
    property var style
    property int scrollWidth: scrollBar.visible ? scrollBar.width : 0
	signal openProjectRequested(var project)
	signal switchToProjectRequested(var project)

    Universal.background: style.background
    Material.background: style.background

    ListView {
        id: listView
        focus: true
        currentIndex: -1
        anchors.fill: parent
        clip: true;
        
        delegate: GroupItemDelegate {
            id: itemDelegate;
            width: parent.width
            style: control.style
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor;
                onClicked: {
                    var project = control.feedViewModel.getProjectViewModel(modelData.projectId)

					if (control.feedViewModel.isProjectOpened(modelData.projectId)) {
						control.switchToProjectRequested(project)
						return
					}
					control.feedViewModel.markProjectOpened(modelData.projectId)
					control.openProjectRequested(project)
                }
            }

            Button {
                id: btnExp;
                text: "Find in Explorer";
                icon.source: "../images/Icons/White/File.png";
                icon.height: 18 * scaleFactor;
                icon.width: 18 * scaleFactor;
                font.pixelSize: fontSize - 2;
                font.capitalization: Font.Capitalize;
                anchors.right: parent.right;
                anchors.rightMargin: 30;
                anchors.bottom: parent.bottom;
                anchors.bottomMargin: 10 * scaleFactor;
                

                MouseArea {
                    anchors.fill: parent;
                    hoverEnabled: true;
                    cursorShape: Qt.PointingHandCursor
                    
                    propagateComposedEvents: true
                    onClicked: mouse.accepted = false;
                    onPressed: mouse.accepted = false;
                    onReleased: mouse.accepted = false;
                    onDoubleClicked: mouse.accepted = false;
                    onPositionChanged: mouse.accepted = false;
                    onPressAndHold: mouse.accepted = false;
                }
                onClicked: {
                    netContext.openSelectedGroupItem(modelData.langKey);
                }
            }
        }
		
		model: Net.toListModel(control.feedViewModel.projects)

        ScrollBar.vertical: ScrollBar {
            id: scrollBar
            opacity: 0.3;
            width: 5 * scaleFactor;
        }
    }
}
