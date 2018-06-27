import QtQuick 2.0

Rectangle {
   id: leaderboardDelegate

   height: 50

   property int playerPlace
   property string playerName
   property int playerTotalScore
   property int playerHighScore

   anchors {
       left: parent.left
       right: parent.right
       margins: 10
   }

   color: "white"

   radius: 10

   Text {
       id: playerNumberText

       anchors {
           top: parent.top
           left: parent.left
           margins: 5
       }

       text: leaderboardDelegate.playerPlace + "."

       font.pixelSize: 14
   }

   Text {
       id: playerNameText

       anchors {
           verticalCenter: parent.verticalCenter
           left: playerNumberText.right
           leftMargin: 5
       }

       text: leaderboardDelegate.playerName
       font.pixelSize: 16
       font.bold: true
   }

   Text {
       id: playerHighScoreText

       anchors {
           verticalCenter: parent.verticalCenter
           right: parent.right
           rightMargin: 12
       }

       text: leaderboardDelegate.playerHighScore
       font.pixelSize: 14
       font.bold: true
   }

   Text {
       id: playerTotalScoreText

       anchors {
           verticalCenter: parent.verticalCenter
           right: playerHighScoreText.left
           rightMargin: 26
       }

       text: leaderboardDelegate.playerTotalScore
       font.pixelSize: 14
       font.bold: true
   }
}
