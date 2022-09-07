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
    
    @State var status: Int = 1                      //４段階の状態を表す変数を追加
//    1:ReadyCount中
//    2:TrainingCount中
//    3:IntervalCount中
//    4:終了処理

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

    //switch caseでやってみよう
    
    switch status{

    case 1: //開始前カウントダウン
        readyTimeRemaining -= 1
        if readyTimeRemaining < 1{
            status = 2
        }
    case 2: //トレーニングカウントダウン中
        trainingTimeRemaining -= 1
        if trainingTimeRemaining < 1{
            status = 3
        }
    case 3: //インターバルカウントダウン中
        intervalTimeRemaining -= 1
        if intervalTimeRemaining < 1{ //インターバルタイマーが0ならトレーニングカウントダウン中に戻る
            timesCountRemaining -= 1
            trainingTimeRemaining = trainingTime
            intervalTimeRemaining = intervalTime
            status = 2
            if timesCountRemaining < 1{ //回数が0ならセット数を減らす
                setCountRemaining -= 1
                timesCountRemaining = timesCount
                status = 2
                if setCountRemaining < 1{ //セット数が0なら終了処理へ
                    status = 4
                }
            }
        }
    case 4: //タイマー終了処理
            timerReset()
            start = false
            timer?.invalidate()
            status = 1
    default:
        break
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
