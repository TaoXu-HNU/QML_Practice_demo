import QtQuick 2.7

Item{
    id: heigh_light_dlg
    width: page_width - 8
    height: page_height/12
    property real left_margin: 20//115
    property real line_width: 600

    property color high_light_color: "#A9FF41" //global_hightlight

    property string heigh_light_type: "line"

    Rectangle{ //高亮为 “box”
        id: box
        visible:heigh_light_type === "box" ? true : false
        anchors.fill: parent
        color: "transparent"
        border.width: 4
        border.color: high_light_color//my_list.focus ? high_light_color : "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle{ //高亮为 “line”
        id: line
        visible: heigh_light_type === "line" ? true : false
        width: line_width
        height: 4//2
        color: high_light_color//my_list.focus ? high_light_color : "grey"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin:left_margin

//        opacity: my_list.focus ? 1 : 0.1
    }
}
