//
//  ViewController.swift
//  NNReactiveLogin
//
//  Created by Nguyen Hoang Nam on 17/1/16.
//  Copyright © 2016 Nguyen Hoang Nam. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.initialization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //--------------------------------------------------
    func initialization() -> Void {
        nextButton.hidden = true
        usernameTextField.placeholder = "Enter lenght >= 10"
        passwordTextField.placeholder = "Password more than 6 characters"
        let formValidSignal: RACSignal = RACSignal.combineLatest([usernameTextField.rac_textSignal(),passwordTextField.rac_textSignal()]).map {
            let tuple = $0 as! RACTuple
            let username = tuple.first as! String
            let password = tuple.second as! String
            return (username.characters.count < 10) || (password.characters.count < 6)
        }
        formValidSignal.setKeyPath("hidden", onObject: self.nextButton)
    }
    
    //--------------------------------------------------
    @IBAction func didTouchNextButton(sender: AnyObject) {
        usernameTextField.text = ""
        passwordTextField.text = ""
        nextButton.hidden = true
    }
}

