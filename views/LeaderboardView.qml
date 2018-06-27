import QtQuick 2.9
import QtQuick.Window 2.2

import "../delegates"

Window {
    visible: true
    width: 320
    height: 536
    title: qsTr("Hello World")

    Rectangle {
        id: background

        anchors.fill: parent
        color: "lightGray"

        Text {
            id: title
            anchors.top: parent.top
            anchors.topMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter

            text: "Leaderboard"
            font.bold: true
            font.pixelSize: 30
        }

        Item {
            id: columnNames

            width: parent.width - 30

            anchors.horizontalCenter: parent.horizontalCenter

            height: 40

            anchors {
                top: title.bottom
            }

            Text {
                id: nameColumn

                text: "Name"

                anchors {
                    left: parent.left
                    leftMargin: 15
                    verticalCenter: parent.verticalCenter
                }
            }

            Text {
                id: highScoreColumn

                anchors {
                    right: parent.right
                }
                anchors.verticalCenter: parent.verticalCenter

                horizontalAlignment: Text.AlignHCenter
                text: "High<br>Score"
            }

            Text {
                id: totalScoreColumn

                anchors {
                    right: highScoreColumn.left
                    rightMargin: 10
                }
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter

                text: "Total<br>Score"
            }
        }

        ListModel {
            id: leaderBoardModel
            ListElement {
                playerPlace: 1
                playerName: "Matei"
                playerTotalScore: 99
                playerHighScore: 65
            }
            ListElement {
                playerPlace: 2
                playerName: "Gherghe"
                playerTotalScore: 70
                playerHighScore: 30
            }
        }

        ListView {
            id: leaderList

            anchors {
                top: columnNames.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            model: leaderBoardModel

            spacing: 10

            clip: true

            delegate: LeaderboardDelegate {
                playerName: model.playerName
                playerPlace: model.playerPlace
                playerTotalScore: model.playerTotalScore
                playerHighScore: model.playerHighScore
            }
        }
    }
}
