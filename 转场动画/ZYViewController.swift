//
//  ZYViewController.swift
//  转场动画
//
//  Created by Pack Zhang on 16/4/10.
//  Copyright © 2016年 Pack Zhang. All rights reserved.
//

import UIKit

class ZYViewController: UIViewController {
    
    var presentedViewFrame : CGRect = CGRectZero
    
    var isPresenting : Bool = false
    
    var anchorPoint: CGPoint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
       view.backgroundColor = UIColor.yellowColor()

    }


    init(touchPoint: CGPoint) {
        
        super.init(nibName: nil, bundle: nil)
        
        addCircleView(touchPoint)
        
        anchorPoint = pointToAnchorPoint(touchPoint)

    }
    
    func addCircleView(point: CGPoint) {
        
        let size = UIScreen.mainScreen().bounds.size
        
        let a = point.y > size.height * 0.499 ? point.y : size.height - point.y
        
        let b = point.x > size.width * 0.5 ? point.x : size.width - point.x
        
        let maxRadius = sqrt(pow(a, 2) + pow(b, 2))
        
        let v = UIView()
        
        v.backgroundColor = UIColor.orangeColor()
        v.bounds = CGRect(x: 0, y: 0, width: maxRadius * 2, height: maxRadius * 2)
        
        v.layer.cornerRadius = maxRadius
        
        v.center = view.center
        
        view.addSubview(v)
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    deinit{
        print("8888")
    }

}

extension ZYViewController: UIViewControllerTransitioningDelegate {

    
    func pointToAnchorPoint(point: CGPoint) -> CGPoint {
        let size = UIScreen.mainScreen().bounds.size
        let x = point.x / size.width
        let y = point.y / size.height
        return CGPoint(x: x, y: y)
    }
    
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?{
        
        let vc = ZYPresentationController(presentedViewController: presented, presentingViewController: presenting)
        
        vc.presentedViewFrame = presentedViewFrame
        
        return vc
    }
    
    
    //告诉系统谁来管理展示控制器动画
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    //告诉系统谁来管理辞退控制器动画
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
}

///管理modal动画的控制器
extension ZYViewController: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        if isPresenting {
            
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
            
            transitionContext.containerView()?.addSubview(toView!)
            print(anchorPoint!)
            
            toView?.layer.anchorPoint = anchorPoint!
            
            toView?.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                toView?.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }) { (_) in
                transitionContext.completeTransition(true)
            }
            
        }else{
            
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                fromView?.transform = CGAffineTransformMakeScale(0.000001, 0.00000001)
                
            }) { (_) in
                
                transitionContext.completeTransition(true)
            }
            
            
        }
    }
    
}

//专门管理战场动画的控制器
class ZYPresentationController: UIPresentationController {
    
    var presentedViewFrame: CGRect?
    
    override func containerViewWillLayoutSubviews() {
        
        let toView = presentedView()
        
        if presentedViewFrame == CGRectZero {
            toView?.frame = UIScreen.mainScreen().bounds
        }else{
            toView?.frame = CGRectZero
        }
        
    }
    
}



