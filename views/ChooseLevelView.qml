import QtQuick 2.0

import "../components"

Rectangle {
    id: chooseLevelView

    color: 'lightGray'

    signal closePressed()
    signal levelSelected(int level)

    Flickable {
        anchors.fill: parent
        contentWidth: levelGrid.width
        contentHeight: levelGrid.height

        rotation: 180
        Grid {
            id: levelGrid
            columns: 2

            spacing: 5

            Repeater {
                model: 10
                LevelDelegate {
                    width: chooseLevelView.width / 2 - (levelGrid.spacing) / 2
                    height: width

                    levelNumber: index + 1

                    rotation: 180
                    onLevelPressed: {
                        levelSelected(index + 1)
                    }
                }
            }
        }
    }
    CircleButton {
        symbol: "←"
        MouseArea{
            anchors.fill:parent
            onClicked: closePressed()
        }
    }
}
