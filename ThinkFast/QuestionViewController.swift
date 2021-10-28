//
//  QuestionViewController.swift
//  ThinkFast
//
//  Created by Owen Gregson on 8/31/21.
//

import UIKit
import Lottie

class QuestionViewController: UIViewController {


    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var InstructionalText: UILabel!
    @IBOutlet weak var GameTimer: UILabel!
    @IBOutlet weak var subAnim: UILabel!
    @IBOutlet weak var confetti: AnimationView!
    @IBOutlet weak var wrongView: UIView!
    @IBOutlet weak var SubTime: UILabel!
    let formatter = NumberFormatter()
    static var TimeIncrement:Float = 0.0
    var Instruction: String!
    let InstructionsList: [String]=["How many blue objects?", "How many red objects?", "How many green objects?", "How many circles?", "How many squares?", "How many triangles?"]
    var answerList:[Int]!
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
    var fadeTimer:Timer!
    var startY:CGFloat = 65
    var timer: Timer!
    var startDelay: Timer!
    var previousDegree : CGFloat = 0.0
    var correctAnswerIndex = 0
    var correctAnswer = 0
    var questionIndex = -1
    var possibleAnswers: [Int] = []
                    // Do any additional setup after loading the view.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        SubTime.text = "- " + (self.formatter.string(from: NSNumber(value: MemoryViewController.TimeIncrement)) ?? "0.0") + "s"
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        tapCount = 0
        self.view.layer.backgroundColor = UIColor(hue:0.3, saturation: 0.44, brightness: 0.90, alpha: 1.0).cgColor
        
        startGame()
    }
    
    func setAnswers(){
        self.correctAnswerIndex = Int.random(in: 0..<answerButtons.count)
        correctAnswer = answerList[self.questionIndex]
        answerButtons[self.correctAnswerIndex].setTitle(String(correctAnswer), for: .normal)
        if correctAnswer <= 1{
            possibleAnswers = Array(0...3)
        }else{
            possibleAnswers = Array(correctAnswer - 2...correctAnswer + 2)
        }
        let correctIndex = possibleAnswers.firstIndex(of: correctAnswer)
        if let correctIndex = correctIndex {
            possibleAnswers.remove(at: correctIndex)
        }
        for i in 0..<answerButtons.count{
            if i != correctAnswerIndex{
                let index = Int.random(in: 0..<possibleAnswers.count)
                let answer = possibleAnswers.remove(at: index)
                answerButtons[i].setTitle(String(answer), for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    func startGame(){
        wrongView.isHidden = true
        SubTime.text = "- " + (self.formatter.string(from: NSNumber(value: MemoryViewController.TimeIncrement)) ?? "0.0") + "s"
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        tapCount = 0
        Instruction = InstructionsList.randomElement()
        questionIndex = InstructionsList.firstIndex(of: Instruction)!
        InstructionalText.text = Instruction
        setAnswers()
        Time = 0.0
        var colorTime:Float = 0.00
        MemoryViewController.TimeIncrement = Float(Int(MemoryViewController.TimeIncrement * 1000)) / 1000.0
        if Instruction == "How many blue objects?" {
            Time = 5 - GameScreenController.TimeIncrement
            colorTime = 5.00 - GameScreenController.TimeIncrement
        }
        else if Instruction == "How many red objects?" {
            Time = 5  - GameScreenController.TimeIncrement
            colorTime = 5.00 - GameScreenController.TimeIncrement
        }
        else if Instruction == "How many green objects?" {
            Time = 5  - GameScreenController.TimeIncrement
            colorTime = 5.00 - GameScreenController.TimeIncrement
        }
        else if Instruction == "How many circles?" {
            Time = 5  - GameScreenController.TimeIncrement
            colorTime = 5.00 - GameScreenController.TimeIncrement
        }
        else if Instruction == "How many squares?" {
            Time = 5  - GameScreenController.TimeIncrement
            colorTime = 5.00 - GameScreenController.TimeIncrement
        }
        else if Instruction == "How many triangles?" {
            Time = 5  - GameScreenController.TimeIncrement
            colorTime = 5.00 - GameScreenController.TimeIncrement
        }
        GameTimer.text = self.formatter.string(from: NSNumber(value: Time))
        startDelay = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.0), repeats: false) { startDelay in
            startDelay.invalidate()
            self.hueValue = 0.3
            self.colorTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.01), repeats: true) { colorTimer in
                colorTime -= 0.01
                self.hueValue -= 0.0006
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
            self.navigationController?.popViewController(animated: true)
        })
        MemoryViewController.TimeIncrement += 0.1
        SubTime.text = "- " + (self.formatter.string(from: NSNumber(value: MemoryViewController.TimeIncrement)) ?? "0.0") + "s"
        subAnimation()
        colorTimer.invalidate()
        
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
    
    @IBAction func answerQuestion(_ sender: UIButton) {
        if Int(sender.currentTitle!) == correctAnswer{
            success()
        }else{
            timer.invalidate()
            colorTimer.invalidate()
            MemoryViewController.TimeIncrement = 0.0
            wrongView.alpha = 0.7
            wrongView.isHidden = false
            fadeTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.06), repeats: true) { timer in
                self.wrongView.alpha -= 0.1
                if self.wrongView.alpha <= 0.0{
                    self.fadeTimer.invalidate()
                    self.wrongView.isHidden = true
                    self.performSegue(withIdentifier: "youlose", sender: self)
                }
                
            }
        }
    }
}
