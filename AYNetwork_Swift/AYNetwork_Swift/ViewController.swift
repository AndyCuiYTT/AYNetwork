//
//  ViewController.swift
//  AYNetwork_Swift
//
//  Created by Andy on 2017/6/7.
//  Copyright © 2017年 Andy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
    
    }
    @IBAction func loadData(_ sender: UIButton) {
        
        
        AYNetworkManager.ay_post("http://localhost:8080/MavenDemo/userApi1", ["method":"getAllUsers"], result: { (resultData) in
            print(resultData)
        }) { (failData) in
            print(failData)
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

