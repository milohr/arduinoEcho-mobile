import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.1


Pane
{
    property alias socket : socket

    id: pane
    signal connected ()
    signal messaged(var msg)
    signal disconnected()
    signal error(var msg)

    property string message
    Rectangle
    {
        anchors.centerIn: parent
        width: parent.width/2
        Column
        {
            anchors.centerIn: parent
            width:parent.width
            id: fields
            spacing: 30

            WebSocket
            {
                id: socket
                onTextMessageReceived: { messaged(message) }

                onStatusChanged:
                {
                    if (socket.status == WebSocket.Error)
                        error(errorString)

                    else if (socket.status == WebSocket.Open)
                        connected()

                    else if (socket.status == WebSocket.Closed)
                        disconnected()
                }

                active: false
            }

            TextField
            {
                id: ipAddress
                width: parent.width
                text: "ws://localhost:1234"
            }

            Button
            {
                id: connectBtn

                property bool connected_socket: false

                text: "Connect"
                width: parent.width

                onClicked:
                {
                    socket.url = ipAddress.text
                    socket.active = !socket.active
                    //                    connected()
                }
            }
        }
    }
}
