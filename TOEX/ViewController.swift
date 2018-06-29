//
//  ViewController.swift
//  TOEX
//
//  Created by TaeGeun Moon on 2018. 6. 29..
//  Copyright © 2018년 TaeGeun Moon. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBAction func handleButtonTouch(_ sender: UIButton) {
        Alamofire.request("https://jsonplaceholder.typicode.com/posts/1", method: .get).responseJSON { response in
            
            if let data = response.data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                debugPrint(json)
            }
            
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

