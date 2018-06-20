import QtQuick 2.7
import Box2DStatic 2.0
import LevelLoader 1.0
import QtGraphicalEffects 1.0
import QtMultimedia 5.9


import "../components"
import "../box2d_common"
import "../powerups"
import "../visual"
import "../functions"

Rectangle {
    id: theGame

    signal closeGame
    signal gameWon(int currentLevel)
    signal gameLost()

    // external properties
    property int levelNumber: -1
    property bool infiniteMode: false

    // internal properties
    property int impulse: 25
    property int ballsCount: 1
    property int extraBalls: 0
    property int launchedBalls: 0
    property int destroyedBalls: 0
    property int spawningDelay: 100
    property int worldSpeed: 1
    property int rectanglesLeft: 0
    property int elapsedTime
    property double angle
    property double angleRad
    property var levelMap
    property bool tiltedWalls: false
    property bool gameStopped: (launchedBalls == destroyedBalls)

    property int spawnedRectanglesCount: 0
    property int spawnedLinesCount: 1
    property var spawnedRectanglesList: []

    color: 'transparent'

    onDestroyedBallsChanged: {
        if (destroyedBalls == launchedBalls) {
            ballsCount += extraBalls
            extraBalls = 0

            if (infiniteMode) {
                shiftRectanglesDown()
                spawnRandomLine()
                theGameFunctions.spawnRectangles()
                spawnedLinesCount++
            }

            theGameFunctions.hideSplittingPowerup()
        }
    }

    onRectanglesLeftChanged: {
        //        if (rectanglesLeft == 0)
        //            gameWon(levelNumber)
    }

    onAngleChanged: {
        if(angle >80 && angle < 180)
            angle = 80
        if(angle < 270 && angle > 180 ||
                angle < -80 && angle > -90)
            angle = -80
        angleRad = (angle - 90) * Math.PI / 180
    }

    World {
        id: physicsWorld
        timeStep: worldSpeed / 50
    }

    Wall {
        id: ceiling
        height: 20
        anchors { left: parent.left; right: parent.right; bottom: levelContainer.bottom }
    }
    Wall {
        id: ground
        height: 20
        anchors { left: parent.left; right: parent.right; top: parent.bottom; topMargin: -40 }
        onBeginContact: {
            destroyedBalls++
            other.getBody().target.destroy();
        }
    }
    Wall {
        id: leftWall
        width: 20
        anchors { right: parent.left; bottom: ground.top; top: ceiling.bottom }
        rotation: tiltedWalls ? 2 : 0
    }
    Wall {
        id: rightWall
        width: 20
        anchors { left: parent.right; bottom: ground.top; top: ceiling.bottom }
        rotation: tiltedWalls ? -2 : 0
    }

    ShootingPath {
        id: shootingPathColumn

        height: theGame.height
        anchors.bottom:startingCircle.verticalCenter
        anchors.horizontalCenter: startingCircle.horizontalCenter
        visible: gameMouseArea.pressed && (gameStopped)
    }

    Item {
        id:levelContainer

        width: parent.width

        Item {
            id: drawableArea
            width: parent.width
            height: Math.min(100, parent.height)
            Text {
                text: {
                    if (infiniteMode)
                        return "Line " + spawnedLinesCount
                    else
                        return "Level " + levelNumber
                }
                color: "darkGray"
                anchors.centerIn: parent
                font.pixelSize: 24
            }
        }

        anchors.top: parent.top
        anchors.bottom: playableArea.top
    }

    Rectangle {
        id: playableArea

        height: width * 1.23
        width: parent.width

        visible: false

        anchors.bottom: startingLine.top
    }

    Rectangle {
        id:startingLine

        width:parent.width
        height:2
        color:"darkGray"
        anchors.bottomMargin:40
        anchors.bottom:parent.bottom

    }

    Image {
        id: astronautImage
        source: "qrc:/assets/astronaut.png"

        anchors.left: startingCircle.right
        height: 120
        width: 60
        fillMode: Image.PreserveAspectFit
        anchors.bottom: startingLine.bottom
        anchors.bottomMargin: -4
        z: 2

        mipmap: true

        verticalAlignment: Image.AlignBottom
    }

    PlayerCircle{
        id: startingCircle

        z: 2

        anchors.bottom:startingLine.top
        anchors.horizontalCenter: startingLine.horizontalCenter
        Text{
            text:ballsCount
            anchors.centerIn: parent
            color:"darkGray"
        }

        border.color: "darkGray"
    }

    MouseArea {
        id:gameMouseArea

        enabled: gameStopped
        anchors.fill: parent
        onPositionChanged: {
            var diffX = (mouse.x - (startingCircle.x + startingCircle.width / 2));
            var diffY = (mouse.y - (startingCircle.y + startingCircle.height / 2));
            var rad = Math.atan2(diffY, diffX);
            var degrees = (rad * 180 / Math.PI);
            angle = degrees + 90;
        }
        onPressed: {
            var diffX = (mouse.x - (startingCircle.x + startingCircle.width / 2));
            var diffY = (mouse.y - (startingCircle.y + startingCircle.height / 2));
            var rad = Math.atan2(diffY, diffX);
            var degrees = (rad * 180 / Math.PI);
            angle = degrees + 90;
        }

        onClicked: {
                launchedBalls = ballsCount
                destroyedBalls = 0
                spawningTimer.start()
                stopSpawning.start()

        }
    }

    Text {
        id: elapsedTimeCounter

        anchors.top: startingLine.bottom
        anchors.bottom:parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 5

        visible: !infiniteMode

        property double startTime

        text: elapsedTime + " s"
        verticalAlignment: Text.AlignVCenter
        font.bold: true

        Component.onCompleted: {
            startTime = new Date().getTime()
        }

        Timer {
            interval: 100
            running: true
            repeat: true

            onTriggered: {
                elapsedTime = Math.floor((new Date().getTime() - elapsedTimeCounter.startTime) / 1000)
            }
        }
    }

    FasterSpeedCircle {
        anchors.top: startingLine.bottom
        anchors.bottom:parent.bottom
        anchors.right: parent.right

        symbol: ">>"

        onPressed: {
            theGame.worldSpeed++
        }
        onReleased: {
            theGame.worldSpeed--
        }
    }

    FasterSpeedCircle {
        anchors.top: startingLine.bottom
        anchors.bottom:parent.bottom
        anchors.left: parent.left

        symbol: "/\\"

        onPressed: {
            tiltedWalls = true
        }
        onReleased: {
            tiltedWalls = false
        }
    }

    Timer {
        id: spawningTimer
        interval: spawningDelay

        repeat: true
        triggeredOnStart: true

        onTriggered: {
            spawnBall()
        }
    }

    Timer {
        id: stopSpawning
        interval: spawningTimer.interval * (ballsCount - 1)

        onTriggered: {
            spawningTimer.stop()
        }
    }

    function spawnBall() {
        spawnSound.play()
        var angle = theGame.angleRad;
        var newBall = bullet.createObject(theGame);
        newBall.x = startingCircle.x;
        newBall.y = startingCircle.y;
        var impulseX = impulse * Math.cos(angle);
        var impulseY = impulse * Math.sin(angle);

        newBall.body.applyLinearImpulse(Qt.point(impulseX, impulseY), newBall.body.getWorldCenter());
    }

    Component {
        id: bullet
        MovingCircle {

        }
    }

    Component {
        id: extraBallPowerup
        ExtraBallPowerup {

        }
    }

    Component {
        id: splittingPowerup
        SplittingPowerup {

        }
    }

    Component {
        id: breakableRectangle
        BreakableRectangle {

        }
    }

    CircleButton {
        symbol: "←"

        MouseArea{
            anchors.fill:parent
            onClicked: {
                closeGame()
            }
        }
    }
    LevelLoader {
        id: levelLoader
        level: levelNumber

        onError: {
            console.log("levelLoader: " + error)
        }
    }
    Component.onCompleted: {
        if (infiniteMode) {
            spawnRandomLine()
            theGameFunctions.spawnRectangles()
        }
        else {
            createMap()
            theGameFunctions.spawnRectangles()
        }
    }

    function shiftRectanglesDown() {
        var rectangleSize = theGame.width / levelMap[0].length

        for (var i = 0; i < spawnedRectanglesList.length; i++) {
            spawnedRectanglesList[i].y += rectangleSize
            if (Math.floor(spawnedRectanglesList[i].y) >= Math.floor(levelContainer.height + (9 * rectangleSize))) {
                if (spawnedRectanglesList[i].objectName !== "powerup")
                    gameLost()
                else {
                    spawnedRectanglesList[i].visible = false
                }
            }
        }
    }

    function spawnRandomLine() {
        levelMap = []
        var levelLine = []

        var maxDurability = 10
        var increaseDifficultyAfterLines = 4

        for (var i = 0; i < 8; i++) {
            var randomNumber = Math.floor(Math.random() * maxDurability) - maxDurability * 0.4
            var finalMapElement

            if (randomNumber < -(maxDurability * 0.3))
                finalMapElement = "b"
            else if (randomNumber <= 0)
                finalMapElement = 0
            else
                finalMapElement = randomNumber + Math.floor(spawnedLinesCount / increaseDifficultyAfterLines)

            levelLine[i] = finalMapElement
        }
        levelMap[0] = levelLine
    }

    function createMap() {
        var map = levelLoader.loadMap()
        var blockLines = map.trim().split("\n");
        var i;
        for (i = 0; i < blockLines.length; i++)
        {
            blockLines[i] = blockLines[i].trim().split(" ");
        }
        theGame.levelMap = blockLines
    }

    Functions {
        id: theGameFunctions
    }

    SoundEffect {
        id: spawnSound
        source: "qrc:/assets/sfx/spawn.wav"
    }
}
