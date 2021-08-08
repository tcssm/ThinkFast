//
//  loseViewController.swift
//  ThinkFast
//
//  Created by Deanna Yee on 6/22/21.
//

import UIKit

class loseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func retryButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        GameScreenController.TimeIncrement = 0.0
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
