//
//  GameScreenController.swift
//  ThinkFast
//
//  Created by Owen Gregson on 6/8/21.
//

import UIKit
import Lottie
import UIKit.UIGestureRecognizerSubclass
class GameScreenController: UIViewController {
    let formatter = NumberFormatter()
    static var TimeIncrement:Float = 0.0
    @IBOutlet weak var InstructionalText: UILabel!
    @IBOutlet weak var GameTimer: UILabel!
    @IBOutlet weak var subAnim: UILabel!
    
    @IBOutlet weak var confetti: AnimationView!
    var Instruction: String!
    let InstructionsList: [String]=["Swipe down!", "Swipe up!", "Swipe left!", "Swipe right!", "Tap 3 times!", "Tap once!", "Tap twice!", "Shake your phone!"]
    @IBOutlet weak var SubTime: UILabel!
    var tapCount = 0
    var isComplete = false
    var lastPoint = CGPoint.zero
    var colorTimer: Timer!
    var color = UIColor.black
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var hueValue:CGFloat = 0.0
    var swiped = false
    var startX:CGFloat = 365.0
    var startY:CGFloat = 65
    var timer: Timer!
    var startDelay: Timer!
                    // Do any additional setup after loading the view.
    override func viewWillAppear(_ animated: Bool) {
        SubTime.text = "- " + (self.formatter.string(from: NSNumber(value: GameScreenController.TimeIncrement)) ?? "0.0") + "s"
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        super.viewWillAppear(true)
        tapCount = 0
        self.view.layer.backgroundColor = UIColor(hue:0.3, saturation: 0.44, brightness: 0.90, alpha: 1.0).cgColor
        startGame()
    }
        
