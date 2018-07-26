//
//  LJComposeViewController.swift
//  testPro
//
//  Created by ljkj on 2018/7/26.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit

class LJComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.cz_random()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        dismiss(animated: true, completion: nil)
    }
    

}
