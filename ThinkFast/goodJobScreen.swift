//
//  goodJobScreen.swift
//  ThinkFast
//
//  Created by  Owen Gregson on 6/24/21.
//

import UIKit

class goodJobScreen: UIViewController {
    var nextDelay: Timer!
    let formatter = NumberFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        nextDelay = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.7), repeats: false) { nextDelay in
            nextDelay.invalidate()
            GameScreenController.TimeIncrement += 0.1
            
        }
    RunLoop.current.add(nextDelay, forMode: .common)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
