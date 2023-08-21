import QtQuick 2.0

import "./Qml_widget"

Item {
    id: engine_data_page
    width: 640
    height: 880

    //三个勾选框的状态，供外部修改
    property alias rpm_state:  rpm_btn.picked
    property alias gear_state: gears_btn.picked
    property alias temp_state: temp_btn.picked

    signal select_rpm()
    signal select_gear()
    signal select_temp()

    //标题
    Title_row{
        id: title_engine_data
        text: "发动机数据"

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
        id:listview_container_engine_data
        width: parent.width

        anchors.top:title_engine_data.bottom
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        ListView{
            id: engine_data_list
            width: listview_container_engine_data.width
            height: listview_container_engine_data.height
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5
            model: param_list_model_engine_data
            clip: true //剪切其自身的绘制以及其子项目的绘制，使之与项目的边界矩形一致

            keyNavigationWraps :true   //导航循环包裹list，不会到边缘就跳出

            highlightMoveDuration: 10   //设定高亮代理的移动速度，实质上是指切换动作的速度；暂时找到Value与每秒切换像素点数量的关系，value = 10效果良好。
            highlightFollowsCurrentItem: true

            delegate:Item{
                id: item_engine_data
                width: listview_container_engine_data.width
                height: 80
                MouseArea{
                    anchors.fill: parent
                    onClicked: {     //点击菜单子栏也高亮显示并触发选择的信号，效果等同于勾选按钮
                        if( index === 0 )
                        {
                            rpm_btn.picked = !rpm_btn.picked

                            if(rpm_btn.picked)  //勾选后向列表中替换/增加内容
                            {

                                if(replace_flag){   //进入替换功能


                                    /*** 替换逻辑：删除原内容->原位置插入新内容->修改新内容对应的刷新位置->取消原勾选项->清除替换按钮的标志位 ***/
                                    param_list_model.remove( current_item_row )  //删除 Page_main.qml中当前行的内容

                                    param_list_model.insert( current_item_row, {name: "发动机转速",  value: data_rpm_cache, unit: "rpm"}) //插入新的内容

                                    rpm_row_position = current_item_row  //设置 新内容 的 刷新位置 为原位置，很重要！否则替换后无法刷新 数据

                                    //取消当前行的 勾选属性
                                    switch(current_item_name){
                                        case "发动机档位": gears_btn.picked = !gears_btn.picked;  //break;
                                                         select_gear_flag = !select_gear_flag; break;  //同步修改 保存是否勾选的标志位，防止下次进入时未取消勾选

                                        case "发动机温度": temp_btn.picked = !temp_btn.picked;  // break;
                                                         select_temp_flag = !select_temp_flag; break;

                                        case "油量": var cmp_oil_clickedItem0 = Qt.createComponent( "qrc:/Page_data_vehicle.qml" ) //创建组件
                                                    var vehicle_page_oil_clickedItem0 = cmp_oil_clickedItem0.createObject( switch_area )  //创建对象

                                                    vehicle_page_oil_clickedItem0.oil_state = !vehicle_page_oil_clickedItem0.oil_state    //取消勾选状态
                                                    select_oil_flag = !select_oil_flag;  //标志位也同步改变，防止下次进入时由于标志位未清零而强行改变勾选状态

                                                    vehicle_page_oil_clickedItem0.destroy(); break;   //操作完成后，需要进行销毁释放

                                        case "续航": var cmp_odom_clickedItem0 = Qt.createComponent( "qrc:/Page_data_vehicle.qml" )
                                                    var vehicle_page_odom_clickedItem0 = cmp_odom_clickedItem0.createObject( switch_area )

                                                    vehicle_page_odom_clickedItem0.odom_state = !vehicle_page_odom_clickedItem0.odom_state
                                                    select_odom_flag = !select_odom_flag;

                                                    vehicle_page_odom_clickedItem.destroy(); break;

                                        case "速度": var cmp_speed_clickedItem0 = Qt.createComponent( "qrc:/Page_data_vehicle.qml" )
                                                    var vehicle_page_speed_clickedItem0 = cmp_speed_clickedItem0.createObject( switch_area )

                                                    vehicle_page_speed_clickedItem0.speed_state = !vehicle_page_speed_clickedItem0.speed_state
                                                    select_speed_flag = !select_speed_flag;

                                                    vehicle_page_speed_clickedItem0.destroy(); break;
                                    }

                                    replace_flag = false  //恢复 替换按钮 的标志位
                                }

                                else{    //添加新内容
                                    param_list_model.append({"name": "发动机转速",  "value": data_rpm_cache, "unit": "rpm"})

                                    count_num = count_num + 1
                                    rpm_row_position = count_num
                                    console.log(rpm_row_position)
                                }
                            }
                            else
                            {
                                delete_rpm()  //删除该行内容
                            }

                            select_rpm()     //勾选，发送信号
                        }

                        else if( index === 1 )
                        {
                            gears_btn.picked = !gears_btn.picked

                            if(gears_btn.picked)
                            {
                                if(replace_flag){   //进入替换功能

                                    /*** 替换逻辑：删除原内容->原位置插入新内容->修改新内容对应的刷新位置->取消原勾选项->清除替换按钮的标志位 ***/
                                    param_list_model.remove( current_item_row )  //删除 Page_main.qml中当前行的内容

                                    param_list_model.insert( current_item_row, {name: "发动机档位",  value: data_gear_cache, unit: "gear"}) //插入新的内容

                                    gear_row_position = current_item_row  //设置 新内容 的 刷新位置 为原位置，很重要！否则替换后无法刷新 数据

                                    //取消当前行的 勾选属性
                                    switch(current_item_name){
                                        case "发动机转速": rpm_btn.picked = !rpm_btn.picked;
                                                         select_rpm_flag = !select_rpm_flag; break;

                                        case "发动机温度": temp_btn.picked = !temp_btn.picked;
                                                         select_temp_flag = !select_temp_flag; break;

                                        case "油量": var cmp_oil_clickedItem1 = Qt.createComponent( "qrc:/Page_data_vehicle.qml" ) //创建组件
                                                    var vehicle_page_oil_clickedItem1 = cmp_oil_clickedItem1.createObject( switch_area )  //创建对象

                                                    vehicle_page_oil_clickedItem1.oil_state = !vehicle_page_oil_clickedItem1.oil_state    //取消勾选状态
                                                    select_oil_flag = !select_oil_flag;  //标志位也同步改变，防止下次进入时由于标志位未清零而强行改变勾选状态

                                                    vehicle_page_oil_clickedItem1.destroy(); break;   //操作完成后，需要进行销毁释放

                                        case "续航": var cmp_odom_clickedItem1 = Qt.createComponent( "qrc:/Page_data_vehicle.qml" )
                                                    var vehicle_page_odom_clickedItem1 = cmp_odom_clickedItem1.createObject( switch_area )

                                                    vehicle_page_odom_clickedItem1.odom_state = !vehicle_page_odom_clickedItem1.odom_state
                                                    select_odom_flag = !select_odom_flag;

                                                    vehicle_page_odom_clickedItem1.destroy(); break;

                                        case "速度": var cmp_speed_clickedItem1 = Qt.createComponent( "qrc:/Page_data_vehicle.qml" )
                                                    var vehicle_page_speed_clickedItem1 = cmp_speed_clickedItem1.createObject( switch_area )

                                                    vehicle_page_speed_clickedItem1.speed_state = !vehicle_page_speed_clickedItem1.speed_state
                                                    select_speed_flag = !select_speed_flag;

                                                    vehicle_page_speed_clickedItem1.destroy(); break;
                                    }

                                    replace_flag = false  //恢复 替换按钮 的标志位
                                }

                                else{       //进入添加功能

                                    param_list_model.append({"name": "发动机档位",  "value": data_gear_cache, "unit": "gear"})

                                    count_num = count_num + 1
                                    gear_row_position = count_num
                                    console.log(gear_row_position)
                                }
                            }
                            else
                            {
                                delete_gear()
                            }

                            select_gear()
                        }


                        else
                        {
                            temp_btn.picked = !temp_btn.picked

                            if(temp_btn.picked)
                            {
                                if(replace_flag){   //进入替换功能

                                    /*** 替换逻辑：删除原内容->原位置插入新内容->修改新内容对应的刷新位置->取消原勾选项->清除替换按钮的标志位 ***/
                                    param_list_model.remove( current_item_row )  //删除 Page_main.qml中当前行的内容

                                    param_list_model.insert( current_item_row, {name: "发动机温度",  value: data_temp_cache, unit: "℃"}) //插入新的内容

                                    temp_row_position = current_item_row  //设置 新内容 的 刷新位置 为原位置，很重要！否则替换后无法刷新 数据

                                    //取消当前行原有的 勾选属性
                                    switch(current_item_name){
                                        case "发动机转速": rpm_btn.picked = !rpm_btn.picked;
                                                         select_rpm_flag = !select_rpm_flag;   break;

                                        case "发动机档位": gears_btn.picked = !gears_btn.picked;
                                                         select_gear_flag = !select_gear_flag; break;

                                        case "油量": var cmp_oil_clickedItem2 = Qt.createComponent( "qrc:/Page_data_vehicle.qml" ) //创建组件
                                                    var vehicle_page_oil_clickedItem2 = cmp_oil_clickedItem2.createObject( switch_area )  //创建对象

                                                    vehicle_page_oil_clickedItem2.oil_state = !vehicle_page_oil_clickedItem2.oil_state    //取消勾选状态
                                                    select_oil_flag = !select_oil_flag;  //标志位也同步改变，防止下次进入时由于标志位未清零而强行改变勾选状态

                                                    vehicle_page_oil_clickedItem2.destroy(); break;   //操作完成后，需要进行销毁释放

                                        case "续航": var cmp_odom_clickedItem2 = Qt.createComponent( "qrc:/Page_data_vehicle.qml" )
                                                    var vehicle_page_odom_clickedItem2 = cmp_odom_clickedItem2.createObject( switch_area )

                                                    vehicle_page_odom_clickedItem2.odom_state = !vehicle_page_odom_clickedItem2.odom_state
                                                    select_odom_flag = !select_odom_flag;

                                                    vehicle_page_odom_clickedItem2.destroy(); break;

                                        case "速度": var cmp_speed_clickedItem2 = Qt.createComponent( "qrc:/Page_data_vehicle.qml" )
                                                    var vehicle_page_speed_clickedItem2 = cmp_speed_clickedItem2.createObject( switch_area )

                                                    vehicle_page_speed_clickedItem2.speed_state = !vehicle_page_speed_clickedItem2.speed_state
                                                    select_speed_flag = !select_speed_flag;

                                                    vehicle_page_speed_clickedItem2.destroy(); break;
                                    }

                                    replace_flag = false  //恢复 替换按钮 的标志位
                                }

                                else{      //添加新内容
                                    param_list_model.append({"name": "发动机温度",  "value": data_temp_cache, "unit": "℃"})

                                    count_num = count_num + 1
                                    temp_row_position = count_num
                                    console.log(temp_row_position)
                                }
                            }
                            else
                            {
                                delete_temp()
                            }

                            select_temp()
                        }
                    }
                }
                /// 中间字符串,数据来源的名称
                Text{
                    id: engine_item_txt
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
                    id: engine_value_txt
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
                    id: unit_txt
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
                    anchors.left:   engine_item_txt.left
                    anchors.right:  unit_txt.right
                    anchors.bottom: parent.bottom
                    color: "#D6CDB6"
                    opacity: 0.4
                }
            }
        }
    }


    //列表数据
    ListModel {
        id: param_list_model_engine_data

//        ListElement { data_name: "转速";  data_value: 0; data_unit: "rpm"}
//        ListElement { data_name: "档位";  data_value: 0; data_unit: "gear"}
//        ListElement { data_name: "温度";  data_value: 0; data_unit: "℃"}

//        ListElement { data_name: "转速";  data_value: data_rpm_cache; data_unit: "rpm"} //经测试发现，ListElement 无法直接绑定到外部变量

        //该种初始化赋值的方式可使得：创建列表时的 初始数据 跟随 动态数据 的变化而变化，实现与外部变量的动态绑定
        Component.onCompleted: {
            param_list_model_engine_data.append({ data_name: "转速",  data_value: data_rpm_cache,  data_unit: "rpm"})
            param_list_model_engine_data.append({ data_name: "档位",  data_value: data_gear_cache, data_unit: "gear"})
            param_list_model_engine_data.append({ data_name: "温度",  data_value: data_temp_cache, data_unit: "℃"})
        }
    }


    //选择按钮_转速
    SimpleButton{
        id: rpm_btn
        x: 24
        y: 113
        icon: "qrc:/icons/rect_empty.png"
        picked_icon: "qrc:/icons/rect_select.png"

        picked: select_rpm_flag   //恢复至上一次退出前的状态， select_rpm_flag为全局变量

        onSimpleButtonClicked: {
            /**** 特殊处理：在"替换状态"下的 重复勾选 的点击事件 ****/
            if( picked ){
                //勾选状态下，再次点击弹出警告的对话框
                var cmp_item = Qt.createComponent( "qrc:/Qml_widget/SimpleMessageBox.qml" );
                popup_select = cmp_item.createObject( switch_area,
                                                        {
                                                         "list_width" : 500,
                                                         "title"      :"当前项已在首页显示，是否替换？",
                                                         "left_tail"  :"是",
                                                         "right_tail" :"否"
                                                        });

                popup_select.left_tail_clicked.connect(  readd_rpm_slot );
                popup_select.right_tail_clicked.connect( cancel_slot    );

            }

            /**** 正常的点击事件 ****/
            else{
                picked = !picked   //切换选中与未选中的图片标志位

                if(picked)        //勾选后向列表中替换/增加内容
                {
                    if(replace_flag){   //进入替换功能


                        /*** 替换逻辑：删除原内容->原位置插入新内容->修改新内容对应的刷新位置->取消原勾选项->清除替换按钮的标志位 ***/
                        param_list_model.remove( current_item_row )  //删除 Page_main.qml中当前行的内容

                        param_list_model.insert( current_item_row, {name: "发动机转速",  value: data_rpm_cache, unit: "rpm"}) //插入新的内容

                        rpm_row_position = current_item_row  //设置 新内容 的 刷新位置 为原位置，很重要！否则替换后无法刷新 数据

                        //取消当前行的 勾选属性
                        switch(current_item_name){

    //                        case "发动机转速":  var cmp_item2 = Qt.createComponent( "qrc:/Qml_widget/SimpleMessageBox.qml" );
    //                                          popup_select = cmp_item2.createObject( switch_area,
    //                                                                                {
    //                                                                                 "list_width" : 500,
    //                                                                                 "title"      :"当前项已在首页显示，是否替换？",
    //                                                                                 "right_tail" :"否",
    //                                                                                 "left_tail"  :"是"
    //                                                                                });
    //                                          popup_select.left_tail_clicked.connect(  yes_slot );
    //                                          popup_select.right_tail_clicked.connect( no_slot  ); break;



                            case "发动机档位": gears_btn.picked = !gears_btn.picked;  //break;
                                             select_gear_flag = !select_gear_flag; break;  //同步修改 保存是否勾选的标志位，防止下次进入时未取消勾选

                            case "发动机温度": temp_btn.picked = !temp_btn.picked;  // break;
                                             select_temp_flag = !select_temp_flag; break;

                            case "油量": var cmp_oil = Qt.createComponent( "qrc:/Page_data_vehicle.qml" ) //创建组件
                                        var vehicle_page_oil = cmp_oil.createObject( switch_area )  //创建对象

                                        vehicle_page_oil.oil_state = !vehicle_page_oil.oil_state    //取消勾选状态
                                        select_oil_flag = !select_oil_flag;  //标志位也同步改变，防止下次进入时由于标志位未清零而强行改变勾选状态

                                        vehicle_page_oil.destroy(); break;   //操作完成后，需要进行销毁释放

                            case "续航": var cmp_odom = Qt.createComponent( "qrc:/Page_data_vehicle.qml" )
                                        var vehicle_page_odom = cmp_odom.createObject( switch_area )

                                        vehicle_page_odom.odom_state = !vehicle_page_odom.odom_state
                                        select_odom_flag = !select_odom_flag;

                                        vehicle_page_odom.destroy(); break;

                            case "速度": var cmp_speed = Qt.createComponent( "qrc:/Page_data_vehicle.qml" )
                                        var vehicle_page_speed = cmp_speed.createObject( switch_area )

                                        vehicle_page_speed.speed_state = !vehicle_page_speed.speed_state
                                        select_speed_flag = !select_speed_flag;

                                        vehicle_page_speed.destroy(); break;
                        }

                        replace_flag = false  //恢复 替换按钮 的标志位
                    }

                    else{             //进入添加功能
                        param_list_model.append({name: "发动机转速",  value: data_rpm_cache, unit: "rpm"})

                        count_num = count_num + 1      //插入列表中的 行号，新插入的内容放在末尾
                        rpm_row_position = count_num   //插入的位置
                        console.log(rpm_row_position)
                    }

    //                rpm_row_position = param_list_model.count - 1
    //                console.log(rpm_row_position)
                }
                else  //未选中则删除
                {
                    delete_rpm()
                }

                select_rpm() //发起选择的信号
            }
        }
    }

    //选择按钮_档位
    SimpleButton{
        id: gears_btn
        x: 24
        y: 200
        icon: "qrc:/icons/rect_empty.png"
        picked_icon: "qrc:/icons/rect_select.png"

        picked: select_gear_flag

        onSimpleButtonClicked: {          

            picked = !picked   //切换选中与未选中的图片标志位

            if(picked)         //勾选后向列表中替换/增加内容
            {
                if(replace_flag){   //进入替换功能

                    /*** 替换逻辑：删除原内容->原位置插入新内容->修改新内容对应的刷新位置->取消原勾选项->清除替换按钮的标志位 ***/
                    param_list_model.remove( current_item_row )  //删除 Page_main.qml中当前行的内容

                    param_list_model.insert( current_item_row, {name: "发动机档位",  value: data_gear_cache, unit: "gear"}) //插入新的内容

                    gear_row_position = current_item_row  //设置 新内容 的 刷新位置 为原位置，很重要！否则替换后无法刷新 数据

                    //取消当前行的 勾选属性
                    switch(current_item_name){
                        case "发动机转速": rpm_btn.picked = !rpm_btn.picked;
                                         select_rpm_flag = !select_rpm_flag; break;

                        case "发动机温度": temp_btn.picked = !temp_btn.picked;
                                         select_temp_flag = !select_temp_flag; break;

                        case "油量": var cmp_oil = Qt.createComponent( "qrc:/Page_data_vehicle.qml" ) //创建组件
                                    var vehicle_page_oil = cmp_oil.createObject( switch_area )  //创建对象

                                    vehicle_page_oil.oil_state = !vehicle_page_oil.oil_state    //取消勾选状态
                                    select_oil_flag = !select_oil_flag;  //标志位也同步改变，防止下次进入时由于标志位未清零而强行改变勾选状态

                                    vehicle_page_oil.destroy(); break;   //操作完成后，需要进行销毁释放

                        case "续航": var cmp_odom = Qt.createComponent( "qrc:/Page_data_vehicle.qml" )
                                    var vehicle_page_odom = cmp_odom.createObject( switch_area )

                                    vehicle_page_odom.odom_state = !vehicle_page_odom.odom_state
                                    select_odom_flag = !select_odom_flag;

                                    vehicle_page_odom.destroy(); break;

                        case "速度": var cmp_speed = Qt.createComponent( "qrc:/Page_data_vehicle.qml" )
                                    var vehicle_page_speed = cmp_speed.createObject( switch_area )

                                    vehicle_page_speed.speed_state = !vehicle_page_speed.speed_state
                                    select_speed_flag = !select_speed_flag;

                                    vehicle_page_speed.destroy(); break;
                    }

                    replace_flag = false  //恢复 替换按钮 的标志位
                }

                else{       //进入添加功能

                    param_list_model.append({name: "发动机档位",  value: data_gear_cache, unit: "gear"})

                    count_num = count_num + 1
                    gear_row_position = count_num
                    console.log(gear_row_position)
                }

            }
            else
            {
                delete_gear()
            }

            select_gear()
        }
    }

    //选择按钮_温度
    SimpleButton{
        id: temp_btn
        x: 24
        y: 286
        icon: "qrc:/icons/rect_empty.png"
        picked_icon: "qrc:/icons/rect_select.png"

        picked: select_temp_flag

        onSimpleButtonClicked: {

            picked = !picked   //切换选中与未选中的图片标志位

            if(picked)         //勾选后向列表中 替换/增加内容
            {
                if(replace_flag){   //进入替换功能

                    /*** 替换逻辑：删除原内容->原位置插入新内容->修改新内容对应的刷新位置->取消原勾选项->清除替换按钮的标志位 ***/
                    param_list_model.remove( current_item_row )  //删除 Page_main.qml中当前行的内容

                    param_list_model.insert( current_item_row, {name: "发动机温度",  value: data_temp_cache, unit: "℃"}) //插入新的内容

                    temp_row_position = current_item_row  //设置 新内容 的 刷新位置 为原位置，很重要！否则替换后无法刷新 数据

                    //取消当前行原有的 勾选属性
                    switch(current_item_name){
                        case "发动机转速": rpm_btn.picked = !rpm_btn.picked;
                                         select_rpm_flag = !select_rpm_flag;   break;

                        case "发动机档位": gears_btn.picked = !gears_btn.picked;
                                         select_gear_flag = !select_gear_flag; break;

                        case "油量": var cmp_oil = Qt.createComponent( "qrc:/Page_data_vehicle.qml" ) //创建组件
                                    var vehicle_page_oil = cmp_oil.createObject( switch_area )  //创建对象

                                    vehicle_page_oil.oil_state = !vehicle_page_oil.oil_state    //取消勾选状态
                                    select_oil_flag = !select_oil_flag;  //标志位也同步改变，防止下次进入时由于标志位未清零而强行改变勾选状态

                                    vehicle_page_oil.destroy(); break;   //操作完成后，需要进行销毁释放

                        case "续航": var cmp_odom = Qt.createComponent( "qrc:/Page_data_vehicle.qml" )
                                    var vehicle_page_odom = cmp_odom.createObject( switch_area )

                                    vehicle_page_odom.odom_state = !vehicle_page_odom.odom_state
                                    select_odom_flag = !select_odom_flag;

                                    vehicle_page_odom.destroy(); break;

                        case "速度": var cmp_speed = Qt.createComponent( "qrc:/Page_data_vehicle.qml" )
                                    var vehicle_page_speed = cmp_speed.createObject( switch_area )

                                    vehicle_page_speed.speed_state = !vehicle_page_speed.speed_state
                                    select_speed_flag = !select_speed_flag;

                                    vehicle_page_speed.destroy(); break;
                    }

                    replace_flag = false  //恢复 替换按钮 的标志位
                }

                else{      //添加新内容
                    param_list_model.append({name: "发动机温度",  value: data_temp_cache, unit: "℃"})

                    count_num = count_num + 1
                    temp_row_position = count_num
                    console.log(temp_row_position)
                }

            }
            else
            {
                delete_temp()
            }

            select_temp()
        }
    }


    //定时_刷新显示发动机的相关数据
    Timer{
        id: timer_display_engine_data
        interval: 100
        repeat: true
        running: true

        onTriggered: {
            param_list_model_engine_data.setProperty(0, "data_value", data_rpm_cache)
            param_list_model_engine_data.setProperty(1, "data_value", data_gear_cache)
            param_list_model_engine_data.setProperty(2, "data_value", data_temp_cache)
        }
    }

    //槽函数区域_用于将选择结果传递出去
    onSelect_rpm: {
        select_rpm_flag = !select_rpm_flag
    }

    onSelect_gear: {
        select_gear_flag = !select_gear_flag
    }

    onSelect_temp: {
        select_temp_flag = !select_temp_flag
    }

    //删除 勾选的发动机转速
    function delete_rpm()
    {
        param_list_model.remove(rpm_row_position)  //移除当前项
        count_num = count_num - 1     //列表中的数据项 计数减1

        if(gear_row_position > rpm_row_position){  //判断用于将移除项后面的数据前移，确保索引不超出范围
            gear_row_position = gear_row_position - 1
        }

        if(temp_row_position > rpm_row_position){
            temp_row_position = temp_row_position - 1
        }

        if(oil_row_position > rpm_row_position){
            oil_row_position = oil_row_position - 1
        }

        if(odom_row_position > rpm_row_position){
            odom_row_position = odom_row_position - 1
        }

        if(speed_row_position > rpm_row_position){
            speed_row_position = speed_row_position - 1
        }
    }

    //删除 勾选的发动机档位
    function delete_gear()
    {
        param_list_model.remove(gear_row_position)
        count_num = count_num - 1

        if(rpm_row_position > gear_row_position){
            rpm_row_position = rpm_row_position - 1
        }

        if(temp_row_position > gear_row_position){
            temp_row_position = temp_row_position - 1
        }

        if(oil_row_position > gear_row_position){
            oil_row_position = oil_row_position - 1
        }

        if(odom_row_position > gear_row_position){
            odom_row_position = odom_row_position - 1
        }

        if(speed_row_position > gear_row_position){
            speed_row_position = speed_row_position - 1
        }
    }

    //删除 勾选的发动机温度
    function delete_temp()
    {
        param_list_model.remove(temp_row_position)
        count_num = count_num - 1

        if(rpm_row_position > temp_row_position){
            rpm_row_position = rpm_row_position - 1
        }

        if(gear_row_position > temp_row_position){
            gear_row_position = gear_row_position - 1
        }

        if(oil_row_position > temp_row_position){
            oil_row_position = oil_row_position - 1
        }

        if(odom_row_position > temp_row_position){
            odom_row_position = odom_row_position - 1
        }

        if(speed_row_position > temp_row_position){
            speed_row_position = speed_row_position - 1
        }
    }

    //确认重复添加  "转速" 的槽函数
    function readd_rpm_slot(){

        /*** 替换逻辑：删除原内容->原位置插入新内容->修改新内容对应的刷新位置->取消原勾选项->清除替换按钮的标志位 ***/
        param_list_model.remove( current_item_row )  //删除 Page_main.qml中当前行的内容

        param_list_model.insert( current_item_row, {name: "发动机转速",  value: data_rpm_cache, unit: "rpm"}) //插入新的内容

        rpm_row_position = current_item_row  //设置 新内容 的 刷新位置 为原位置，很重要！否则替换后无法刷新 数据

        //取消当前行的 勾选属性
        switch(current_item_name){

            case "发动机档位": gears_btn.picked = !gears_btn.picked;  //break;
                             select_gear_flag = !select_gear_flag; break;  //同步修改 保存是否勾选的标志位，防止下次进入时未取消勾选

            case "发动机温度": temp_btn.picked = !temp_btn.picked;  // break;
                             select_temp_flag = !select_temp_flag; break;

            case "油量": var cmp_oil = Qt.createComponent( "qrc:/Page_data_vehicle.qml" ) //创建组件
                        var vehicle_page_oil = cmp_oil.createObject( switch_area )  //创建对象

                        vehicle_page_oil.oil_state = !vehicle_page_oil.oil_state    //取消勾选状态
                        select_oil_flag = !select_oil_flag;  //标志位也同步改变，防止下次进入时由于标志位未清零而强行改变勾选状态

                        vehicle_page_oil.destroy(); break;   //操作完成后，需要进行销毁释放

            case "续航": var cmp_odom = Qt.createComponent( "qrc:/Page_data_vehicle.qml" )
                        var vehicle_page_odom = cmp_odom.createObject( switch_area )

                        vehicle_page_odom.odom_state = !vehicle_page_odom.odom_state
                        select_odom_flag = !select_odom_flag;

                        vehicle_page_odom.destroy(); break;

            case "速度": var cmp_speed = Qt.createComponent( "qrc:/Page_data_vehicle.qml" )
                        var vehicle_page_speed = cmp_speed.createObject( switch_area )

                        vehicle_page_speed.speed_state = !vehicle_page_speed.speed_state
                        select_speed_flag = !select_speed_flag;

                        vehicle_page_speed.destroy(); break;
        }

        replace_flag = false  //恢复 替换按钮 的标志位

        popup_select.destroy()  //选择完成后，销毁提示框
    }

    //确认重复添加  "档位" 的槽函数
    function readd_gear_slot(){

        /*** 替换逻辑：删除原内容->原位置插入新内容->修改新内容对应的刷新位置->取消原勾选项->清除替换按钮的标志位 ***/
        param_list_model.remove( current_item_row )  //删除 Page_main.qml中当前行的内容

        param_list_model.insert( current_item_row, {name: "发动机档位",  value: data_gear_cache, unit: "gear"}) //插入新的内容

        gear_row_position = current_item_row  //设置 新内容 的 刷新位置 为原位置，很重要！否则替换后无法刷新 数据

        //由于是重复添加，不必取消当前行的勾选

        replace_flag = false  //恢复 替换按钮 的标志位

        popup_select.destroy()  //选择完成后，销毁提示框
    }

    //取消重复添加的槽函数
    function cancel_slot(){

        popup_select.destroy()  //选择完成后，销毁提示框
    }
}

