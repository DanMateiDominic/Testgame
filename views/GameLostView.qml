import QtQuick 2.0
import "../components"

Rectangle{
    signal goToMenu()
    signal playAgain()

    color:"lightgray"
    Text{
        text:"You lost"
        anchors.horizontalCenter: parent.horizontalCenter
        y:20
        font.bold:true
        font.pixelSize: 40
    }
    Column{
        spacing:20
        anchors.centerIn: parent
        MateiButton{
            buttonText: "Play again"
            onButtonClicked: {
                playAgain()
            }
        }
        MateiButton{
            buttonText: "Menu"
            onButtonClicked: {
                goToMenu()
            }
        }
    }
}

