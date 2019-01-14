//
//  ViewController.swift
//  HeartAnimation
//
//  Created by user on 31/12/2018.
//  Copyright © 2018 Beliverz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    var thumbArray = ["1","2","3","4"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func CreateThumb(){
        let bubbleImageView = UIImageView(image: #imageLiteral(resourceName: "3"))
        bubbleImageView.center = view.center
        bubbleImageView.alpha = 0.5
        view.addSubview(bubbleImageView)
        
        let Path = UIBezierPath()
        let oX: CGFloat = bubbleImageView.frame.origin.x
        let oY: CGFloat = bubbleImageView.frame.origin.y
        let eX: CGFloat = oX
        let eY: CGFloat = oY - 200
        let t: CGFloat = 40
        var cp1 = CGPoint(x: oX - t, y: (oY + eY) / 2)
        var cp2 = CGPoint(x: oX + t, y: cp1.y)
        // random images
        let number = Int.random(in: 0 ..< 4)
        //For random postion
        let r = Int(arc4random()) % 2
        if r == 1 {
            let temp: CGPoint = cp1
            cp1 = cp2
            cp2 = temp
            bubbleImageView.image = UIImage.init(named: thumbArray[number])
            bubbleImageView.alpha = 0.7
            bubbleImageView.frame = CGRect(x: view.frame.origin.x + 8, y: view.frame.origin.y + 30, width: 24 , height: 24)
        }
        // the moveToPoint method sets the starting point of the line
        Path.move(to: CGPoint(x: oX, y: oY))
        // add the end point and the control points
    
        Path.addCurve(to: CGPoint(x: eX, y: eY), controlPoint1: cp1, controlPoint2: cp2)
        
        CATransaction.begin()
        
        CATransaction.setCompletionBlock({
            // transform the image to be 1.3 sizes larger to
            // give the impression that it is popping
            UIView.transition(with: bubbleImageView, duration: 0.1, options: .transitionCrossDissolve, animations: {
               
                bubbleImageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }) { finished in
                bubbleImageView.removeFromSuperview()
            }
        })
        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        pathAnimation.duration = 2
        pathAnimation.path = Path.cgPath
        // remains visible in it's final state when animation is finished
        
        pathAnimation.fillMode = .forwards
        pathAnimation.isRemovedOnCompletion = false
        bubbleImageView.layer.add(pathAnimation, forKey: "movingAnimation")
        
    }
    

    @IBAction func BtnClick(){
        
        //Zoom out Button
//        let pulse1 = CASpringAnimation(keyPath: "transform.scale")
//        pulse1.duration = 0.6
//        pulse1.fromValue = 1.0
//        pulse1.toValue = 1.12
//        pulse1.autoreverses = true
//        pulse1.repeatCount = 1
//        pulse1.initialVelocity = 0.5
//        pulse1.damping = 0.8
//
//        let animationGroup = CAAnimationGroup()
//        animationGroup.duration = 2.7
//        animationGroup.repeatCount = 1000
//        animationGroup.animations = [pulse1]
//
//        button.layer.add(animationGroup, forKey: "pulse")
          CreateThumb()
       
    }

}

