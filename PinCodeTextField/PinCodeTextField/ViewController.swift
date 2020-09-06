//
//  ViewController.swift
//  PinCodeTextField
//
//  Created by 侯博野 on 2020/9/6.
//  Copyright © 2020 satelens. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pinCodeTF = PinCodeTextField(characterLimit: 6)
        view.addSubview(pinCodeTF)
        pinCodeTF.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 60)
        
        pinCodeTF.backgroundColor = UIColor.red
    }


}

