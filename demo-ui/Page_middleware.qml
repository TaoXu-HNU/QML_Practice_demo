import QtQuick 2.0
import QtQuick.Window 2.2

import "./Qml_widget"

Item {
    id: middle_page
    width: 640
    height: 880

    signal engine_data()

    //需要展示的第二界面
    Rectangle{
        id: middle_page_container
        width: middle_page.width
        height: middle_page.height
        anchors.fill: parent
        color: "#050505"

        //标题
        Title_row{
            id: title_row_middle
            text: "请选择数据的来源"

            width: parent.width
            height: 80

            anchors.top:parent.top
            image_source: "qrc:/icons/left.png"

            onBack: {
                root_stack.pop()
            }
        }

        //列表
        Item{
            id:listview_container_middle
            width: parent.width

            anchors.top:title_row_middle.bottom
            anchors.topMargin: 10
            anchors.bottom: parent.bottom
            ListView{
                id:data_source_list
                width: listview_container_middle.width
                height: listview_container_middle.height
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 5
                model: param_list_model_middle
                clip: true //剪切其自身的绘制以及其子项目的绘制，使之与项目的边界矩形一致

                keyNavigationWraps :true   //导航循环包裹list，不会到边缘就跳出
//                highlight:Listview_heigh_light_type{
//                    width: 10//page_width - 8
//                    height: 16//page_height/16
//                    line_width: data_source_list.width - 40
//                    heigh_light_type: "line"
//                }
                highlightMoveDuration: 10   //设定高亮代理的移动速度，实质上是指切换动作的速度；暂时找到Value与每秒切换像素点数量的关系，value = 10效果良好。
                highlightFollowsCurrentItem: true

                delegate:Item{
                    id:item_dlg
                    width: listview_container_middle.width
                    height: 80
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
//                            console.log(index)
                            if( index === 0 )   //打开发动机数据界面
                            {
                                root_stack.push({item:"qrc:/Page_data_engine.qml", Immediate:true, destroyOnPop:false})
                            }
                            else                //打开车辆数据界面
                            {
                                root_stack.push({item:"qrc:/Page_data_vehicle.qml", Immediate:true, destroyOnPop:true});
                            }
                        }
                    }
                    /// 中间字符串,数据来源的名称
                    Text{
                        id: middletxt
                        text: name_middle

                        anchors.left: parent.left
                        anchors.leftMargin: 30
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter


                        width: 300
                        height: 35
                        font.pixelSize: 35
                        color: "#D6CDB6"
                    }

                    Text{
                        id:right_txt
                        text: value

                        anchors.right: parent.right
                        anchors.rightMargin: 30
                        anchors.verticalCenter: parent.verticalCenter
                        horizontalAlignment  : Text.AlignRight
                        verticalAlignment:Text.AlignVCenter
                        width: 300
                        height: 35
                        font.pixelSize: 35
                        color: "#D6CDB6"
                    }

                    Rectangle{
                        id: line
                        height: 2
                        anchors.left: middletxt.left
                        anchors.right: right_txt.right
                        anchors.bottom: parent.bottom
                        color: "#D6CDB6"
                        opacity: 0.4
                    }
                }
            }               
        }
    }

    //列表数据
    ListModel {
        id: param_list_model_middle

        ListElement { name_middle: "发动机数据"; value: "";}
        ListElement { name_middle: "车辆行驶数据"; value: "";}
    }

}
