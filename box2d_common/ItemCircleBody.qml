import QtQuick 2.0
import Box2DStatic 2.0;

Rectangle {
    id: circleItem

    property int size

    width: size
    height: width
    radius: height / 2

    property Body body: boxBody
    property alias fixture: circle

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

    // Circle properties
    property alias density: circle.density
    property alias friction: circle.friction
    property alias restitution: circle.restitution
    property alias sensor: circle.sensor
    property alias categories: circle.categories
    property alias collidesWith: circle.collidesWith
    property alias groupIndex: circle.groupIndex

    Body {
        id: boxBody

        target: circleItem

        Circle {
            id: circle

            onBeginContact: circleItem.beginContact(other)
            onEndContact: circleItem.endContact(other)
            radius: circleItem.radius
        }
    }
}
