import QtQuick 2.0
import Box2DStatic 2.0;
import QtMultimedia 5.9

import "../box2d_common"

RectangleBoxBody {
    id: breakableRect
    property int size: 40
    property int durability
    property var brokenCallback
    property var contactCallback

    width: size
    height: size

    color: "#222222"
    categories: Box.Category3
    visible: durability > 0
    active: visible
    world: physicsWorld
    border.color: "darkGray"

    Text{
        text:durability
        color:'white'
        anchors.centerIn: parent
    }

    onBeginContact: {
        contactCallback()
        durability--
        if (durability == 0) {
            brokenCallback()
            breakableRect.body.target.destroy();
        }
    }
}
