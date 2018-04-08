//
//  Guess1A2BViewController.swift
//  DemoNumberGame
//
//  Created by Chao Shin on 2018/4/8.
//  Copyright © 2018 Chao Shin. All rights reserved.
//

import UIKit
import GameplayKit

class Guess1A2BViewController: UIViewController {
    @IBOutlet weak var userInuptTextField: UITextField!
    @IBOutlet weak var lastChanceLabel: UILabel!
    @IBOutlet weak var ansTextView: UITextView!
    @IBOutlet weak var resultTextView: UITextView!
    
    var ansNumber = ["", "", "", ""]
    var lastChanceNumber = 10
    var historyCount = 0
    var ansHistory:String = ""
    var resultHistory:String = ""
    
    func showAlertMessage(title: String, message: String) {
        let inputErrorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert) //產生AlertController
        let okAction = UIAlertAction(title: "確認", style: .default, handler: nil) // 產生確認按鍵
        inputErrorAlert.addAction(okAction) // 將確認按鍵加入AlertController
        self.present(inputErrorAlert, animated: true, completion: nil) // 顯示Alert
    }
    
    func getRandomAns() {
        let randomDistribution = GKShuffledDistribution(lowestValue: 0, highestValue: 9)
        for num in 0...3 {
            ansNumber[num] = "\(randomDistribution.nextInt())"  // 將電腦提供的亂數是Int，轉成String後存入Array
        }
        print("電腦亂數給出\(ansNumber)")        
    }
    
    func resetGame(){
        userInuptTextField.text = "" // 清除使用者的輸入
        lastChanceNumber = 10 // 回復為10次機會
        lastChanceLabel.text = "\(lastChanceNumber)" // 顯示剩餘可以猜的次數
        lastChanceLabel.textColor = .black //回復文字顯示成黑色
        ansHistory = "" // 清除使用者輸入紀錄
        ansTextView.text = "" // 清除View顯示的使用者輸入紀錄
        ansTextView.isHidden = true // 隱藏使用者輸入區塊
        resultHistory = "" //清除猜測結果紀錄
        resultTextView.text = "" //清除View顯示的猜測結果紀錄
        resultTextView.isHidden = true  // 隱藏猜測結果區塊
        getRandomAns() // 取出電腦亂數提供的數字
        
    }
    
    func gameOver() {
        showAlertMessage(title: "遊戲結束", message: "答案是\(ansNumber[0])\(ansNumber[1])\(ansNumber[2])\(ansNumber[3])")
        resetGame() // 回復初始畫面
        getRandomAns() // 取出電腦亂數提供的數字
    }
    
    func checkUserInput() {
        if let userInput = userInuptTextField.text {
            if userInput.count == 4 { // 確認是否輸入4個字
                var ansA = 0
                var ansB = 0
                var time = 0
                lastChanceNumber -= 1
                lastChanceLabel.text = "\(lastChanceNumber)" // 顯示剩餘可以猜的次數
                for charNumber in userInput{
                    let number = String(charNumber)
                    if ansNumber[time] == number { // 確認數字是否在正確位置
                        ansA += 1
                    }else if ansNumber.contains(number) { // 確認數字是否在電腦提供的數字內，但位置不正確
                        ansB += 1
                    }else {
                        // 數字都不在電腦提供的數字內，所以不處理
                    }
                    time += 1
                }
                if ansA == 4{
                    showAlertMessage(title: "遊戲結束", message: "厲害你答對了!就是\(userInput)")
                    resetGame() // 回復初始畫面
                }else {
                    if lastChanceNumber == 0 { // 猜10都錯就結束遊戲
                        gameOver()
                    }else {
                        userInuptTextField.text = "" // 清除使用者的輸入
                        ansHistory = userInput + ansHistory
                        ansTextView.text = ansHistory  // 顯示使用者輸入的數值
                        ansTextView.isHidden = false
                        resultHistory = "\(ansA)A\(ansB)B" + resultHistory
                        resultTextView.text = resultHistory // 顯示猜測結果
                        resultTextView.isHidden = false
                        if lastChanceNumber <= 3 {
                            lastChanceLabel.textColor = .red
                        }
                    }
                }
            }else {
                showAlertMessage(title: "輸入錯誤", message: "請輸入4個不同數字")
            }
        }else {
            showAlertMessage(title: "輸入錯誤", message: "請輸入4個不同數字")
        }
    }
    
    
    @IBAction func tapViewPress(_ sender: Any) { // 使用者按畫⾯空⽩地方時收鍵盤
        view.endEditing(true)   // 收鍵盤
    }
    
    @IBAction func userGuessPress(_ sender: Any) {
        checkUserInput()
        view.endEditing(true)   // 收鍵盤
    }
    @IBAction func restGamePress(_ sender: Any) {
        resetGame()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getRandomAns() // 取出電腦亂數提供的數字
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
