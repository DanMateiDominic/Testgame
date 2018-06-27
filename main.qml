import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import Box2DStatic 2.0
import QtQuick.Particles 2.0
import QtQuick.Window 2.1

import "./views"

Window {
    id: rootWindow

    visible: true
    width: 320
    height: 568
    title: qsTr("Test Game")

    property bool isiPhoneX: Qt.platform.os == "ios" && rootWindow.height == 812

//    onIsiPhoneXChanged: {
//        console.log("iPhone X: " + isiPhoneX)
//    }

//    Component.onCompleted: {
//        console.log(Qt.platform.os)
//        console.log(rootWindow.height)
//        console.log(isiPhoneX)
//    }

    flags: Qt.platform.os == "ios" ? Qt.MaximizeUsingFullscreenGeometryHint : Qt.Window

    Item {
        id: container
        anchors.fill: parent

        Image {
            anchors.fill: parent
            source: "qrc:/assets/galaxy.jpg"
            fillMode: Image.PreserveAspectCrop

            ParticleSystem {
                anchors.fill: parent
                ImageParticle {
                    source: "qrc:/assets/star.png"
                    rotationVariation: 270
                }

                Emitter {
                    id: starEmitter
                    emitRate: 50
                    lifeSpan: 5000
                    size: 20
                    sizeVariation: 10
                    anchors.fill: parent
                }

                Turbulence {
                    anchors.fill: parent
                    strength: 5
                }
            }
        }

        StackView {
            id: gameStack
            anchors.fill: parent

            anchors.topMargin: isiPhoneX ? 44 : 0
            anchors.bottomMargin: isiPhoneX ? 34 : 0

            initialItem: gameMenu

            delegate: StackViewDelegate {
                function transitionFinished(properties) {
                    properties.exitItem.opacity = 1
                }

                pushTransition: StackViewTransition {
                    PropertyAnimation {
                        target: enterItem
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                    PropertyAnimation {
                        target: enterItem
                        property: "scale"
                        from: 0
                        to: 1
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                    PropertyAnimation {
                        target: exitItem
                        property: "opacity"
                        from: 1
                        to: 0
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                    PropertyAnimation {
                        target: exitItem
                        property: "scale"
                        from: 1
                        to: 0
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

        Component {
            id: chooseLevelComponent
            ChooseLevelView
            {
                onClosePressed: {
                    gameStack.pop()
                }
                onLevelSelected: {
                    gameStack.push(theGameComponent, {levelNumber: level})
                }

                width: container.width
                height: container.height
            }
        }

        Component {
            id: gameMenu
            GameMenu {
                width: container.width
                height: container.height
                onPlayPressed: {
                    gameStack.push(chooseLevelComponent)
                }
                onInfinitePressed: {
                    gameStack.push(theGameComponent, {infiniteMode: true})
                }
                onLeaderboardPressed: {
                    gameStack.push(leaderboardComponent)
                }
            }
        }

        Component {
            id: theGameComponent
            TheGame
            {
                width: container.width
                height: container.height

                property bool gameLostCalled: false

                onCloseGame: {
                    gameStack.pop()
                }
                onGameWon: {
                    gameStack.replace(gameWonComponent, {levelNumber: currentLevel + 1})
                }
                onGameLost: {
                    if (!gameLostCalled)
                        gameLostCalled = true
                    else
                        return

                    gameStack.push(gameLostComponent)
                }
            }
        }

        Component {
            id: gameWonComponent
            GameWonView
            {
                width: container.width
                height: container.height
            }
        }

        Component {
            id: gameLostComponent
            GameLostView
            {
                width: container.width
                height: container.height

                onGoToMenu: {
                    gameStack.pop(null)
                }
                onPlayAgain: {
                    gameStack.pop(null)
                    Qt.callLater(function(){
                        gameStack.push(theGameComponent, {infiniteMode: true})
                    })
                }
            }
        }

        Component {
            id: leaderboardComponent
            LeaderboardView {

            }
        }
    }
}
