import QtQuick 2.5

Rectangle{
    id: btn_root
    height: 50
    width: 100
    color: "#050505"
    border.width: 3
    border.color: "gray"//"#A9FF41"
    radius: 10

    property color press_color: "#00aaaa"  //定义颜色
    property color release_color: "#050505"
    property color on_focus_border_color : "#A9FF41"
    property bool allow_clicked: true

    property real str_horizontalOffset: 0

    property string btn_str: "按钮"
    property int str_size: 28
    property color str_color: "white"
    property bool is_bold: false

    signal btnclicked();

    onFocusChanged: {
        if(btn_root.focus){   //聚焦情况下
            btn_root.border.color = on_focus_border_color;
        } else{
            btn_root.border.color = "gray";
        }
    }

    onAllow_clickedChanged: {
        allow_clicked ? btn_root.border.color = "#A9FF41" : btn_root.border.color = "gray"
        allow_clicked ? str_color = "white" : str_color = "gray"
//        allow_clicked ? btn_root.opacity = 0.5 : btn_root.opacity = 0
    }

    Text {
        id: str
        font.pixelSize: str_size
        font.bold:is_bold
        color: str_color
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: str_horizontalOffset
        text: btn_str
    }
    MouseArea{
        anchors.fill: parent
        onPressed: if( allow_clicked )btn_root.color = press_color
        onReleased: if( allow_clicked )btn_root.color = release_color
        onCanceled: if( allow_clicked )btn_root.color = release_color
        onClicked: {
            if( allow_clicked )
                btnclicked();
        }
    }

}
