import QtQuick 2.0
import Box2DStatic 2.0;

Item {
    id: wall

    signal beginContact(Fixture other)
    signal endContact(Fixture other)

    BoxBody {
        categories: Box.Category2
        target: wall
        world: physicsWorld

        width: wall.width
        height: wall.height

        onBeginContact: {
            wall.beginContact(other)
            wall.endContact(other)
        }
    }
}
