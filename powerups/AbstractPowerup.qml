import QtQuick 2.0
import Box2DStatic 2.0;
import "../box2d_common"

ItemCircleBody {
    id: powerupRoot

    objectName: "powerup"

    property var symbol
    property var powerUpFunction
    property bool customDestroyer: false
    size: 10
    color: "#222222"
    border.color: "darkGray"
    border.width: 1

    sensor: true
    categories: Box.Category2

    Text {
        id: symbolText
        text:symbol
        width: 10
        height: width
        anchors.centerIn: parent
        font.bold:true
        font.family: "Monospace"
        color: "darkGray"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    onBeginContact: {
        if (powerupRoot.visible) {
            powerUpFunction(other)
            if (!customDestroyer)
                powerupRoot.visible = false
        }
    }
}

