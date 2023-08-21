import QtQuick 2.0

Item {
    id: data_source

    property bool start: false  //启动标志位

    property int rpm:   0  //发动机转速
    property int temp:  0  //发动机温度
    property int gear:  0  //发动机档位

    property int oil:   0  //油量
    property int odom:  0  //续航
    property int speed: 0  //速度


    //根据转速计算档位
    function get_gear(){
        if( rpm == 0)
        {
            return 0
        }
        if( rpm <= 1000)
        {
            return 1
        }
        if( rpm <= 2000)
        {
            return 2
        }
        if( rpm <= 3000)
        {
            return 3
        }
        if( rpm <= 4000)
        {
            return 4
        }
        if( rpm <= 5000)
        {
            return 5
        }

    }

    //定时器用于不停的根据转速值刷新档位
    Timer{
        id: timer_caculate_gear

        interval: 100
        repeat: true
        running: true

        onTriggered: {
            gear = get_gear()
        }
    }

    //动画列表：首先串行动画执行一次用于开启数值变化的服务，第二个串行动画无限循环并且嵌套并行动画
    SequentialAnimation{     //第一个串行动画
        running: true
        loops: 1            //只执行1次

        PauseAnimation{
            duration: 1500  //开始前，暂停 1.5秒
        }

        PropertyAction{
            target: data_source
            property: "start"
            value: true      //启动
        }

        SequentialAnimation{  //第二个串行动画
            loops: Animation.Infinite  //无限循环

            // 0->1档
            ParallelAnimation{
                NumberAnimation{
                    target: data_source
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    from: 0
                    to: 1000
                    duration: 5000
                }

                NumberAnimation{
                    target: data_source
                    property: "temp"
                    easing.type: Easing.InOutSine
                    from: 25
                    to: 55
                    duration: 5000
                }

                NumberAnimation{
                    target: data_source
                    property: "oil"
                    easing.type: Easing.InOutSine
                    from: 100
                    to: 90
                    duration: 5000
                }

                NumberAnimation{
                    target: data_source
                    property: "odom"
                    easing.type: Easing.InOutSine
                    from: 500
                    to: 480
                    duration: 5000
                }

                NumberAnimation{
                    target: data_source
                    property: "speed"
                    easing.type: Easing.InOutSine
                    from: 0
                    to: 20
                    duration: 5000
                }
            }

            // 缓冲
            ParallelAnimation{
                NumberAnimation{
                    target: data_source
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 800
                    duration: 1000
                }
            }

            // 1->2档
            ParallelAnimation{
                NumberAnimation{
                    target: data_source
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 2000
                    duration: 5000
                }

                NumberAnimation{
                    target: data_source
                    property: "temp"
                    easing.type: Easing.InOutSine
                    to: 75
                    duration: 5000
                }


                NumberAnimation{
                    target: data_source
                    property: "oil"
                    easing.type: Easing.InOutSine
                    to: 80
                    duration: 5000
                }

                NumberAnimation{
                    target: data_source
                    property: "odom"
                    easing.type: Easing.InOutSine
                    to: 460
                    duration: 5000
                }

                NumberAnimation{
                    target: data_source
                    property: "speed"
                    easing.type: Easing.InOutSine
                    to: 40
                    duration: 5000
                }
            }

            // 缓冲
            ParallelAnimation{
                NumberAnimation{
                    target: data_source
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 1800
                    duration: 1000
                }
            }

            // 2->3档
            ParallelAnimation{
                NumberAnimation{
                    target: data_source
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 3000
                    duration: 5000
                }

                NumberAnimation{
                    target: data_source
                    property: "temp"
                    easing.type: Easing.InOutSine
                    to: 95
                    duration: 5000
                }


                NumberAnimation{
                    target: data_source
                    property: "oil"
                    easing.type: Easing.InOutSine
                    to: 60
                    duration: 5000
                }

                NumberAnimation{
                    target: data_source
                    property: "odom"
                    easing.type: Easing.InOutSine
                    to: 440
                    duration: 5000
                }

                NumberAnimation{
                    target: data_source
                    property: "speed"
                    easing.type: Easing.InOutSine
                    to: 60
                    duration: 5000
                }
            }

            // 缓冲
            ParallelAnimation{
                NumberAnimation{
                    target: data_source
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 2800
                    duration: 1000
                }
            }

            // 3->4档
            ParallelAnimation{
                NumberAnimation{
                    target: data_source
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 4000
                    duration: 5000
                }

                NumberAnimation{
                    target: data_source
                    property: "temp"
                    easing.type: Easing.InOutSine
                    to: 110
                    duration: 5000
                }


                NumberAnimation{
                    target: data_source
                    property: "oil"
                    easing.type: Easing.InOutSine
                    to: 40
                    duration: 5000
                }

                NumberAnimation{
                    target: data_source
                    property: "odom"
                    easing.type: Easing.InOutSine
                    to: 420
                    duration: 5000
                }

                NumberAnimation{
                    target: data_source
                    property: "speed"
                    easing.type: Easing.InOutSine
                    to: 80
                    duration: 5000
                }
            }

            // 缓冲
            ParallelAnimation{
                NumberAnimation{
                    target: data_source
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 3800
                    duration: 1000
                }
            }

            // 4->5档
            ParallelAnimation{
                NumberAnimation{
                    target: data_source
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 5000
                    duration: 5000
                }

                NumberAnimation{
                    target: data_source
                    property: "temp"
                    easing.type: Easing.InOutSine
                    to: 120
                    duration: 5000
                }


                NumberAnimation{
                    target: data_source
                    property: "oil"
                    easing.type: Easing.InOutSine
                    to: 20
                    duration: 5000
                }

                NumberAnimation{
                    target: data_source
                    property: "odom"
                    easing.type: Easing.InOutSine
                    to: 400
                    duration: 5000
                }

                NumberAnimation{
                    target: data_source
                    property: "speed"
                    easing.type: Easing.InOutSine
                    to: 100
                    duration: 5000
                }
            }

            //完成一个流程后暂停 2秒
            PauseAnimation{
                duration: 2000
            }
        }
    }
}
