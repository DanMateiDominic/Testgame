import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import "../components"

Rectangle {
    id: background

    signal playPressed
    signal infinitePressed
    signal leaderboardPressed

    focus: true

    color: 'transparent'
    Keys.onSpacePressed: background.color = Qt.rgba(Math.random(),Math.random(),Math.random(),1)

    Text {
        y: 20
        text:"Bricks"
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 35
        color:"#222222"
        style: Text.Outline
        styleColor: "darkGray"
    }

    Column {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 20
        spacing: 10
//        MateiButton {
//            buttonText: 'Play'
//            canBeClicked: true
//            onButtonClicked: {
//                playPressed()
//            }
//        }
        MateiButton {
            buttonText: 'Play'
            canBeClicked: true
            onButtonClicked: {
                infinitePressed()
            }
        }
        MateiButton {
            buttonText: 'Leaderboard'
            canBeClicked: true
            onButtonClicked: {
                leaderboardPressed()
            }
        }
    }
}
