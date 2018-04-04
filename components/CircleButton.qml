import QtQuick 2.0

Rectangle{

    property string symbol
    width: 35
    height: width
    radius: width / 2
    color: "black"
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.margins: 5

    Text{
        text: symbol
        color: "white"
        anchors.centerIn: parent
        font.pixelSize: 24
    }
}
