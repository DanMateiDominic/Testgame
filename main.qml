import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Box2DStatic 2.0;

import "./views"

ApplicationWindow {
    visible: true
    width: 320
    height: 568
    title: qsTr("Test Game")

    Item {
        id: container
        anchors.fill: parent

        StackView {
            id: gameStack
            width: parent.width
            height: parent.height
            initialItem: gameMenu
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
                onSettingsPressed: {

                }
                onHelpPressed: {

                }
                onInfinitePressed: {
                    gameStack.push(theGameComponent, {infiniteMode: true})
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
    }
}
