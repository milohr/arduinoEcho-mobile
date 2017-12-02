import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.1

import "socket.js" as Network

Pane
{
    id: pane
    signal props(var props)
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

            SpinBox
            {
                id: distance
                Layout.alignment: Qt.AlignRight

                width: parent.width
                editable: true;
                value:100
                from: 5
                to: 150
            }

            SpinBox
            {
                id: luminosity
                Layout.alignment: Qt.AlignRight

                width: parent.width
                editable: true;
                value:300
                from: 80
                to: 1000
            }

            SpinBox
            {
                id: interval
                Layout.alignment: Qt.AlignRight
                width: parent.width
                editable: true;
                value:2500
                from: 500
                to: 10000
            }


            Button
            {
                id: updateBtn

                text: "Update"
                width: parent.width

                onClicked:
                {
                    var msg = "DISTANCE#"+distance.value+","+"LUMINOSITY#"+luminosity.value+","+"INTERVAL#"+interval.value;
                    messageLabel.text = msg
                    props(msg);
                }
            }


            Label
            {

                id: messageLabel
                text:message
                visible:false
                width: parent.width
                horizontalAlignment: Text.AlignHCenter

                onTextChanged: visible = true


            }

        }
    }

    Dialog
    {
        id: singupDialog
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        parent: ApplicationWindow.overlay

        modal: true
        title: "Confirmation"
        standardButtons: Dialog.Yes | Dialog.No

        Column
        {
            spacing: 20
            anchors.fill: parent
            Label
            {
                text: "Join medOS Community\nDo you want to join medOS?"
            }
        }

        onAccepted: console.log("accepted join medos")

    }
}
