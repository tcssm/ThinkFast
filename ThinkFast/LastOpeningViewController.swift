//
//  LastOpeningViewController.swift
//  ThinkFast
//
//  Created by Deanna Yee on 10/7/21.
//

import UIKit

class LastOpeningViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func gotoMainMenu(_ sender: Any){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainMenu = storyBoard.instantiateViewController(withIdentifier: "MainMenu")
        navigationController?.setViewControllers([mainMenu], animated: true)
    }
}
