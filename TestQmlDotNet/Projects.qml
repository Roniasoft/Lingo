import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.1

Rectangle {
    color: "#0e1621";
    signal openRequested(var projName, var projDetail, var index);
    signal closeRequested(var index);
    signal itemDeleted();

    function openProject(indx) {
        projectsModel.get(indx).isOpen = true;
    }


    function closeProject(indx) {
        projectsModel.get(indx).isOpen = false;
    }

    FlatButton {
        id: btnNewProject;
        labelString: "New Project";
        onButtonClicked: newProjectDialog.open();
        labelIcon: "images/Icons/NewProjectH.png";
        labelIconHovered: "images/Icons/NewProjectH.png";
        anchors.top: parent.top;
        anchors.topMargin: 20;
        anchors.left: parent.left;
        anchors.leftMargin: 20;
    }

    NewProject {
        id: newProjectDialog;
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        btnSaveNewProject.onButtonClicked: {
            projectsModel.append({"name": txtEditProjectTitle.text, "detailText":txtEditProjectDesc.text, "isOpen":false});
//            projectsModel.sync();
            newProjectDialog.close();
        }
    }


    ListView {
        id: listView;
        anchors.top: btnNewProject.bottom;
        anchors.topMargin: 15;
        anchors.left: parent.left;
        anchors.leftMargin: 20;
        anchors.right: parent.right;
        anchors.rightMargin: 20;
        //        height: parent.height * 0.78;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 5;
        clip: true;

        Component {
            id: contactsDelegate
            Rectangle {
                id: wrapper
                width: listView.width
                height: 36
                color: isOpen ? "#202b36" : ((mouseArea.containsMouse || imgCloseMA.containsMouse) ? "#253646" : "#17212b")

                Text {
                    id: txtIndex
                    text: index < 9 ? (index + 1) : "9";
                    visible: index < 9;
                    font.bold: isOpen;
                    anchors.left: parent.left;
                    anchors.leftMargin: 5;
                    anchors.verticalCenter: parent.verticalCenter;
                    font.pixelSize: 8
                    color: isOpen ? "white" : "#7f7f7f";
                }

                Image {
                    id: imgIcon
                    height: 14;
                    anchors.left: txtIndex.right;
                    anchors.leftMargin: 5;
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: parent.verticalCenter;
                    source: isOpen ? "images/Icons-filled/openedFolder2.png" :
                                     "images/Icons-filled/Folder.png";
                }

                Column {
                    anchors.left: imgIcon.right;
                    anchors.leftMargin: 10;
                    anchors.verticalCenter: parent.verticalCenter;
                    Text {
                        id: txtName;
                        text: name
                        font.bold: isOpen
                        //                        font.underline:  (wrapper.ListView.isCurrentItem || mouseArea.containsMouse) ? true : false;
                        color:"white";// wrapper.ListView.isCurrentItem ? "#6cc63d" : "#6cc63d"
                    }
                    Text {
                        id: txtDetailed;
                        text: detailText
                        color: isOpen ? "white" : "#999999";
                        font.pixelSize: 10
                    }
                }

                Image {
                    id: imgClose
                    source: imgCloseMA.containsMouse ? "images/Icons-filled/closeHovered.png" :
                                                       "images/Icons-filled/close.png";
                    opacity: (mouseArea.containsMouse || imgCloseMA.containsMouse) ? 1 : 0;
                    height: 8;
                    scale: (imgCloseMA.containsMouse) ? 1.3 : 1.0;
                    anchors.right: parent.right;
                    anchors.rightMargin: 25;
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: parent.verticalCenter;
                    enabled: false;
                    z: 1000;

                    MouseArea {
                        id: imgCloseMA;
                        anchors.fill: parent;
                        hoverEnabled: true;
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                        }
                    }

                    Behavior on scale { NumberAnimation { easing.type: Easing.InQuad; duration: 100 }}
                }

                MouseArea {
                    id: mouseArea;
                    anchors.fill: parent;
                    hoverEnabled: true;
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        listView.currentIndex = index;
                    }

                    onDoubleClicked: {
                        listView.currentIndex = index;
                        var isOpen = !projectsModel.get(listView.currentIndex).isOpen;
                        projectsModel.get(listView.currentIndex).isOpen = isOpen;

                        if (isOpen) {
                            openRequested(projectsModel.get(listView.currentIndex).name,
                                          projectsModel.get(listView.currentIndex).detailText,
                                          index);
                        }
                        if (!isOpen) {
                            closeRequested(index);
                        }
                    }
                }
            }
        }

        model:projectsModel
        delegate: contactsDelegate
        focus: true
    }

    ListModel {
        id: projectsModel;
        ListElement {
            name: "Project 1"
            detailText: "Desktop application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 2"
            detailText: "Embedded application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 3"
            detailText: "Desktop application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 4"
            detailText: "Embedded application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 5"
            detailText: "Desktop application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 6"
            detailText: "Embedded application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 7"
            detailText: "Desktop application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 8"
            detailText: "Embedded application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 9"
            detailText: "Desktop application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 10"
            detailText: "Embedded application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 11"
            detailText: "Desktop application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 12"
            detailText: "Embedded application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 13"
            detailText: "Desktop application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 14"
            detailText: "Embedded application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 15"
            detailText: "Desktop application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 16"
            detailText: "Embedded application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 17"
            detailText: "Desktop application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 18"
            detailText: "Embedded application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 19"
            detailText: "Desktop application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 20"
            detailText: "Embedded application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 21"
            detailText: "Desktop application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 22"
            detailText: "Embedded application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 23"
            detailText: "Desktop application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 24"
            detailText: "Embedded application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 25"
            detailText: "Desktop application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 26"
            detailText: "Embedded application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 27"
            detailText: "Desktop application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 28"
            detailText: "Embedded application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 29"
            detailText: "Desktop application project"
            isOpen: false;
        }
        ListElement {
            name: "Project 30"
            detailText: "Embedded application project"
            isOpen: false;
        }
    }

}