    func startGame(){
        SubTime.text = "- " + (self.formatter.string(from: NSNumber(value: GameScreenController.TimeIncrement)) ?? "0.0") + "s"
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        tapCount = 0
        Instruction = InstructionsList.randomElement()
        InstructionalText.text = Instruction
        var Time:Float = 0.0
        var colorTime:Float = 0.00
        GameScreenController.TimeIncrement = Float(Int(GameScreenController.TimeIncrement * 1000)) / 1000.0
        if Instruction == "Tap once!" {
            Time = 1.5 - GameScreenController.TimeIncrement
            colorTime = 1.50 - GameScreenController.TimeIncrement
        }
        else if Instruction == "Tap twice!" {
            Time = 2  - GameScreenController.TimeIncrement
            colorTime = 2.00 - GameScreenController.TimeIncrement
        }
        else if Instruction == "Tap 3 times!" {
            Time = 3  - GameScreenController.TimeIncrement
            colorTime = 3.00 - GameScreenController.TimeIncrement
        }
        else if Instruction == "Swipe up!" {
            Time = 2  - GameScreenController.TimeIncrement
            colorTime = 2.00 - GameScreenController.TimeIncrement
        }
        else if Instruction == "Swipe down!" {
            Time = 2  - GameScreenController.TimeIncrement
            colorTime = 2.00 - GameScreenController.TimeIncrement
        }
        else if Instruction == "Swipe right!" {
            Time = 2  - GameScreenController.TimeIncrement
            colorTime = 2.00 - GameScreenController.TimeIncrement
        }
        else if Instruction == "Swipe left!" {
            Time = 2  - GameScreenController.TimeIncrement
            colorTime = 2.00 - GameScreenController.TimeIncrement
        }
        else if Instruction == "Shake your phone!" {
            Time = 2 - GameScreenController.TimeIncrement
            colorTime = 2.00 - GameScreenController.TimeIncrement
        }
        GameTimer.text = self.formatter.string(from: NSNumber(value: Time))
        startDelay = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.0), repeats: false) { startDelay in
            startDelay.invalidate()
            self.hueValue = 0.3
            self.colorTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.01), repeats: true) { colorTimer in
                colorTime -= 0.01
                self.hueValue -= 0.001
                colorTime = Float(Double(round(10000*Time)/10000))
                self.view.layer.backgroundColor = UIColor(hue:self.hueValue, saturation: 0.44, brightness: 0.90, alpha: 1.0).cgColor
                if colorTime == 0 {
                    colorTimer.invalidate()
                    self.view.layer.backgroundColor = UIColor(hue:0.0, saturation: 0.44, brightness: 0.90, alpha: 1.0).cgColor
                }
            }
            self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.1), repeats: true) { timer in
                Time -= 0.1
                if(Time <= 0){
                    Time = 0.0
                }
                self.GameTimer.text = self.formatter.string(from: NSNumber(value: Time))
                if Time == 0.0 {
                    Time = 0.0
                    timer.invalidate()
                    self.performSegue(withIdentifier: "youlose", sender: self)
                }
            }
            RunLoop.current.add(self.colorTimer, forMode: .common)
            RunLoop.current.add(self.timer, forMode: .common)
            
        }
        RunLoop.current.add(startDelay, forMode: .common)
    }
    
    func subAnimation(){
        self.subAnim.isHidden = false
        self.subAnim.center.x = startX
        self.subAnim.center.y = startY
        self.subAnim.alpha = 1
        let xRandom = Double.random(in: 0...0.3)
        let yRandom = Double.random(in: 0...0.3)
        let angleRandom = Double.random(in: 0...3)

        self.subAnim.transform = CGAffineTransform(rotationAngle: 0)
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.05,
              animations: {
                self.subAnim.center.x = self.subAnim.center.x + CGFloat((12 + xRandom))
                self.subAnim.center.y = self.subAnim.center.y - CGFloat((15 + yRandom))
                self.subAnim.transform = CGAffineTransform(rotationAngle: CGFloat.pi * CGFloat(10 + angleRandom) / 180)
                self.subAnim.alpha = 0.75
              }
            )
            UIView.addKeyframe(withRelativeStartTime: 0.05, relativeDuration: 0.10,
              animations: {
                self.subAnim.center.x += 10.0
                self.subAnim.center.y -= 14.0
                self.subAnim.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 25 / 180)
                self.subAnim.alpha = 0.4
              }
            )
            UIView.addKeyframe(withRelativeStartTime: 0.15, relativeDuration: 0.15,
              animations: {
                self.subAnim.center.x += 11.0
                self.subAnim.center.y -= 15.0
                self.subAnim.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 40 / 180)
                self.subAnim.alpha = 0
              }
            )
        }, completion: nil)
    }
    override func motionBegan(_ motion: UIEvent.EventSubtype, with even: UIEvent?) {
        if Instruction == "Shake your phone!" {
            isComplete = true
            timer.invalidate()
            confetti.isHidden = false
                        confetti.play(completion: {_ in self.confetti.isHidden = true
                self.startGame()
            })
            subAnimation()
            colorTimer.invalidate()
            GameScreenController.TimeIncrement += 0.1
        }
    }
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        tapCount += 1;
        if Instruction == "Tap once!" && tapCount == 1 {
            isComplete = true
            timer.invalidate()
            colorTimer.invalidate()
            confetti.isHidden = false
                        confetti.play(completion: {_ in self.confetti.isHidden = true
                self.startGame()
            })
            subAnimation()
            GameScreenController.TimeIncrement += 0.1
        }
        else if Instruction == "Tap twice!" && tapCount == 2 {
            isComplete = true
            timer.invalidate()
            colorTimer.invalidate()
            confetti.isHidden = false
                        confetti.play(completion: {_ in self.confetti.isHidden = true
                self.startGame()
            })
            subAnimation()
            GameScreenController.TimeIncrement += 0.1
        }
        else if Instruction == "Tap 3 times!" && tapCount == 3 {
            isComplete = true
            timer.invalidate()
            
            confetti.isHidden = false
                        confetti.play(completion: {_ in self.confetti.isHidden = true
                self.startGame()
            })
            subAnimation()
            colorTimer.invalidate()
            GameScreenController.TimeIncrement += 0.1
        }
    }
    
    @IBAction func swipeGesture(_ sender: UISwipeGestureRecognizer) {
        
        if sender.direction == .left && Instruction == "Swipe left!" {
            isComplete = true
            GameScreenController.TimeIncrement += 0.1
            timer.invalidate()
            confetti.isHidden = false
            confetti.play(completion: {_ in self.confetti.isHidden = true
                self.startGame()
            })
            subAnimation()
            colorTimer.invalidate()
        }
        else if sender.direction == .right && Instruction == "Swipe right!" {
            isComplete = true
            GameScreenController.TimeIncrement += 0.1
            timer.invalidate()
            confetti.isHidden = false
                        confetti.play(completion: {_ in self.confetti.isHidden = true
                self.startGame()
            })
            subAnimation()
            colorTimer.invalidate()
        }
        else if sender.direction == .up && Instruction == "Swipe up!" {
            isComplete = true
            GameScreenController.TimeIncrement += 0.1
            timer.invalidate()
            confetti.isHidden = false
                        confetti.play(completion: {_ in self.confetti.isHidden = true
                self.startGame()
            })
            subAnimation()
            colorTimer.invalidate()
        }
        else if sender.direction == .down && Instruction == "Swipe down!" {
            isComplete = true
            GameScreenController.TimeIncrement += 0.1
            timer.invalidate()
            colorTimer.invalidate()
            confetti.isHidden = false
                        confetti.play(completion: {_ in self.confetti.isHidden = true
                self.startGame()
            })
            subAnimation()
        }
    }
    

}
