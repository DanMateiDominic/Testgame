import QtQuick 2.0
import QtMultimedia 5.9

Item {
    property var splittingPowerupRef
    property bool splittingPowerupTriggered: false

    function hideSplittingPowerup() {
        if (splittingPowerupTriggered)
            splittingPowerupRef.visible = false
    }

    function spawnRectangles() {
        var rectangleSize = theGame.width / levelMap[0].length
        for (var i = 0; i < levelMap.length; i++) {
            for (var j = 0; j < levelMap[i].length; j++) {
                if (levelMap[i][j] > 0) {
                    var newRectangle = breakableRectangle.createObject(theGame)
                    newRectangle.x = rectangleSize * j + 3
                    newRectangle.y = rectangleSize * i + levelContainer.height
                    newRectangle.size = rectangleSize - 6
                    newRectangle.durability = levelMap[i][j]
                    newRectangle.brokenCallback = function() {
                        rectanglesLeft--
                    }
                    newRectangle.contactCallback = function() {
                        hitSound.play()
                    }
                    spawnedRectanglesList[spawnedRectanglesCount] = newRectangle
                    spawnedRectanglesCount++
                    rectanglesLeft++
                }
                else {
                    if (levelMap[i][j] === 'b') {
                        var newExtraBallPowerup = extraBallPowerup.createObject(theGame)
                        newExtraBallPowerup.size = 20
                        newExtraBallPowerup.x = rectangleSize * j + rectangleSize / 2 - newExtraBallPowerup.size / 2
                        newExtraBallPowerup.y = rectangleSize * i + rectangleSize / 2 - newExtraBallPowerup.size / 2 + levelContainer.height
                        newExtraBallPowerup.powerUpFunction = function(collidedSphere) {
                            powerupSound.play()
                            extraBalls++
                        }
                        spawnedRectanglesList[spawnedRectanglesCount] = newExtraBallPowerup
                        spawnedRectanglesCount++
                    }
                    if (levelMap[i][j] === 's') {
                        var newSplittingPowerup = splittingPowerup.createObject(theGame)
                        newSplittingPowerup.size = 20
                        newSplittingPowerup.x = rectangleSize * j + rectangleSize / 2 - newSplittingPowerup.size / 2
                        newSplittingPowerup.y = rectangleSize * i + rectangleSize / 2 - newSplittingPowerup.size / 2 + levelContainer.height
                        newSplittingPowerup.customDestroyer = true
                        splittingPowerupRef = newSplittingPowerup
                        newSplittingPowerup.powerUpFunction = function(collidedSphere) {
                            collidedSphere.getBody().applyLinearImpulse(Qt.point(Math.random() * 80 - 40, 0), collidedSphere.getBody().getWorldCenter());
                            splittingPowerupTriggered = true
                        }
                        spawnedRectanglesList[spawnedRectanglesCount] = newSplittingPowerup
                        spawnedRectanglesCount++
                    }
                }
            }
        }
    }

    SoundEffect {
        id: powerupSound
        source: "qrc:/assets/sfx/powerup.wav"
    }

    SoundEffect {
        id: hitSound
        source: "qrc:/assets/sfx/hit.wav"
    }
}
