//
//  ContentView.swift
//  TestTimer
//
//  Created by 住田雅隆 on 2022/08/22.
//

import SwiftUI

struct ContentView: View {
    @State var trainingTime: Int = 3
    @State var trainingTimeRemaining: Int = 3
    @State var readyTime: Int = 3
    @State var readyTimeRemaining: Int = 3
    @State var intervalTime: Int = 3
    @State var intervalTimeRemaining: Int = 3
    @State var setCount: Int = 2
    @State var setCountRemaining: Int = 2
    @State var timesCount: Int = 2
    @State var timesCountRemaining: Int = 2
    @State var callCount: Int = 3                   //未使用
    @State var callCountRemaining: Int = 3          //未使用
    @State var timer: Timer?
    @State var start: Bool = false
    @State var readyFlag: Bool = false                   //未使用
    @State var trainingFlag: Bool = false                   //未使用
    @State var intervalFlag: Bool = false                   //未使用

    var body: some View {

        VStack {
            Text("ReadyCount:\(readyTimeRemaining)")
                .padding()
            Text("TrainingCount:\(trainingTimeRemaining)")
                .padding()
            Text("intervalCount:\(intervalTimeRemaining)")
                .padding()
            HStack(spacing: 50) {
                Text("Set:\(setCountRemaining)")
                    .padding()
                Text("Times:\(timesCountRemaining)") //ここの変数を変えた
            }
            .padding()
            HStack(spacing: 50) {
                Button(action: {
                    start.toggle()
                    switch start {
                    case true:
                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                            timerStart()
                        }
                    case false:
                        timer?.invalidate()
                    }

                }) {
                    start ? Text("一時停止") : Text("開始")
                }
                Button(action: {
                    timerReset()
                    timer?.invalidate()

                }) {
                    Text("停止")
                }
            }
        }
    }
    func timerStart() {
        guard start else { return }
//        readyFlag = true
//        if readyTimeRemaining > 0 {
//            readyTimeRemaining -= 1
//        } else if readyTimeRemaining == 0 && trainingTimeRemaining > 0 {
//
//            trainingTimeRemaining -= 1
//        } else if trainingTimeRemaining == 0 && intervalTimeRemaining > 0 {
//            intervalTimeRemaining -= 1
//        }
//        if intervalTimeRemaining == 0 {
//            if timesCountRemaining > 0 {
//                timesCountRemaining -= 1
//            }
//        }

        //以下を丸ごと書き直しました
        
        if readyTimeRemaining > 0{
            readyTimeRemaining -= 1
        }else{
            if setCountRemaining > 0{
                if timesCountRemaining > 0{
                    if trainingTimeRemaining > 0{
                        trainingTimeRemaining -= 1
                    }else if intervalTimeRemaining > 1{
                        intervalTimeRemaining -= 1
                    }else{
                        timesCountRemaining -= 1
                        trainingTimeRemaining = trainingTime
                        intervalTimeRemaining = intervalTime
                        if timesCountRemaining <= 0{
                            setCountRemaining -= 1
                            timesCountRemaining = timesCount
                            if setCountRemaining <= 0 { //ここに終了処理を追加
                                timerReset()
                                start = false
                                timer?.invalidate()
                            }
                        }
                    }
                }
            }
        }
    }
    func timerReset() {
        start = false
//        readyFlag = false                       //未使用
//        trainingFlag = false                       //未使用
//        intervalFlag = false                       //未使用
        readyTimeRemaining = readyTime
        trainingTimeRemaining = trainingTime
        intervalTimeRemaining = intervalTime
        timesCountRemaining = timesCount
        setCountRemaining = setCount
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
