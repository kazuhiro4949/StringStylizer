//
//  ViewController.swift
//  iOS Sample
//
//  Created by kahayash on 2018/02/07.
//  Copyright © 2018年 Kazuhiro Hayashi. All rights reserved.
//

import UIKit
import StringStylizer

class ViewController: UIViewController {
    @IBOutlet weak var centerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerLabel.attributedText = "aaa".stylize().color(.red).attr
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

