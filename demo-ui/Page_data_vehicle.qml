import QtQuick 2.0

import "./Qml_widget"

Item {
    id: vehicle_data_page
    width: 640
    height: 880

    //三个勾选框的状态，供外部修改
    property alias oil_state:   oil_btn.picked
    property alias odom_state:  odom_btn.picked
    property alias speed_state: speed_btn.picked

    signal select_oil()
    signal select_odom()
    signal select_speed()

    //标题
    Title_row{
        id: title_vehicle_data
        text: "车辆数据"

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
        id:listview_container_vehicle_data
        width: parent.width

        anchors.top:title_vehicle_data.bottom
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        ListView{
            id: vehicle_data_list
            width: listview_container_vehicle_data.width
            height: listview_container_vehicle_data.height
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5
            model: param_list_model_vehicle_data
            clip: true //剪切其自身的绘制以及其子项目的绘制，使之与项目的边界矩形一致

            keyNavigationWraps :true   //导航循环包裹list，不会到边缘就跳出
//            highlight:Listview_heigh_light_type{
//                width: 10//page_width - 8
//                height: 16//page_height/16
//                line_width: engine_data_list.width - 40
//                heigh_light_type: "line"
//            }
            highlightMoveDuration: 10   //设定高亮代理的移动速度，实质上是指切换动作的速度；暂时找到Value与每秒切换像素点数量的关系，value = 10效果良好。
            highlightFollowsCurrentItem: true

            delegate:Item{
                id: item_vehicle_data
                width: listview_container_vehicle_data.width
                height: 80
                MouseArea{
                    anchors.fill: parent
                    onClicked: {           //点击菜单子栏也高亮显示并触发选择的信号，效果等同于勾选按钮
                        if( index === 0 )
                        {
                            oil_btn.picked = !oil_btn.picked

                            if(oil_btn.picked)   //勾选后向列表中增加内容
                            {
                                if(replace_flag){   //进入替换功能

                                    /*** 替换逻辑：删除原内容->原位置插入新内容->修改新内容对应的刷新位置->取消原勾选项->清除替换按钮的标志位 ***/
                                    param_list_model.remove( current_item_row )  //删除 Page_main.qml中当前行的内容

                                    param_list_model.insert( current_item_row, {name: "油量",  value: data_oil_cache, unit: "L"}) //插入新的内容

                                    oil_row_position = current_item_row  //设置 新内容 的 刷新位置 为原位置，很重要！否则替换后无法刷新 数据

                                    //取消当前行原有的 勾选属性
                                    switch(current_item_name){
                                        case "续航": odom_btn.picked = !odom_btn.picked;
                                                    select_odom_flag = !select_odom_flag;   break;

                                        case "速度": speed_btn.picked = !speed_btn.picked;
                                                    select_speed_flag = !select_speed_flag; break;

                                        case "发动机转速": var cmp_rpm_clickedItem0 = Qt.createComponent( "qrc:/Page_data_engine.qml" ) //创建组件
                                                         var vehicle_page_rpm_clickedItem0 = cmp_rpm_clickedItem0.createObject( switch_area )  //创建对象

                                                         vehicle_page_rpm_clickedItem0.rpm_state = !vehicle_page_rpm_clickedItem0.rpm_state    //取消勾选状态
                                                         select_rpm_flag = !select_rpm_flag;  //标志位也同步改变，防止下次进入时由于标志位未清零而强行改变勾选状态

                                                         vehicle_page_rpm_clickedItem0.destroy(); break;   //操作完成后，需要进行销毁释放

                                        case "发动机档位": var cmp_gear_clickedItem0 = Qt.createComponent( "qrc:/Page_data_engine.qml" )
                                                         var vehicle_page_gear_clickedItem0 = cmp_gear_clickedItem0.createObject( switch_area )

                                                         vehicle_page_gear_clickedItem0.gear_state = !vehicle_page_gear_clickedItem0.gear_state
                                                         select_gear_flag = !select_gear_flag;

                                                         vehicle_page_gear_clickedItem0.destroy(); break;

                                        case "发动机温度": var cmp_temp_clickedItem0 = Qt.createComponent( "qrc:/Page_data_engine.qml" )
                                                         var vehicle_page_temp_clickedItem0 = cmp_temp_clickedItem0.createObject( switch_area )

                                                         vehicle_page_temp_clickedItem0.temp_state = !vehicle_page_temp_clickedItem0.temp_state
                                                         select_temp_flag = !select_temp_flag;

                                                         vehicle_page_temp_clickedItem0.destroy(); break;
                                    }

                                    replace_flag = false  //恢复 替换按钮 的标志位
                                }

                                else{       //进入添加功能

                                    param_list_model.append({"name": "油量",  "value": 00, "unit": "L"})

                                    count_num = count_num + 1
                                    oil_row_position = count_num
                                    console.log(oil_row_position)
                                }
                            }
                            else
                            {
                                delete_oil()  //删除该行内容
                            }

                            select_oil()     //勾选，发送信号
                        }
                        else if( index === 1 )
                        {
                            odom_btn.picked = !odom_btn.picked

                            if(odom_btn.picked)
                            {
                                if(replace_flag){   //进入替换功能

                                    /*** 替换逻辑：删除原内容->原位置插入新内容->修改新内容对应的刷新位置->取消原勾选项->清除替换按钮的标志位 ***/
                                    param_list_model.remove( current_item_row )  //删除 Page_main.qml中当前行的内容

                                    param_list_model.insert( current_item_row, {name: "续航",  value: data_odom_cache, unit: "km"}) //插入新的内容

                                    odom_row_position = current_item_row  //设置 新内容 的 刷新位置 为原位置，很重要！否则替换后无法刷新 数据

                                    //取消当前行原有的 勾选属性
                                    switch(current_item_name){
                                        case "油量": oil_btn.picked = !oil_btn.picked;
                                                         select_oil_flag = !select_oil_flag;   break;

                                        case "速度": speed_btn.picked = !speed_btn.picked;
                                                         select_speed_flag = !select_speed_flag; break;

                                        case "发动机转速": var cmp_rpm_clickedItem1 = Qt.createComponent( "qrc:/Page_data_engine.qml" ) //创建组件
                                                         var vehicle_page_rpm_clickedItem1 = cmp_rpm_clickedItem1.createObject( switch_area )  //创建对象

                                                         vehicle_page_rpm_clickedItem1.rpm_state = !vehicle_page_rpm_clickedItem1.rpm_state    //取消勾选状态
                                                         select_rpm_flag = !select_rpm_flag;  //标志位也同步改变，防止下次进入时由于标志位未清零而强行改变勾选状态

                                                         vehicle_page_rpm_clickedItem1.destroy(); break;   //操作完成后，需要进行销毁释放

                                        case "发动机档位": var cmp_gear_clickedItem1 = Qt.createComponent( "qrc:/Page_data_engine.qml" )
                                                         var vehicle_page_gear_clickedItem1 = cmp_gear_clickedItem1.createObject( switch_area )

                                                         vehicle_page_gear_clickedItem1.gear_state = !vehicle_page_gear_clickedItem1.gear_state
                                                         select_gear_flag = !select_gear_flag;

                                                         vehicle_page_gear_clickedItem1.destroy(); break;

                                        case "发动机温度": var cmp_temp_clickedItem1 = Qt.createComponent( "qrc:/Page_data_engine.qml" )
                                                         var vehicle_page_temp_clickedItem1 = cmp_temp_clickedItem1.createObject( switch_area )

                                                         vehicle_page_temp_clickedItem1.temp_state = !vehicle_page_temp_clickedItem1.temp_state
                                                         select_temp_flag = !select_temp_flag;

                                                         vehicle_page_temp_clickedItem1.destroy(); break;
                                    }

                                    replace_flag = false  //恢复 替换按钮 的标志位
                                }

                                else{       //进入添加功能
                                    param_list_model.append({"name": "续航",  "value": 00, "unit": "km"})

                                    count_num = count_num + 1
                                    odom_row_position = count_num
                                    console.log(odom_row_position)
                                }
                            }
                            else
                            {
                                delete_odom()
                            }

                            select_odom()
                        }
                        else
                        {
                            speed_btn.picked = !speed_btn.picked

                            if(speed_btn.picked)
                            {
                                if(replace_flag){   //进入替换功能

                                    /*** 替换逻辑：删除原内容->原位置插入新内容->修改新内容对应的刷新位置->取消原勾选项->清除替换按钮的标志位 ***/
                                    param_list_model.remove( current_item_row )  //删除 Page_main.qml中当前行的内容

                                    param_list_model.insert( current_item_row, {name: "速度",  value: data_speed_cache, unit: "km/h"}) //插入新的内容

                                    speed_row_position = current_item_row  //设置 新内容 的 刷新位置 为原位置，很重要！否则替换后无法刷新 数据

                                    //取消当前行原有的 勾选属性
                                    switch(current_item_name){
                                        case "油量": oil_btn.picked = !oil_btn.picked;
                                                         select_oil_flag = !select_oil_flag;   break;

                                        case "续航": odom_btn.picked = !odom_btn.picked;
                                                         select_odom_flag = !select_odom_flag; break;

                                        case "发动机转速": var cmp_rpm_clickedItem2 = Qt.createComponent( "qrc:/Page_data_engine.qml" ) //创建组件
                                                         var vehicle_page_rpm_clickedItem2 = cmp_rpm_clickedItem2.createObject( switch_area )  //创建对象

                                                         vehicle_page_rpm_clickedItem2.rpm_state = !vehicle_page_rpm_clickedItem2.rpm_state    //取消勾选状态
                                                         select_rpm_flag = !select_rpm_flag;  //标志位也同步改变，防止下次进入时由于标志位未清零而强行改变勾选状态

                                                         vehicle_page_rpm_clickedItem2.destroy(); break;   //操作完成后，需要进行销毁释放

                                        case "发动机档位": var cmp_gear_clickedItem2 = Qt.createComponent( "qrc:/Page_data_engine.qml" )
                                                         var vehicle_page_gear_clickedItem2 = cmp_gear_clickedItem2.createObject( switch_area )

                                                         vehicle_page_gear_clickedItem2.gear_state = !vehicle_page_gear_clickedItem2.gear_state
                                                         select_gear_flag = !select_gear_flag;

                                                         vehicle_page_gear_clickedItem2.destroy(); break;

                                        case "发动机温度": var cmp_temp_clickedItem2 = Qt.createComponent( "qrc:/Page_data_engine.qml" )
                                                         var vehicle_page_temp_clickedItem2 = cmp_temp_clickedItem2.createObject( switch_area )

                                                         vehicle_page_temp_clickedItem2.temp_state = !vehicle_page_temp_clickedItem2.temp_state
                                                         select_temp_flag = !select_temp_flag;

                                                         vehicle_page_temp_clickedItem2.destroy(); break;
                                    }

                                    replace_flag = false  //恢复 替换按钮 的标志位
                                }

                                else{       //进入添加功能
                                    param_list_model.append({"name": "速度",  "value": 00, "unit": "km/h"})

                                    count_num = count_num + 1
                                    speed_row_position = count_num
                                    console.log(speed_row_position)
                                }
                            }
                            else
                            {
                                delete_speed()
                            }

                            select_speed()
                        }
                    }
                }
                /// 中间字符串,数据来源的名称
                Text{
                    id: vehicle_item_txt
                    text: data_name

                    anchors.left: parent.left
                    anchors.leftMargin: 90
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter


                    width: 300
                    height: 35
                    font.pixelSize: 35
                    color: "#D6CDB6"
                }

                //发动机数据值
                Text{
                    id:vehicle_value_txt
                    text: data_value

                    anchors.right: parent.right
                    anchors.rightMargin: 120
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment  : Text.AlignRight
                    verticalAlignment:Text.AlignVCenter
                    width: 300
                    height: 35
                    font.pixelSize: 35
                    color: "#D6CDB6"
                }

                //单位
                Text{
                    id:vehicle_value_unit
                    text: data_unit

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
                    anchors.left: vehicle_item_txt.left
                    anchors.right: vehicle_value_unit.right
                    anchors.bottom: parent.bottom
                    color: "#D6CDB6"
                    opacity: 0.4
                }
            }
        }
    }

    //列表数据
    ListModel {
        id: param_list_model_vehicle_data

//        ListElement { data_name: "油量";  data_value: 00; data_unit: "L"}
//        ListElement { data_name: "续航";  data_value: 00; data_unit: "km"}
//        ListElement { data_name: "速度";  data_value: 00; data_unit: "km/h"}

        //该种初始化赋值的方式可使得：创建列表时的 初始数据 跟随 动态数据 的变化而变化，实现与外部变量的动态绑定
        Component.onCompleted: {
            param_list_model_vehicle_data.append({ data_name: "油量",  data_value: data_oil_cache,   data_unit: "L"})
            param_list_model_vehicle_data.append({ data_name: "续航",  data_value: data_odom_cache,  data_unit: "km"})
            param_list_model_vehicle_data.append({ data_name: "速度",  data_value: data_speed_cache, data_unit: "km/h"})
        }

    }


    //选择按钮_油量
    SimpleButton{
        id: oil_btn
        x: 24
        y: 113
        icon: "qrc:/icons/rect_empty.png"
        picked_icon: "qrc:/icons/rect_select.png"

        picked: select_oil_flag   //恢复至上一次退出前的状态

        onSimpleButtonClicked: {
            picked = !picked   //切换选中与未选中的图片标志位

            if(picked)
            {
                if(replace_flag){   //进入替换功能

                    /*** 替换逻辑：删除原内容->原位置插入新内容->修改新内容对应的刷新位置->取消原勾选项->清除替换按钮的标志位 ***/
                    param_list_model.remove( current_item_row )  //删除 Page_main.qml中当前行的内容

                    param_list_model.insert( current_item_row, {name: "油量",  value: data_oil_cache, unit: "L"}) //插入新的内容

                    oil_row_position = current_item_row  //设置 新内容 的 刷新位置 为原位置，很重要！否则替换后无法刷新 数据

                    //取消当前行原有的 勾选属性
                    switch(current_item_name){
                        case "续航": odom_btn.picked = !odom_btn.picked;
                                    select_odom_flag = !select_odom_flag;   break;

                        case "速度": speed_btn.picked = !speed_btn.picked;
                                    select_speed_flag = !select_speed_flag; break;

                        case "发动机转速": var cmp_rpm = Qt.createComponent( "qrc:/Page_data_engine.qml" ) //创建组件
                                         var vehicle_page_rpm = cmp_rpm.createObject( switch_area )  //创建对象

                                         vehicle_page_rpm.rpm_state = !vehicle_page_rpm.rpm_state    //取消勾选状态
                                         select_rpm_flag = !select_rpm_flag;  //标志位也同步改变，防止下次进入时由于标志位未清零而强行改变勾选状态

                                         vehicle_page_rpm.destroy(); break;   //操作完成后，需要进行销毁释放

                        case "发动机档位": var cmp_gear = Qt.createComponent( "qrc:/Page_data_engine.qml" )
                                         var vehicle_page_gear = cmp_gear.createObject( switch_area )

                                         vehicle_page_gear.gear_state = !vehicle_page_gear.gear_state
                                         select_gear_flag = !select_gear_flag;

                                         vehicle_page_gear.destroy(); break;

                        case "发动机温度": var cmp_temp = Qt.createComponent( "qrc:/Page_data_engine.qml" )
                                         var vehicle_page_temp = cmp_temp.createObject( switch_area )

                                         vehicle_page_temp.temp_state = !vehicle_page_temp.temp_state
                                         select_temp_flag = !select_temp_flag;

                                         vehicle_page_temp.destroy(); break;
                    }

                    replace_flag = false  //恢复 替换按钮 的标志位
                }

                else{       //进入添加功能
                    param_list_model.append({"name": "油量",  "value": data_oil_cache, "unit": "L"})

                    count_num = count_num + 1
                    oil_row_position = count_num
                    console.log(oil_row_position)
                }
            }
            else
            {
                delete_oil()
            }

            select_oil()
        }
    }

    //选择按钮_续航
    SimpleButton{
        id: odom_btn
        x: 24
        y: 200
        icon: "qrc:/icons/rect_empty.png"
        picked_icon: "qrc:/icons/rect_select.png"

        picked: select_odom_flag

        onSimpleButtonClicked: {
            picked = !picked   //切换选中与未选中的图片标志位

            if(picked)
            {
                if(replace_flag){   //进入替换功能

                    /*** 替换逻辑：删除原内容->原位置插入新内容->修改新内容对应的刷新位置->取消原勾选项->清除替换按钮的标志位 ***/
                    param_list_model.remove( current_item_row )  //删除 Page_main.qml中当前行的内容

                    param_list_model.insert( current_item_row, {name: "续航",  value: data_odom_cache, unit: "km"}) //插入新的内容

                    odom_row_position = current_item_row  //设置 新内容 的 刷新位置 为原位置，很重要！否则替换后无法刷新 数据

                    //取消当前行原有的 勾选属性
                    switch(current_item_name){
                        case "油量": oil_btn.picked = !oil_btn.picked;
                                         select_oil_flag = !select_oil_flag;   break;

                        case "速度": speed_btn.picked = !speed_btn.picked;
                                         select_speed_flag = !select_speed_flag; break;

                        case "发动机转速": var cmp_rpm = Qt.createComponent( "qrc:/Page_data_engine.qml" ) //创建组件
                                         var vehicle_page_rpm = cmp_rpm.createObject( switch_area )  //创建对象

                                         vehicle_page_rpm.rpm_state = !vehicle_page_rpm.rpm_state    //取消勾选状态
                                         select_rpm_flag = !select_rpm_flag;  //标志位也同步改变，防止下次进入时由于标志位未清零而强行改变勾选状态

                                         vehicle_page_rpm.destroy(); break;   //操作完成后，需要进行销毁释放

                        case "发动机档位": var cmp_gear = Qt.createComponent( "qrc:/Page_data_engine.qml" )
                                         var vehicle_page_gear = cmp_gear.createObject( switch_area )

                                         vehicle_page_gear.gear_state = !vehicle_page_gear.gear_state
                                         select_gear_flag = !select_gear_flag;

                                         vehicle_page_gear.destroy(); break;

                        case "发动机温度": var cmp_temp = Qt.createComponent( "qrc:/Page_data_engine.qml" )
                                         var vehicle_page_temp = cmp_temp.createObject( switch_area )

                                         vehicle_page_temp.temp_state = !vehicle_page_temp.temp_state
                                         select_temp_flag = !select_temp_flag;

                                         vehicle_page_temp.destroy(); break;
                    }

                    replace_flag = false  //恢复 替换按钮 的标志位
                }

                else{       //进入添加功能

                    param_list_model.append({"name": "续航",  "value": data_odom_cache, "unit": "km"})

                    count_num = count_num + 1
                    odom_row_position = count_num
                    console.log(odom_row_position)
                }
            }
            else
            {
                delete_odom()
            }

            select_odom()
        }
    }

    //选择按钮_速度
    SimpleButton{
        id: speed_btn
        x: 24
        y: 286
        icon: "qrc:/icons/rect_empty.png"
        picked_icon: "qrc:/icons/rect_select.png"

        picked: select_speed_flag

        onSimpleButtonClicked: {
            picked = !picked   //切换选中与未选中的图片标志位

            if(picked)
            {
                if(replace_flag){   //进入替换功能

                    /*** 替换逻辑：删除原内容->原位置插入新内容->修改新内容对应的刷新位置->取消原勾选项->清除替换按钮的标志位 ***/
                    param_list_model.remove( current_item_row )  //删除 Page_main.qml中当前行的内容

                    param_list_model.insert( current_item_row, {name: "速度",  value: data_speed_cache, unit: "km/h"}) //插入新的内容

                    speed_row_position = current_item_row  //设置 新内容 的 刷新位置 为原位置，很重要！否则替换后无法刷新 数据

                    //取消当前行原有的 勾选属性
                    switch(current_item_name){
                        case "油量": oil_btn.picked = !oil_btn.picked;
                                         select_oil_flag = !select_oil_flag;   break;

                        case "续航": odom_btn.picked = !odom_btn.picked;
                                         select_odom_flag = !select_odom_flag; break;

                        case "发动机转速": var cmp_rpm = Qt.createComponent( "qrc:/Page_data_engine.qml" ) //创建组件
                                         var vehicle_page_rpm = cmp_rpm.createObject( switch_area )  //创建对象

                                         vehicle_page_rpm.rpm_state = !vehicle_page_rpm.rpm_state    //取消勾选状态
                                         select_rpm_flag = !select_rpm_flag;  //标志位也同步改变，防止下次进入时由于标志位未清零而强行改变勾选状态

                                         vehicle_page_rpm.destroy(); break;   //操作完成后，需要进行销毁释放

                        case "发动机档位": var cmp_gear = Qt.createComponent( "qrc:/Page_data_engine.qml" )
                                         var vehicle_page_gear = cmp_gear.createObject( switch_area )

                                         vehicle_page_gear.gear_state = !vehicle_page_gear.gear_state
                                         select_gear_flag = !select_gear_flag;

                                         vehicle_page_gear.destroy(); break;

                        case "发动机温度": var cmp_temp = Qt.createComponent( "qrc:/Page_data_engine.qml" )
                                         var vehicle_page_temp = cmp_temp.createObject( switch_area )

                                         vehicle_page_temp.temp_state = !vehicle_page_temp.temp_state
                                         select_temp_flag = !select_temp_flag;

                                         vehicle_page_temp.destroy(); break;
                    }

                    replace_flag = false  //恢复 替换按钮 的标志位
                }

                else{       //进入添加功能

                    param_list_model.append({"name": "速度",  "value": data_speed_cache, "unit": "km/h"})

                    count_num = count_num + 1
                    speed_row_position = count_num
                    console.log(speed_row_position)
                }
            }
            else
            {
                delete_speed()
            }

            select_speed()
        }
    }


    //定时_刷新显示车辆的相关数据
    Timer{
        id: timer_display_engine_data
        interval: 100
        repeat: true
        running: true

        onTriggered: {
            param_list_model_vehicle_data.setProperty(0, "data_value", data_oil_cache)
            param_list_model_vehicle_data.setProperty(1, "data_value", data_odom_cache)
            param_list_model_vehicle_data.setProperty(2, "data_value", data_speed_cache)
        }
    }


    //槽函数区域_用于将选择结果传递出去
    onSelect_oil: {
        select_oil_flag = !select_oil_flag
    }

    onSelect_odom: {
        select_odom_flag = !select_odom_flag
    }

    onSelect_speed: {
        select_speed_flag = !select_speed_flag
    }


    //删除 勾选的油量
    function delete_oil()
    {
        param_list_model.remove(oil_row_position)
        count_num = count_num - 1

        if(rpm_row_position > oil_row_position){
            rpm_row_position = rpm_row_position - 1
        }

        if(gear_row_position > oil_row_position){
            gear_row_position = gear_row_position - 1
        }

        if(temp_row_position > oil_row_position){
            temp_row_position = temp_row_position - 1
        }

        if(odom_row_position > oil_row_position){
            odom_row_position = odom_row_position - 1
        }

        if(speed_row_position > oil_row_position){
            speed_row_position = speed_row_position - 1
        }
    }

    //删除 勾选的续航
    function delete_odom()
    {
        param_list_model.remove(odom_row_position)
        count_num = count_num - 1

        if(rpm_row_position > odom_row_position){
            rpm_row_position = rpm_row_position - 1
        }

        if(gear_row_position > odom_row_position){
            gear_row_position = gear_row_position - 1
        }

        if(temp_row_position > odom_row_position){
            temp_row_position = temp_row_position - 1
        }

        if(oil_row_position > odom_row_position){
            oil_row_position = oil_row_position - 1
        }

        if(speed_row_position > odom_row_position){
            speed_row_position = speed_row_position - 1
        }
    }

    //删除 勾选的速度
    function delete_speed()
    {
        param_list_model.remove(speed_row_position)
        count_num = count_num - 1

        if(rpm_row_position > speed_row_position){
            rpm_row_position = rpm_row_position - 1
        }

        if(gear_row_position > speed_row_position){
            gear_row_position = gear_row_position - 1
        }

        if(temp_row_position > speed_row_position){
            temp_row_position = temp_row_position - 1
        }

        if(oil_row_position > speed_row_position){
            oil_row_position = oil_row_position - 1
        }

        if(odom_row_position > speed_row_position){
            odom_row_position = odom_row_position - 1
        }
    }

}
