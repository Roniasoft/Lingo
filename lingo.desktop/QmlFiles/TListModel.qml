import QtQuick 2.0

ListModel {
    id: listModel;
        ListElement {
        name: "Project"
        isOpen: false;
        english: "this is english";
        translation: "this is translated text!!!!";
        comment: "this is english";
        completed: false;
        highlighted: false;
    }
}
