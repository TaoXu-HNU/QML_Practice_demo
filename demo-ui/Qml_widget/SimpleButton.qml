import QtQuick 2.2
import QtQml 2.2

Rectangle{
    id:button_container
    width: 50
    height:50

    color: "black"

    property alias  icon      : img.source
    property alias picked_icon: img_pressed.source

    property bool picked: false

    property int icon_width:  50
    property int icon_height: 50

    signal simpleButtonClicked()


    Image{
        id:img
        visible:!picked

        width:  icon_width
        height: icon_height

        anchors.centerIn: parent
        source: "/icons/logo_44x44.png"
        fillMode: Image.PreserveAspectFit
    }

    Image{
        id:img_pressed
        visible:picked

        width:  icon_width
        height: icon_height

        anchors.centerIn: parent
        source: "/icons/logo_44x44.png"
        fillMode: Image.PreserveAspectFit
    }


    MouseArea{
        anchors.fill: parent;

        onClicked: {
            simpleButtonClicked()
        }
    }
}


