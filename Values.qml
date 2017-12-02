import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.1

import "socket.js" as Network

Pane
{
    id: pane
    property string distanceValue
    property string luminosityValue

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

            Frame
            {

                width: parent.width
                Label
                {
                    id: distance
                    anchors.fill: parent;

                    text: distanceValue
                    visible:false
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter

                    onTextChanged: visible = true

                }
            }

            Frame
            {
                width: parent.width
                Label
                {
                    id: luminosity
                    anchors.fill: parent;
                    text:luminosityValue
                    visible:false
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter

                    onTextChanged: visible = true


                }
            }

        }
    }

}
