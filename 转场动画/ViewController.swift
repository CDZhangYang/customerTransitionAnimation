//
//  ViewController.swift
//  转场动画
//
//  Created by Pack Zhang on 16/4/10.
//  Copyright © 2016年 Pack Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.greenColor()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let point = touches.first?.locationInView(view)
        
        let vc = ZYViewController(touchPoint: point!)
        //被modal的控制器的代理     
        
        vc.transitioningDelegate = vc
        
        vc.modalPresentationStyle = .Custom
        
        presentViewController(vc, animated: true, completion: nil)
    }

}


