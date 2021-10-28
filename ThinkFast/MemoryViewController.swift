//
//  MemoryViewController.swift
//  ThinkFast
//
//  Created by  Owen Gregson on 8/31/21.
//

import UIKit

class MemoryViewController: UIViewController {
    
    @IBOutlet weak var GameTimer: UILabel!
    @IBOutlet var memoryShapes: [UIView]!
    @IBOutlet var backgroundViews: [UIView]!
    let formatter = NumberFormatter()
    var colorTimer: Timer!
    var timer: Timer!
    var Time:Float = 0.0
    var hueValue:CGFloat = 0.0
    var startDelay: Timer!
    var counts:[Int] = [Int](repeating: 0, count: 6)
    static var TimeIncrement: Float = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "questionScreen"{
            let questionViewController = segue.destination as! QuestionViewController
            questionViewController.answerList = counts
        }
    }
    
    func startGame(){
        display()
        Time = 10.0 - MemoryViewController.TimeIncrement
        var colorTime:Float = 10.00 - MemoryViewController.TimeIncrement
        let colorTicks:Float = (colorTime/0.01)
        GameTimer.text = self.formatter.string(from: NSNumber(value: Time))
        startDelay = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.0), repeats: false) { startDelay in
            startDelay.invalidate()
            self.hueValue = 0.3
            self.colorTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.01), repeats: true) { colorTimer in
                colorTime -= 0.01
                self.hueValue -= 0.3 / CGFloat(colorTicks)
                colorTime = Float(Double(round(10000*self.Time)/10000))
                let color = UIColor(hue:self.hueValue, saturation: 0.44, brightness: 0.90, alpha: 1.0)
                self.view.backgroundColor = color
                self.changeBackground(views: self.backgroundViews, color: color)
                self.changeBackground(views: self.memoryShapes, color: color)
                if colorTime == 0 {
                    colorTimer.invalidate()
                    let stopColor = UIColor(hue:0.0, saturation: 0.44, brightness: 0.90, alpha: 1.0)
                    self.view.backgroundColor = stopColor
                    self.changeBackground(views: self.backgroundViews, color:stopColor)
                    self.changeBackground(views: self.memoryShapes, color: stopColor)
                }
            }
            
            self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.1), repeats: true) { timer in
                self.Time -= 0.1
                if(self.Time <= 0){
                    self.Time = 0.0
                }
                
                self.GameTimer.text = "\(Double(Int(self.Time*10)) / 10.0)"
                if self.Time == 0.0 {
                    self.Time = 0.0
                    timer.invalidate()
                    self.performSegue(withIdentifier: "questionScreen", sender: self)
                }
            }
            RunLoop.current.add(self.colorTimer, forMode: .common)
            RunLoop.current.add(self.timer, forMode: .common)
            
        }
        RunLoop.current.add(startDelay, forMode: .common)
        
    }
    
    func setColors(){
        let colors = [UIColor.systemGreen, UIColor.systemRed, UIColor.systemBlue]
        for shape in memoryShapes {
            shape.backgroundColor = colors.randomElement()
        }
    }
    
    func display(){
        setColors()
        setShapes()
        setVisible()
        countShapes()
    }
    var 📸 = "a"

    func setVisible(){
        for shape in memoryShapes{
            let randNum = Int.random(in: 1...2)
            if randNum == 1{
                shape.isHidden = true
            }else{
                shape.isHidden = false
            }
        }
    }
    
    func countShapes(){
        counts = [Int](repeating: 0, count: 6)
        for shape in memoryShapes{
            if !shape.isHidden && shape.backgroundColor?.cgColor == UIColor.systemBlue.cgColor{ //How many blue objects?
                counts[0] += 1
            }else if !shape.isHidden && shape.backgroundColor?.cgColor == UIColor.systemRed.cgColor{ //How many red objects?
                counts[1] += 1
            }else if !shape.isHidden && shape.backgroundColor?.cgColor == UIColor.systemGreen.cgColor{ //How many green objects?
                counts[2] += 1
            }
            
            if !shape.isHidden && shape.layer.cornerRadius == 48{ //How many circles?
                counts[3] += 1
            }
            else if !shape.isHidden && shape.layer.cornerRadius == 0{ //How many squares?
                counts[4] += 1
            }else if !shape.isHidden && shape.layer.cornerRadius == 15{ //How many triangles?
                counts[5] += 1
            }
            
        }
    }
    
    func setShapes(){
        for shape in memoryShapes{
            shape.layer.sublayers?[0].removeFromSuperlayer()
            let randomNum = Int.random(in: 1...3)
            if randomNum  == 1{
                shape.layer.cornerRadius = 0
            }else if randomNum == 2{
                shape.layer.cornerRadius = 48
            }else{
                setUpTriangle(targetView: shape)
            }
        }
    }
    
    func changeBackground(views: [UIView], color : UIColor){
        for view in views {
            if view.layer.cornerRadius == 15 || backgroundViews.contains(view){
                view.backgroundColor = color
            }
        }
    }
    
    func setUpTriangle(targetView:UIView?){
        targetView?.layer.cornerRadius = 15
        let heightWidth = targetView!.frame.size.width
        let path = CGMutablePath()

        path.move(to: CGPoint(x: 0, y: heightWidth - 4))
        path.addLine(to: CGPoint(x:(heightWidth - 4)/2, y: -1))
        path.addLine(to: CGPoint(x:heightWidth - 4, y:heightWidth - 4))
        path.addLine(to: CGPoint(x:0, y:heightWidth - 4))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = targetView!.backgroundColor?.cgColor
        targetView!.layer.insertSublayer(shape, at: 0)
    }
    
    
    

}
