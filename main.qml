import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import "Icons.js" as MdiFont


ApplicationWindow
{
    id: window
    width: 400
    height: 500
    visible: true
    //    x: Screen.width / 2 - width / 2
    //    y: Screen.height / 2 - height / 2
    title: "medOS"

    property string userTxt
    property var userInfo

    header: ToolBar
    {
        id: headerBar
        visible: false

        Rectangle
        {
            anchors.fill: parent
            color: "#31363b"
        }

        RowLayout
        {
            anchors.fill: parent
            ToolButton
            {
                Icon
                {
                    text: MdiFont.Icon.menu
                    color: "white"
                }

                ToolTip { text: "Menu" }

                onClicked: drawer.open()
            }


            Row
            {
                anchors.centerIn: parent

                ToolButton
                {
                    id: newsViewBtn
                    Icon
                    {
                        id:newsIcon
                        text: MdiFont.Icon.newspaper
                        color: swipeView.currentIndex === 1? "#ff8080" : "white"
                    }

                    onClicked:
                    {
                        swipeView.currentIndex = 1

                        console.log("newsviewbtn clicked")
                    }


                    hoverEnabled: true

                    ToolTip.delay: 1000
                    ToolTip.timeout: 5000
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("News")
                }



                ToolButton
                {
                    id:peopleViewBtn
                    Icon
                    {
                        id: peopleIcon
                        text: MdiFont.Icon.face
                        color: swipeView.currentIndex === 2? "#ff8080" : "white"
                    }

                    onClicked:
                    {
                        swipeView.currentIndex = 2

                        console.log("peopleviewbtn clicked")
                    }


                    hoverEnabled: true

                    ToolTip.delay: 1000
                    ToolTip.timeout: 5000
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("People")
                }

                ToolButton
                {
                    id:messagesViewBtn

                    Icon
                    {
                        id: messagesIcon
                        text: MdiFont.Icon.commentText
                        color: swipeView.currentIndex === 3? "#ff8080" : "white"
                    }

                    onClicked:
                    {
                        swipeView.currentIndex = 3

                        console.log("messagesviewbtn clicked")
                    }

                    hoverEnabled: true

                    ToolTip.delay: 1000
                    ToolTip.timeout: 5000
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Messages")
                }

            }

        }

    }


    SwipeView
    {
        id: swipeView
        currentIndex: 0
        anchors.fill: parent
        interactive: false


        StackView
        {
            id:mainView

            initialItem:  Socket
            {
                id: socketView
                onConnected:
                {
                    socket.sendTextMessage("Connected from Android");
                    headerBar.visible= true

                    mainView.push(arduinoView)
                    swipeView.interactive = true
                }

                onMessaged:
                {
                    if(msg.startsWith("DISTANCE#"))
                        valuesView.distanceValue = msg.replace("DISTANCE#","");

                    if(msg.startsWith("LUMINOSITY#"))
                        valuesView.luminosityValue = msg.replace("LUMINOSITY#","");

                }
            }

            Arduino
            {
                id: arduinoView

                onProps:
                {
                    socketView.socket.sendTextMessage(props)
                }

            }

        }

        Values
        {
            id: valuesView
            width: swipeView.width
            height: swipeView.height

            luminosityValue: "0"
            distanceValue: "0"
        }

        Pane
        {
            width: swipeView.width
            height: swipeView.height

            Column {
                spacing: 40
                width: parent.width

                Label {
                    width: parent.width
                    wrapMode: Label.Wrap
                    horizontalAlignment: Qt.AlignHCenter
                    text: "People view"
                }

            }

        }

        Pane
        {
            width: swipeView.width
            height: swipeView.height

            Column {
                spacing: 40
                width: parent.width

                Label {
                    width: parent.width
                    wrapMode: Label.Wrap
                    horizontalAlignment: Qt.AlignHCenter
                    text: "Messages view"
                }

            }

        }


    }
}


