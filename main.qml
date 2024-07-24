import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts
import QtQuick.Controls
Window {
    id:root
    width: 300
    height: 480
    visible: true

    ColumnLayout{
        anchors.fill: parent

        Rectangle{
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height*0.1
            color:  root.color

            RowLayout{
                anchors.fill: parent
                Text {
                    id: _titleText
                    text: qsTr("Stopwatch")
                    font.pixelSize: parent.width * 0.09
                    font.bold: true
                    color: "white"
                    Layout.alignment: Qt.AlignCenter
                    Layout.leftMargin: parent.width * 0.23
                }

                Rectangle{
                    Layout.preferredWidth: parent.width * 0.1
                    Layout.preferredHeight: parent.height *0.5
                    Layout.alignment: Qt.AlignLeft
                    color: root.color
                    Image {
                        id: _menu
                        anchors.fill: parent
                        source: "qrc:/menu.png"
                        fillMode: Image.PreserveAspectFit
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            drawer.visible = !drawer.visible
                        }
                    }
                }
            }
        }


        Rectangle{
            id:mainCircle
            color: root.color
            Layout.preferredWidth: parent.width * 0.5
            Layout.preferredHeight:parent.width * 0.5
            radius: width
            border.color: "#17B0D6"
            border.width: parent.width * 0.015
            Layout.alignment: Qt.AlignCenter

            Text {
                id: _displayText
                text: "00:00.00"
                font.pixelSize: parent.width * 0.17
                font.bold: true
                anchors.centerIn: parent
                color: "white"
            }
        }

        Rectangle{
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height*0.15
            color: root.color
            RowLayout{
                anchors.fill: parent

                Rectangle{
                    id: _reset
                    Layout.preferredWidth: parent.width *0.15
                    Layout.preferredHeight:parent.height
                    Layout.leftMargin: parent.width * 0.3
                    color: root.color

                    Image {
                        id: _resetImg
                        anchors.fill: parent
                        source : "qrc:/refresh-arrow.png"
                        fillMode: Image.PreserveAspectFit
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            timer.stop()
                            time = 0
                            _startPauseImg.source = "qrc:/play.png"
                            updateDisplay()
                        }
                    }
                }

                Rectangle{
                    id: _startPause
                    Layout.preferredWidth: parent.width *0.15
                    Layout.preferredHeight:parent.height
                    Layout.rightMargin:  parent.width * 0.3
                    color: root.color

                    Image {
                        id: _startPauseImg
                        anchors.fill: parent
                        source : "qrc:/play.png"
                        fillMode: Image.PreserveAspectFit
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            timer.running ? timer.stop() : timer.start()
                            timer.running ? _startPauseImg.source = "qrc:/pause.png":_startPauseImg.source = "qrc:/play.png"
                        }
                    }
                }
            }
        }
    }

    Drawer {
        id: drawer
        width: root.width *0.4
        height: root.height
        visible: false
        edge: Qt.RightEdge

        Rectangle {
            id:_drawerRect
            color: root.color
            anchors.fill: parent
            CheckBox {
                id: darkThemeCheckBox
                text: "Dark"
                checked: false
                indicator.width: parent.width * 0.2
                indicator.height:  parent.width * 0.2
                anchors.top: parent.Top
                anchors.topMargin: parent.height *0.1
                font.pixelSize: parent.width *0.15

                onCheckedChanged: {
                    if(darkThemeCheckBox.checkState){
                        root.color = "#373636"
                        _titleText.color = "white"
                        _displayText.color = "white"
                    }
                    else{
                        root.color = "white"
                        _titleText.color = "black"
                        _displayText.color = "black"
                    }
                }
            }
        }
    }

    Timer {
        id: timer
        interval: 10
        running: false
        repeat: true
        onTriggered: {
            time += 10
            updateDisplay()
        }
    }

    property int time: 0

    function updateDisplay() {
        var minutes = Math.floor(time / 60000)
        var seconds = Math.floor((time % 60000) / 1000)
        var milliseconds = Math.floor((time % 1000) / 10)

        _displayText.text =
                (minutes < 10 ? "0" + minutes : minutes) + ":" +
                (seconds < 10 ? "0" + seconds : seconds) + "." +
                (milliseconds < 10 ? "0" + milliseconds : milliseconds)
    }
    Component.onCompleted: {
        root.color = "white"
        _titleText.color = "black"
        _displayText.color = "black"
    }
}
