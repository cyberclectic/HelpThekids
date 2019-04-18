//
//  ViewController.swift
//  HelpTheKids
//
//  Created by Gerald Wood on 4/18/19.
//  Copyright © 2019 Gerald Wood. All rights reserved.
//

import UIKit

class ViewController: UIViewController,DrawingProtocol {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var drawingView: DrawingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawingView.delegate = self
    }
    
    func touchDidMoveToOutSideThePath(str: String) {
        myLabel.text = str;
    }

}

