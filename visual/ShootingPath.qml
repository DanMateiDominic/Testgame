import QtQuick 2.0

Column {
    id: shootingPathColumn
    width: 5

    clip: true

    transform: Rotation { origin.x: shootingPathColumn.width / 2; origin.y: shootingPathColumn.height; angle: theGame.angle}

    Repeater {
        model: 20
        Item {
            height: 40
            width: shootingPathColumn.width
            Rectangle {
                id: blackDot
                height: 20
                width: parent.width
                color:"black"
            }
            Rectangle {
                id: whiteDot

                anchors.bottom:blackDot.top

                height: 20
                width: shootingPathColumn.width
                color:"transparent"
            }
        }
    }
}
