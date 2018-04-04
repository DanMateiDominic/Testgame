import QtQuick 2.0
import Box2DStatic 2.0;
import "../box2d_common"

ItemCircleBody {
    id: woodenBox

    size: 25

    bodyType: Body.Dynamic
    world: physicsWorld
    color: "#222222"
    border.color: "darkGray"

    categories: Box.Category1
    collidesWith: Box.Category2 | Box.Category3

    gravityScale: 0
    restitution: 1
    bullet: true
    friction: 0
}
