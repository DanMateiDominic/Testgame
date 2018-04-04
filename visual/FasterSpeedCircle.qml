import QtQuick 2.0

Rectangle{
    id: fasterSpeedCircle
    width:height

    signal pressed
    signal released
    property string symbol

    color: "transparent"

    Rectangle {
        anchors.fill: parent
        scale: 0.8
        radius: width / 2
        border.color: "darkGray"
        border.width: 2
        color: "transparent"

        Text {
            text: symbol
            anchors.centerIn: parent
            font.pixelSize: 14
            font.bold: true
            color: "darkGray"
        }
    }
    MouseArea {
        anchors.fill: parent
        onPressed: {
            fasterSpeedCircle.pressed()
        }
        onReleased: {
            fasterSpeedCircle.released()
        }
    }
}
