//
//  LoginViewController.swift
//  4MD-Olgerts-Balabans
//
//  Created by students on 24/05/2020.
//  Copyright © 2020 students. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Username: UITextField!
    


    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    //IF time setup user and password from web
    @IBAction func SubmitButton(_ sender: UIButton) {
        if (Username.text == "Launais" && Password.text == "Lektors") {
            
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
        }
    }


}
