import QtQuick 2.12
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

//    FlatButton {
//        id: btnNewProject;
//        labelString: "New Project";
//        onButtonClicked: newProjectDialog.open();
//        labelIcon: "qrc:/images/Icons/NewProjectH.png";
//        labelIconHovered: "qrc:/images/Icons/NewProjectH.png";
//        anchors.top: parent.top;
//        anchors.topMargin: 20;
//        anchors.left: parent.left;
//        anchors.leftMargin: 20;
//    }

//    NewProject {
//        id: newProjectDialog;
//        x: (parent.width - width) / 2;
//        y: (parent.height - height) / 2;

//        btnSaveNewProject.onButtonClicked: {
//            projectsModel.append({"name": txtEditProjectTitle.text, "detailText":txtEditProjectDesc.text, "isOpen":false});
//            //            projectsModel.sync();
//            newProjectDialog.close();
//        }
//    }



    Rectangle {
        id: header;
        anchors.top: parent.top;
        anchors.topMargin: 15;
        width: listView.width;
        anchors.horizontalCenter: listView.horizontalCenter;
        color: "#364451";
        height: 30;
    }

    ListView {
        id: listView;
        anchors.top: header.bottom;
        anchors.topMargin: 0;
        anchors.left: parent.left;
        anchors.leftMargin: 20;
        anchors.right: parent.right;
        anchors.rightMargin: 20;
        //        height: parent.height * 0.78;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 5;
        clip: true;
        ScrollBar.vertical: ScrollBar{}
        ScrollBar.horizontal: ScrollBar{}

        Component {
            id: contactsDelegate
            Rectangle {
                id: wrapper
                width: listView.width
                height: isOpen ? 200 : 36;
                color: isOpen ? "white" : ((mouseArea.containsMouse || imgCloseMA.containsMouse || maEditEditable.containsMouse) ? "#253646" : "#17212b")
                //                color: isOpen ? "#202b36" : ((mouseArea.containsMouse || imgCloseMA.containsMouse || maEditEditable.containsMouse) ? "#253646" : "#17212b")


                Behavior on height {
                    NumberAnimation { easing.type: Easing.OutSine; duration: 400 }
                }

                Item {
                    id: summarySection;
                    opacity: isOpen ? 0 : 1;
                    anchors.top: parent.top;
                    anchors.topMargin: 15;

                    Behavior on opacity {
                        NumberAnimation { easing.type: Easing.OutSine; duration: 400 }
                    }

                    Text {
                        id: txtName;
                        text: name
                        anchors.left: parent.right;
                        anchors.leftMargin: 50;
                        anchors.verticalCenter: parent.verticalCenter;
                        //                        font.underline:  (wrapper.ListView.isCurrentItem || mouseArea.containsMouse) ? true : false;
                        color:"white";// wrapper.ListView.isCurrentItem ? "#6cc63d" : "#6cc63d"
                    }
                    Text {
                        id: txtDetailed;
                        text: detailText
                        color: "#999999";
                        font.pixelSize: 10
                        anchors.left: txtName.right;
                        anchors.leftMargin: 5;
                        anchors.verticalCenter: parent.verticalCenter;
                    }
                    Text {
                        id: txtTranslation;
                        text: translation
                        color: "#999999";
                        font.pixelSize: 10
                        anchors.left: txtDetailed.right;
                        anchors.leftMargin: 5;
                        anchors.verticalCenter: parent.verticalCenter;
                    }

                    TextEdit {
                        id: txtEditEditable;
                        anchors.right: imgClose.left;
                        width: 100;
                        text: translation;
                        readOnly: false;
                        focus: true;
                        anchors.verticalCenter: parent.verticalCenter
                        color: "white";

                        MouseArea {
                            id: maEditEditable;
                            anchors.fill: parent;
                            hoverEnabled: true;
                            propagateComposedEvents: true
                            onClicked: {
                                mouse.accepted = false
                                txtEditEditable.focus = true
                            }
                        }
                    }

                    Image {
                        id: imgClose
                        visible: false;
                        enabled: false;
                        z: -100;
                        source: imgCloseMA.containsMouse ? "qrc:/images/Icons-filled/closeHovered.png" :
                                                           "qrc:/images/Icons-filled/close.png";
                        opacity: (mouseArea.containsMouse || imgCloseMA.containsMouse) ? 1 : 0;
                        height: 8;
                        scale: (imgCloseMA.containsMouse) ? 1.3 : 1.0;
                        anchors.right: parent.right;
                        anchors.rightMargin: 25;
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter;

                        MouseArea {
                            id: imgCloseMA;
                            anchors.fill: parent;
                            hoverEnabled: true;
                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                            }
                        }

                        Behavior on scale {
                            NumberAnimation { easing.type: Easing.OutSine; duration: 400 }
                        }
                    }
                }

                DetailedSection {
                    id: detailedSection;
                    height: isOpen ? 200 : 0;
                    opacity: isOpen ? 1 : 0;
                    width: isOpen ? parent.width : parent.width;
                    color: isOpen ? "white" : "#253646";
                    clip: true;
                    Behavior on height {
                        NumberAnimation { easing.type: Easing.OutSine; duration: 400 }
                    }
                    Behavior on width {
                        NumberAnimation { easing.type: Easing.OutSine; duration: 400 }
                    }

                    Behavior on opacity {
                        NumberAnimation { easing.type: Easing.OutSine; duration: 400 }
                    }
                    Behavior on color {
                        ColorAnimation {
                            duration: 350
                            easing.type: Easing.OutCubic;
                        }
                    }
                }



                Text {
                    id: txtIndex
                    text: index < 9 ? (index + 1) : "9";
                    visible: index < 9;
//                    font.bold: isOpen;
                    anchors.left: parent.left;
                    anchors.leftMargin: 5;
                    font.pixelSize: isOpen ? 12 : 8
                    color: isOpen ? "black" : "#7f7f7f";
                    anchors.top: parent.top;
                    anchors.topMargin: 12;

                    Behavior on font.pixelSize {
                        NumberAnimation { easing.type: Easing.OutSine; duration: 400 }
                    }
                    Behavior on color {

                        ColorAnimation {
                            easing.type: Easing.OutCubic;
                            duration: 350
                        }
                    }
                }

                Image {
                    id: imgIcon
                    height: isOpen ? 17 : 14;
                    anchors.left: txtIndex.right;
                    anchors.leftMargin: isOpen ? 5 : 5;
                    fillMode: Image.PreserveAspectFit
                    source: completed ? (isOpen ? "qrc:/images/32X32/Completed2.png" : "qrc:/images/32X32/Completed.png") :
                                     (isOpen ? "qrc:/images/32X32/inCompleted2.png" : "qrc:/images/32X32/inCompleted.png");

                    anchors.top: parent.top;
                    anchors.topMargin: 10;

                    Behavior on height {
                        NumberAnimation { easing.type: Easing.OutSine; duration: 400 }
                    }
                    Behavior on anchors.leftMargin {
                        NumberAnimation { easing.type: Easing.OutSine; duration: 400 }
                    }
                }

                MouseArea {
                    id: mouseArea;
//                    enabled: !isOpen;
                    anchors.fill: parent;
                    anchors.bottomMargin: isOpen ? parent.height - 36 : 0;
                    hoverEnabled: true;
                    cursorShape: isOpen ? Qt.ArrowCursor : Qt.PointingHandCursor;

//                    onClicked: {
//                        listView.currentIndex = index;
//                    }

                    onClicked: {
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
            english: "this is english";
            translation: "this is translated text!!!!";
            comment: "this is english";
            completed: false;
        }
        ListElement {
            name: "Project 1"
            detailText: "Desktop application project"
            isOpen: false;
            english: "this is english";
            translation: "this is translated text!!!!";
            comment: "this is english";
            completed: false;
        }
        ListElement {
            name: "Project 1"
            detailText: "Desktop application project"
            isOpen: false;
            english: "this is english";
            translation: "this is translated text!!!!";
            comment: "this is english";
            completed: false;
        }
        ListElement {
            name: "Project 1"
            detailText: "Desktop application project"
            isOpen: false;
            english: "this is english";
            translation: "this is translated text!!!!";
            comment: "this is english";
            completed: false;
        }
    }

}
