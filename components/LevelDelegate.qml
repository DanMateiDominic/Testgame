import QtQuick 2.0

Rectangle {
    id: levelDelegate

    signal levelPressed
    property int levelNumber
    border.color: 'darkCyan'

    radius: 10

    color: levelMouseArea.pressed ? Qt.rgba(0, 1, 0, 0.5) : Qt.rgba(0, 1, 1, 0.5)

    Text {
        anchors.centerIn: parent
        text: levelDelegate.levelNumber
        font.pixelSize: 20
    }
    Text {
        text:"Level"
        font.pixelSize:25
        anchors.horizontalCenter: parent.horizontalCenter
        y: 5
    }
    MouseArea {
        id: levelMouseArea
        anchors.fill:parent
        onClicked: {
            levelDelegate.levelPressed()
        }
    }
}
