//
//  ViewController.swift
//  Сәйкес пе?
//
//  Created by MacBOOK PRO on 07.06.16.
//  Copyright (c) 2016 Nazarbayev University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var countingLabel: UILabel!
    
    
    
    let colorArray = [UIColor.blueColor(), UIColor.greenColor(), UIColor.redColor(), UIColor.yellowColor()]
    
    let textArray = ["көк", "жасыл", "қызыл", "сары"]
    
    var textIndex: Int!
    var colorIndex: Int!
    var score = 0
    var highScore = 0
    var timer = NSTimer()
    var counter = 20
    var timerIsOn = false
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        showQuestion()
        
        let highScoreDefault = NSUserDefaults.standardUserDefaults()
        if(highScoreDefault.valueForKey("Highscore") != nil) {
            highScore = highScoreDefault.valueForKey("Highscore") as! NSInteger!
            highScoreLabel.text = String(format: "Highscore: %i", highScore)
        }
        
        startTimer()
        
        score = 0
        
        countingLabel.text = String(counter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showQuestion() {
        
        textIndex = returnRandomNumber()
        colorIndex = returnRandomNumber()
        
        textLabel.text = textArray[textIndex]
        textLabel.textColor = colorArray[returnRandomNumber()]
        colorLabel.text = textArray[returnRandomNumber()]
        colorLabel.textColor = colorArray[colorIndex]
        
        clearButtons()
        toggleButtons(true)
    }
    
    func toggleButtons(toggle: Bool) {
        yesButton.userInteractionEnabled = toggle
        noButton.userInteractionEnabled = toggle
    }
    
    func returnRandomNumber() -> Int {
        let random = Int(arc4random_uniform(UInt32(colorArray.count)))
        return random
    }
    
    func clearButtons() {
        yesButton.backgroundColor = UIColor.clearColor()
        noButton.backgroundColor = UIColor.clearColor()
    }
    
    func scoreCorrect() {
        score += 1
        scoreLabel.text = String(format: "Ұпай: %i", score)
        if(score > highScore) {
            highScore = score
            highScoreLabel.text = String(format: " Рекорд: %i", highScore)
            
            let highScoreDefault = NSUserDefaults.standardUserDefaults()
            highScoreDefault.setValue(highScore, forKey: "Highscore")
            highScoreDefault.synchronize()
        }
    }
    
    func scoreIncorrect() {
        //counter = 0
        countingLabel.text = "\(counter)"
        //score = 0
        scoreLabel.text = "Ұпай: \(score)"
        stopTimer()
    }
    
    func startTimer() {
        if timerIsOn == false {
            self.counter =  20
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.updateCounter), userInfo: nil, repeats: true)
            timerIsOn = true
        }
    }
    func stopTimer() {
        timerIsOn = false
        timer.invalidate()
        
        let secondVC = storyboard?.instantiateViewControllerWithIdentifier("secondVC") as! SecondViewController
        secondVC.recievedResult = "Сіз \(score) ұпай жинадыңыз"
        presentViewController(secondVC, animated: true, completion: nil)
    }
    
    func updateCounter() {
        if counter > 0 {
            counter -= 1
            countingLabel.text = String(counter)
        } else {
            stopTimer()
        }
    }
    
    @IBAction func yesButtonPressed(sender: UIButton) {
        //startTimer()
        toggleButtons(false)
        if textIndex == colorIndex {
            sender.backgroundColor = UIColor.greenColor()
            scoreCorrect()
        } else {
            sender.backgroundColor = UIColor.redColor()
            scoreIncorrect()
        }
    }

    @IBAction func noButtonPressed(sender: UIButton) {
        //startTimer()
        toggleButtons(false)
        if textIndex == colorIndex {
            sender.backgroundColor = UIColor.redColor()
            scoreIncorrect()
        } else {
            sender.backgroundColor = UIColor.greenColor()
            scoreCorrect()
        }
    }
    
    @IBAction func nextButtonPressed(sender: UIButton) {
        showQuestion()
    }
    
    
}

