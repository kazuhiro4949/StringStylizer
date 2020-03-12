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

        // build NSAttributedString.
        let greeting = " Hi, ".stylize().color(0x2200ee).size(12).font(.HelveticaNeue).attr
        
        // build NSAttributedString with ranges.
        let msg = "something happened ".stylize()
            .range(0..<9)        .color(0x009911).size(12).font(.HelveticaNeue)
            .range(10..<UInt.max).color(0xaa22cc).size(14).font(.HelveticaNeue_Bold).attr
        
        // build NSAttributedString objects and join them.
        let name = "to ".stylize().color(0x23abfc).size(12).font(.HelveticaNeue).attr +
            "you👩‍👩‍👦‍👦".stylize().color(0x123456).size(14).font(.HelveticaNeue_Italic).underline([.double, .patternDot]).attr
        
        // build NSAttributedString objects with strikethrough and kerning applied.
        let response = "\nHow ".stylize().attr +  "boring".stylize().strikeThrough(.single).attr +
            " exciting!".stylize().kern(-2).attr
        
        centerLabel.attributedText = #imageLiteral(resourceName: "Attachment").textAttachment(17, 17) + greeting + msg + name + response
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

