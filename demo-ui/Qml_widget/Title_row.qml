import QtQuick 2.7

Rectangle{
    id: title_root
    height: 90
    width: 720
    property real  font_size: 35
    property alias text: title_text.text
    property alias image_source: back_icon.source
    property color text_color: "white"
    border.width: 6
    border.color: "#050505"
    color: "#050505"

    signal back();

    onFocusChanged: {
        if(title_root.focus){
            title_root.border.color = "#A9FF41";

        }
        else{
            title_root.border.color = "#050505";
        }
    }

    Image {
        id: back_icon
        width: 40
        height: 45
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        source: ""
    }

    Text {
        id: title_text
        height: title_root.height
        width: title_root.width
        text: "-----"
        font.pixelSize: font_size
        color: text_color
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Rectangle{
        id: line
        width: parent.width
        height: 2
        color: text_color
        anchors.bottom: parent.bottom
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            back();   //触发返回的信号
        }
    }
}
