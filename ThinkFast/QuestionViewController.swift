//
//  QuestionViewController.swift
//  ThinkFast
//
//  Created by Deanna Yee on 8/31/21.
//

import UIKit
import Lottie

class QuestionViewController: UIViewController {

    let formatter = NumberFormatter()
    static var TimeIncrement:Float = 0.0
    @IBOutlet weak var InstructionalText: UILabel!
    @IBOutlet weak var GameTimer: UILabel!
    @IBOutlet weak var subAnim: UILabel!
    @IBOutlet weak var confetti: AnimationView!
    var Instruction: String!
    let InstructionsList: [String]=["How many blue objects?", "How many red objects?", "How many green objects?", "How many circles?", "How many squares?", "How many triangles?"]
    @IBOutlet weak var SubTime: UILabel!
    var tapCount = 0
    var isComplete = false
    var lastPoint = CGPoint.zero
    var timeSolved:Float = 0
    var colorTimer: Timer!
    var color = UIColor.black
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var Time:Float = 0.0
    var hueValue:CGFloat = 0.0
    var swiped = false
    var timeAlotted:Float = 0.0
    var startX:CGFloat = 365.0
    var progressPulseTimer:Timer!
    var startY:CGFloat = 65
    var timer: Timer!
    var startDelay: Timer!
    var previousDegree : CGFloat = 0.0
                    // Do any additional setup after loading the view.
    override func viewWillAppear(_ animated: Bool) {
        SubTime.text = "- " + (self.formatter.string(from: NSNumber(value: GameScreenController.TimeIncrement)) ?? "0.0") + "s"
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        super.viewWillAppear(true)
        //progressPulseTimer = Timer.scheduledTimer(timeInterval: <#T##TimeInterval#>, invocation: <#T##NSInvocation#>, repeats: <#T##Bool#>)
        tapCount = 0
        self.view.layer.backgroundColor = UIColor(hue:0.3, saturation: 0.44, brightness: 0.90, alpha: 1.0).cgColor
        startGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    func startGame(){
        SubTime.text = "- " + (self.formatter.string(from: NSNumber(value: GameScreenController.TimeIncrement)) ?? "0.0") + "s"
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        tapCount = 0
        Instruction = InstructionsList.randomElement()
        InstructionalText.text = Instruction
        Time = 0.0
        var colorTime:Float = 0.00
        GameScreenController.TimeIncrement = Float(Int(GameScreenController.TimeIncrement * 1000)) / 1000.0
        if Instruction == "How many blue objects?" {
            Time = 1.5 - GameScreenController.TimeIncrement
            colorTime = 1.50 - GameScreenController.TimeIncrement
        }
        else if Instruction == "How many red objects?" {
            Time = 2  - GameScreenController.TimeIncrement
            colorTime = 2.00 - GameScreenController.TimeIncrement
        }
        else if Instruction == "How many green objects?" {
            Time = 3  - GameScreenController.TimeIncrement
            colorTime = 3.00 - GameScreenController.TimeIncrement
        }
        else if Instruction == "How many circles?" {
            Time = 2  - GameScreenController.TimeIncrement
            colorTime = 2.00 - GameScreenController.TimeIncrement
        }
        else if Instruction == "How many squares?" {
            Time = 2  - GameScreenController.TimeIncrement
            colorTime = 2.00 - GameScreenController.TimeIncrement
        }
        else if Instruction == "How many triangles?" {
            Time = 2  - GameScreenController.TimeIncrement
            colorTime = 2.00 - GameScreenController.TimeIncrement
        }
        GameTimer.text = self.formatter.string(from: NSNumber(value: Time))
        startDelay = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.0), repeats: false) { startDelay in
            startDelay.invalidate()
            self.hueValue = 0.3
            self.colorTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.01), repeats: true) { colorTimer in
                colorTime -= 0.01
                self.hueValue -= 0.001
                colorTime = Float(Double(round(10000*self.Time)/10000))
                self.view.layer.backgroundColor = UIColor(hue:self.hueValue, saturation: 0.44, brightness: 0.90, alpha: 1.0).cgColor
                if colorTime == 0 {
                    colorTimer.invalidate()
                    self.view.layer.backgroundColor = UIColor(hue:0.0, saturation: 0.44, brightness: 0.90, alpha: 1.0).cgColor
                }
            }
            self.timeAlotted = self.Time
            self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.1), repeats: true) { timer in
                self.Time -= 0.1
                if(self.Time <= 0){
                    self.Time = 0.0
                }
                self.GameTimer.text = self.formatter.string(from: NSNumber(value: self.Time))
                if self.Time == 0.0 {
                    self.Time = 0.0
                    timer.invalidate()
                    self.performSegue(withIdentifier: "youlose", sender: self)
                }
            }
            RunLoop.current.add(self.colorTimer, forMode: .common)
            RunLoop.current.add(self.timer, forMode: .common)
            
        }
        RunLoop.current.add(startDelay, forMode: .common)
    }
    
    func success(){
        timer.invalidate()
        var degree =  CGFloat(Int.random(in: 0...360))
        while(degree <= previousDegree - 20 && degree >= previousDegree + 20){
            degree =  CGFloat(Int.random(in: 0...360))
        }
        let angle = CGFloat.pi * degree / 180
        confetti.transform = CGAffineTransform(rotationAngle: angle)
        confetti.isHidden = false
        confetti.play(completion: {_ in self.confetti.isHidden = true
            self.startGame()
        })
        subAnimation()
        colorTimer.invalidate()
        GameScreenController.TimeIncrement += 0.1
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
                self.subAnim.alpha = 0.2
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "youlose"){
            let loseView = segue.destination as! loseViewController
            loseView.previousView = "questions"
        }
    }

}
