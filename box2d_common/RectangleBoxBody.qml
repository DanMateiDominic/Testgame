import QtQuick 2.0
import Box2DStatic 2.0;

Rectangle {
    id: rectangle

    property alias body: boxBody
    property alias fixture: box

    signal beginContact(Fixture other)
    signal endContact(Fixture other)

    // Body properties
    property alias world: boxBody.world
    property alias linearDamping: boxBody.linearDamping
    property alias angularDamping: boxBody.angularDamping
    property alias bodyType: boxBody.bodyType
    property alias bullet: boxBody.bullet
    property alias sleepingAllowed: boxBody.sleepingAllowed
    property alias fixedRotation: boxBody.fixedRotation
    property alias active: boxBody.active
    property alias awake: boxBody.awake
    property alias linearVelocity: boxBody.linearVelocity
    property alias angularVelocity: boxBody.angularVelocity
    property alias fixtures: boxBody.fixtures
    property alias gravityScale: boxBody.gravityScale

    // Box properties
    property alias density: box.density
    property alias friction: box.friction
    property alias restitution: box.restitution
    property alias sensor: box.sensor
    property alias categories: box.categories
    property alias collidesWith: box.collidesWith
    property alias groupIndex: box.groupIndex

    Body {
        id: boxBody

        target: rectangle

        Box {
            id: box

            onBeginContact: rectangle.beginContact(other)
            onEndContact: rectangle.endContact(other)

            width: rectangle.width
            height: rectangle.height
        }
    }
}
