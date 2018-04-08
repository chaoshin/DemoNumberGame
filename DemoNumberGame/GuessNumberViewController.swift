//
//  GuessNumberViewController.swift
//  DemoNumberGame
//
//  Created by Chao Shin on 2018/4/9.
//  Copyright © 2018 Chao Shin. All rights reserved.
//

import UIKit
import GameplayKit

class GuessNumberViewController: UIViewController {
    @IBOutlet weak var lastChanceLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var guessNumberTextField: UITextField!
    
    var lastChanceNumber = 10
    var ansNumber:Int?
    var maxNumber = 100
    var minNumber = 0
    
    func showAlertMessage(title: String, message: String) {
        let inputErrorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert) //產生AlertController
        let okAction = UIAlertAction(title: "確認", style: .default, handler: nil) // 產生確認按鍵
        inputErrorAlert.addAction(okAction) // 將確認按鍵加入AlertController
        self.present(inputErrorAlert, animated: true, completion: nil) // 顯示Alert
    }
    
    func resetGame(){
        guessNumberTextField.text = "" // 清除使用者的輸入
        lastChanceNumber = 10 // 回復為10次機會
        lastChanceLabel.text = "\(lastChanceNumber)" // 顯示剩餘可以猜的次數
        lastChanceLabel.textColor = .black //回復文字顯示成黑色
        maxNumber = 100 // 回復最大值
        minNumber = 0 // 回復最小值
        rangeLabel.text = "?" // 清除數字範圍回復到?
        getRandomAns() // 取出電腦亂數提供的數字        
    }
    
    func gameOver() {
        if let ans = ansNumber {
            showAlertMessage(title: "遊戲結束", message: "答案是\(ans)")
        }
        resetGame() // 回復初始畫面
        getRandomAns() // 取出電腦亂數提供的數字
    }
    
    func getRandomAns() {
        let randomDistribution = GKShuffledDistribution(lowestValue: 0, highestValue: 100)
        ansNumber = randomDistribution.nextInt()
    }
    
    func checkUserInput() {
        if let numberText = guessNumberTextField.text, let number = Int(numberText), let ans = ansNumber {
            lastChanceNumber -= 1
            lastChanceLabel.text = "\(lastChanceNumber)" // 顯示剩餘可以猜的次數
            if number == ansNumber {
                showAlertMessage(title: "遊戲結束", message: "厲害你答對了!")
                resetGame() // 回復初始畫面
            }else if number > ans {
                maxNumber = number - 1
                rangeLabel.text = "\(minNumber)到\(maxNumber)"
            }else {
                minNumber = number + 1
                rangeLabel.text = "\(minNumber)到\(maxNumber)"
            }
            if lastChanceNumber == 0 { // 猜10都錯就結束遊戲
                gameOver()
            }else {
                guessNumberTextField.text = "" // 清除使用者的輸入
                if lastChanceNumber <= 3 {
                    lastChanceLabel.textColor = .red
                }
            }
        }
    }
    
    @IBAction func tapViewPress(_ sender: Any) { // 使用者按畫⾯空⽩地方時收鍵盤
        view.endEditing(true)   // 收鍵盤
    }
    @IBAction func guessPress(_ sender: Any) {
        checkUserInput()
    }
    @IBAction func resetGamePress(_ sender: Any) {
        resetGame()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getRandomAns()
        
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
