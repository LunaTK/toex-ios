//
//  LoginViewController.swift
//  TOEX
//
//  Created by TaeGeun Moon on 2018. 6. 29..
//  Copyright © 2018년 TaeGeun Moon. All rights reserved.
//

import UIKit
import SDWebImage

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func handleLogin(_ sender: Any) {
        let session: KOSession = KOSession.shared()
        if session.isOpen() {
            session.close()
        }
        session.presentingViewController = self
        session.open { [weak self] (error) in
            if error != nil{
                print(error!.localizedDescription)
            }else if session.isOpen() == true{
                KOSessionTask.userMeTask(completion: { [self] (error, me) in
                    if error == nil{
                        self?.performSegue(withIdentifier: "gotoOffers", sender: self)
                    }
                })
            }
        }
    }
    
    @IBAction func handleLogout(_ sender: Any) {
        KOSessionTask.unlinkTask { (success, error) in
            print(success)
        }
    }
    
    @IBAction func handleReq(_ sender: Any) {
        APIManager.testRequest()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
