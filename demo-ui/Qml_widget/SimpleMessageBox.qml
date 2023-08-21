import QtQuick 2.7
import QtQuick.Controls 1.2
import QtQuick.Window 2.0

//Window{
//    id:popup_list_fs
//    visible: true
//    width:720
//    height:1280
//    x:0
//    y:0
Rectangle{
    id: simpleMessageBox

    color: "black"
    x:330
    y:685

    property alias list_width:  list_container.width
    property alias list_height: list_container.height
    property alias title:       title_txt.text
    property alias left_tail:   left_tail_txt.text
    property alias right_tail:   right_tail_txt.text


    signal left_tail_clicked()
    signal left_tail_pressed()
    signal left_tail_released()

    signal right_tail_clicked()
    signal right_tail_pressed()
    signal right_tail_released()

//    Rectangle{
//        id: covery
//        width: 720
//        height: 1280
//        anchors.fill: parent
//        color: "#090909"
//        opacity: 0.7
//    }

    Rectangle{
        id:list_container
        width: 400//620
        height: 180//220
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "#242929"
        opacity: 0.95
        radius: 10
        border.color: "#6ba511"
        border.width: 2

        //显示的内容
        Text{
            id:title_txt
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 30
            horizontalAlignment  : Text.AlignHCenter
            width: 600
            height: 50
            text: "请选择要进行的操作"
            anchors.horizontalCenterOffset: 5
            font.pixelSize: 30
            color: "#D6CDB6"
        }

        //水平分隔线
        Rectangle{
            id: horizontal_split_line
            height: 2
            width: parent.width - 60
            anchors.bottom: right_txt_container.top
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#D6CDB6"
            opacity: 0.5
        }

        //垂直分隔线
        Rectangle{
            id: vertical_split_line
            width: 2
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:horizontal_split_line.bottom
            anchors.topMargin: 15
            color: "#D6CDB6"
            opacity: 0.5
        }

        //左边按钮
        Rectangle{
            id:left_txt_container
            height: 80
            width: parent.width/2
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            color: "transparent"

            Text{
                id:left_tail_txt
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment  : Text.AlignHCenter
                width: 200
                height: 35
                text:"替换"
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 35
                color: "#D6CDB6"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    left_tail_clicked()

                }
                onPressed: {
                    left_txt_container.color = "#FAA516"
                    left_tail_pressed();
                }

                onReleased: {
                    left_txt_container.color = "transparent"
                    left_tail_released();
                }
            }
        }

        //右边按钮
        Rectangle{
            id:right_txt_container
            height: 80
            width: parent.width/2
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            color: "transparent"

            Text{
                id:right_tail_txt
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment  : Text.AlignHCenter
                width: 200
                height: 35
                text:"删除"
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 35
                color: "#D6CDB6"
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    right_tail_clicked()
                }

                onPressed: {
                    right_txt_container.color = "#FAA516"
                    right_tail_pressed();
                }

                onReleased: {
                    right_txt_container.color = "transparent"
                    right_tail_released();
                }
            }
        }      
    }
}
//////////// end of code //////////////
