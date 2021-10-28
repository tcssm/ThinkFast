//
//  loseViewController.swift
//  ThinkFast
//
//  Created by  Owen Gregson on 6/22/21.
//

import UIKit

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}

class loseViewController: UIViewController {
    
    var previousView : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func mainMenuButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func retryButton(_ sender: Any) {
        if(previousView == "game"){
            navigationController?.popViewController(animated: true)
            GameScreenController.TimeIncrement = 0.0
        }else if(previousView == "questions"){
            navigationController?.popToViewController(ofClass: MemoryViewController.self, animated: true)
            QuestionViewController.TimeIncrement = 0.0
        }
        
        self.view.layoutIfNeeded()
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
