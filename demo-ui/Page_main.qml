import QtQuick 2.7
import QtQuick.Window 2.2

import QtQuick.Controls 1.4

import QtQml 2.12

import "./Qml_widget"

Window {

    id: root_page

    visible: true
    width: 640
    height: 880
    title: "Task2_demo"
    color: "black"

    //保存读取到的数据至变量中
    property int data_rpm_cache:  0
    property int data_gear_cache: 0
    property int data_temp_cache: 0

    property int data_oil_cache:   0
    property int data_odom_cache:  0
    property int data_speed_cache: 0

    //子菜单中，六个按钮点击的标志
    property bool select_rpm_flag:  false
    property bool select_gear_flag: false
    property bool select_temp_flag: false

    property bool select_oil_flag:  false
    property bool select_odom_flag: false
    property bool select_speed_flag: false

    //静态绑定 数据在表中第几行
    property int rpm_row_position:   0
    property int gear_row_position:  0
    property int temp_row_position:  0

    property int oil_row_position:   0
    property int odom_row_position:  0
    property int speed_row_position: 0

    //计数器：用于计数 点击插入列表的行数
    property int count_num: -1

    //操作提示框，将其声明为全局变量，便于销毁
    property var popup_select: null

    //保存点击的 行名称 与 行号
    property var current_item_name: null
    property int current_item_row:  0

    //点击 替换按钮的标志位
    property bool replace_flag: false

    //数据源
    Data_source{
        id: data_source
    }

    //需要显示的第一界面——可进行压栈进行切换
    Component{
        id: first_page
        //列表
        Item {
            id: first_page_container
            width: 640
            height: 880

            //标题
            Title_row{
                id: title_row
                width: parent.width
                height: 80

                anchors.top:parent.top
                text: "界面1_数据展示"
            }


            //列表
            ListView{
                id:my_list
                width:  first_page_container.width
                height: first_page_container.height
                anchors.top: title_row.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 5
                model: param_list_model  //列表的数据源
                clip: true //剪切其自身的绘制以及其子项目的绘制，使之与项目的边界矩形一致

                keyNavigationWraps :true   //导航循环包裹list，不会到边缘就跳出

                highlightMoveDuration: 10   //设定高亮代理的移动速度，实质上是指切换动作的速度；暂时找到Value与每秒切换像素点数量的关系，value = 10效果良好。
                highlightFollowsCurrentItem: true

                delegate:Item{  //定义子项的格式
                    id:item_dlg
                    width: first_page_container.width
                    height: 80
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            if( index === 0 )   //第 0 行
                            {
//                                console.log("Clicked on:", model.name, model.value) //获取当前子项的内容
                                current_item_row = index
                                //获取当前项的名称
                                current_item_name = model.name
                                console.log(current_item_name)

                                //弹出提示框
                                var cmp_item0 = Qt.createComponent( "qrc:/Qml_widget/SimpleMessageBox.qml" )  //创建组件——提示框
                                popup_select = cmp_item0.createObject( switch_area )  //创建对象

                                popup_select.left_tail_clicked.connect( left_clicked_slot )    //链接 左键的槽函数，实现 替换功能
                                popup_select.right_tail_clicked.connect( right_clicked_slot )  //链接 右键的槽函数，实现 删除功能
                            }
                            else if( index === 1 )  //第 1 行
                            {
                                current_item_row = index

                                current_item_name = model.name
                                console.log(current_item_name)

                                //弹出提示框
                                var cmp_item1 = Qt.createComponent( "qrc:/Qml_widget/SimpleMessageBox.qml" )
                                popup_select = cmp_item1.createObject( switch_area )

                                popup_select.left_tail_clicked.connect( left_clicked_slot )
                                popup_select.right_tail_clicked.connect( right_clicked_slot )
                            }
                            else if( index === 2 )  //第 2 行
                            {
                                current_item_row = index

                                current_item_name = model.name
                                console.log(current_item_name)

                                //弹出提示框
                                var cmp_item2 = Qt.createComponent( "qrc:/Qml_widget/SimpleMessageBox.qml" )
                                popup_select = cmp_item2.createObject( switch_area )

                                popup_select.left_tail_clicked.connect( left_clicked_slot )
                                popup_select.right_tail_clicked.connect( right_clicked_slot )
                            }
                            else if( index === 3 )  //第 3 行
                            {
                                current_item_row = index

                                current_item_name = model.name
                                console.log(current_item_name)

                                //弹出提示框
                                var cmp_item3 = Qt.createComponent( "qrc:/Qml_widget/SimpleMessageBox.qml" )
                                popup_select = cmp_item3.createObject( switch_area )

                                popup_select.left_tail_clicked.connect( left_clicked_slot )
                                popup_select.right_tail_clicked.connect( right_clicked_slot )
                            }
                            else if( index === 4 )  //第 4 行
                            {
                                current_item_row = index

                                current_item_name = model.name
                                console.log(current_item_name)

                                //弹出提示框
                                var cmp_item4 = Qt.createComponent( "qrc:/Qml_widget/SimpleMessageBox.qml" )
                                popup_select = cmp_item4.createObject( switch_area )

                                popup_select.left_tail_clicked.connect( left_clicked_slot )
                                popup_select.right_tail_clicked.connect( right_clicked_slot )
                            }
                            else if( index === 5 )  //第 5 行
                            {
                                current_item_row = index

                                current_item_name = model.name
                                console.log(current_item_name)

                                //弹出提示框
                                var cmp_item5 = Qt.createComponent( "qrc:/Qml_widget/SimpleMessageBox.qml" )
                                popup_select = cmp_item5.createObject( switch_area )

                                popup_select.left_tail_clicked.connect( left_clicked_slot )
                                popup_select.right_tail_clicked.connect( right_clicked_slot )
                            }

                        }
                    }
                    /// 左字符串,项目名称
                    Text{
                        id:left_txt
                        text: name

                        anchors.left: parent.left
                        anchors.leftMargin: 30
                        anchors.verticalCenter: parent.verticalCenter
                        horizontalAlignment  : Text.AlignLeft
                        verticalAlignment:Text.AlignVCenter
                        width: 300
                        height: 35
                        font.pixelSize: 35
                        color: "#D6CDB6"
                    }
                    /// 右字符串,项目值
                    Text{
                        id:right_txt_value
                        text: value

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

                    /// 单位
                    Text{
                        id:right_txt_unit
                        text: unit

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
                        anchors.left: left_txt.left
                        anchors.right: right_txt_unit.right
                        anchors.bottom: parent.bottom
                        color: "#D6CDB6"
                        opacity: 0.4
                    }
                }
            }

            //按键区域
            Rectangle{
                id: btn_container

                width: first_page_container.width
                height: 100
                color: "black"

                anchors.bottom: first_page_container.bottom
                anchors.bottomMargin: 20

                //选择数据
                Str_button{
                    id: select_data_btn

                    width: 191
                    height: 50

                    anchors.bottom: btn_container.bottom
                    anchors.bottomMargin: 20
                    anchors.left: btn_container.left
                    anchors.leftMargin: 20

                    str_size: 35
                    btn_str: "选择数据"
                    onBtnclicked: {
                        root_stack.push({item:"qrc:/Page_middleware.qml", Immediate:true, destroyOnPop:true});
                   }
                }

                //关闭界面
                Str_button{
                    id: close_page_btn

                    width: 191
                    height: 50

                    anchors.bottom: btn_container.bottom
                    anchors.bottomMargin: 20
                    anchors.right: btn_container.right
                    anchors.rightMargin: 20

                    str_size: 35
                    btn_str: "关闭页面"
                    onBtnclicked: {
                        root_page.close()
                   }
                }
            }
        }
    }

    //堆栈视图
    Item {
        id: switch_area
        width: 640
        height: 880
        StackView {  //用于管理页面堆栈的容器。它允许将多个页面组织成一个堆栈，并在需要时切换显示不同的页面
            id: root_stack
            anchors.fill: parent
            visible: true
            initialItem: first_page         //用于指定初始页面
            delegate: StackViewDelegate {}  //推送或弹出项目时使用的过渡效果
        }
//        Rectangle{
//            width: 640
//            height: 880
//            anchors.fill: parent
//            opacity: 0.2
//            color: "black"
//        }
//        Rectangle{
//            width: 640
//            height: 880
//            anchors.fill: parent
////            opacity: 0.2
//            color: "red"
//        }



    }

    //列表数据
    ListModel {

        id: param_list_model

    }

    //定时_用于获取数据
    Timer{
        id: timer_get_data
        interval: 100
        repeat: true
        running: true

        onTriggered: {
            data_rpm_cache  = data_source.rpm
            data_gear_cache = data_source.gear
            data_temp_cache = data_source.temp

            data_oil_cache   = data_source.oil
            data_odom_cache  = data_source.odom
            data_speed_cache = data_source.speed
        }
    }

    //定时_用于刷新表格显示
    Timer{
        id: timer_display_data
        interval: 100
        repeat: true
        running: true

        onTriggered: {
            //刷新展示_发动机数据
            if( select_rpm_flag == true ){
                 param_list_model.setProperty(rpm_row_position, "value", data_rpm_cache)
            }
            if( select_gear_flag == true ){
                 param_list_model.setProperty(gear_row_position, "value", data_gear_cache)
            }
            if( select_temp_flag == true ){
                 param_list_model.setProperty(temp_row_position, "value", data_temp_cache)
            }
            //刷新展示_车辆数据
            if( select_oil_flag == true ){
                 param_list_model.setProperty(oil_row_position, "value", data_oil_cache)
            }
            if( select_odom_flag == true ){
                 param_list_model.setProperty(odom_row_position, "value", data_odom_cache)
            }
            if( select_speed_flag == true ){
                 param_list_model.setProperty(speed_row_position, "value", data_speed_cache)
            }
        }
    }

    //槽函数区：提示框的左按钮——替换
    function left_clicked_slot()
    {
        replace_flag = true     //树立替换按钮的 标志位

        root_stack.push({item:"qrc:/Page_middleware.qml", Immediate:true, destroyOnPop:true})  //跳转至中间层

        popup_select.destroy()  //选择完成后，销毁提示框
    }

    //槽函数区：提示框的右按钮——删除
    function right_clicked_slot()
    {
        if( current_item_name == "发动机转速"){
            var cmp_rpm = Qt.createComponent( "qrc:/Page_data_engine.qml" )  //创建组件——用于调用其他qml文件中的函数
            var engine_page_rpm = cmp_rpm.createObject( switch_area )        //创建对象

            engine_page_rpm.rpm_state = !engine_page_rpm.rpm_state  //按钮的状态取反
            select_rpm_flag = engine_page_rpm.rpm_state             //刷新当前的按钮状态
            engine_page_rpm.delete_rpm()   //调用删除函数，删除当前项

            engine_page_rpm.destroy()      //销毁创建的对象
        }
        else if( current_item_name == "发动机档位"){
            var cmp_gears = Qt.createComponent( "qrc:/Page_data_engine.qml" )
            var engine_page_gears = cmp_gears.createObject( switch_area )

            engine_page_gears.gear_state = !engine_page_gears.gear_state
            select_gear_flag = engine_page_gears.gear_state
            engine_page_gears.delete_gear()

            engine_page_gears.destroy()
        }
        else if( current_item_name == "发动机温度"){
            var cmp_temp = Qt.createComponent( "qrc:/Page_data_engine.qml" )
            var engine_page_temp = cmp_temp.createObject( switch_area )

            engine_page_temp.temp_state = !engine_page_temp.temp_state
            select_temp_flag = engine_page_temp.temp_state
            engine_page_temp.delete_temp()

            engine_page_temp.destroy()
        }
        else if( current_item_name == "油量"){
            var cmp_oil = Qt.createComponent( "qrc:/Page_data_vehicle.qml" )
            var vehicle_page_oil = cmp_oil.createObject( switch_area )

            vehicle_page_oil.oil_state = !vehicle_page_oil.oil_state
            select_oil_flag = vehicle_page_oil.oil_state
            vehicle_page_oil.delete_oil()

            vehicle_page_oil.destroy()
        }
        else if( current_item_name == "续航"){
            var cmp_odom = Qt.createComponent( "qrc:/Page_data_vehicle.qml" )
            var vehicle_page_odom = cmp_odom.createObject( switch_area )

            vehicle_page_odom.odom_state = !vehicle_page_odom.odom_state
            select_odom_flag = vehicle_page_odom.odom_state
            vehicle_page_odom.delete_odom()

            vehicle_page_odom.destroy()
        }
        else if( current_item_name == "速度"){
            var cmp_speed = Qt.createComponent( "qrc:/Page_data_vehicle.qml" )
            var vehicle_page_speed = cmp_speed.createObject( switch_area )

            vehicle_page_speed.speed_state = !vehicle_page_speed.speed_state
            select_speed_flag = vehicle_page_speed.speed_state
            vehicle_page_speed.delete_speed()

            vehicle_page_speed.destroy()
        }

        popup_select.destroy()  //选择完成后，销毁提示框
    }
}
