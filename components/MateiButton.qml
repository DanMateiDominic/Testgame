import QtQuick 2.0

Rectangle {
    id: mateiButton
    property string buttonText
    property bool canBeClicked: true
    signal buttonClicked

    width: 100
    height: 50

    color: tapZone.pressed ? 'red' : 'white'
    radius: 10

    Text {
        text: mateiButton.buttonText
        anchors.centerIn: parent
        font.bold: true
        font.pixelSize: 14
        color: canBeClicked ? 'black' : 'gray'
    }

    MouseArea {
        id: tapZone
        anchors.fill: parent
        enabled: canBeClicked
        onClicked: {
            buttonClicked()
        }
    }
}
