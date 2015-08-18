//
//  ElementalLoader.swift
//  ElementalLoader
//
//  Created by Carrl on 15/8/13.
//  Copyright (c) 2015年 monk-studio. All rights reserved.
//

import UIKit
enum ElementalColorStyle{
    case cold
    case warm
    case gray
    case forest
    func getColors()->[CGColor]{
        switch self{
        case .cold:
            return [
                UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1).CGColor,
                UIColor(red: 123.0/255.0, green: 231.0/255.0, blue: 247.0/255.0, alpha: 1).CGColor,
                UIColor(red: 118.0/255.0, green: 189.0/255.0, blue: 238.0/255.0, alpha: 1).CGColor,
                UIColor(red: 120.0/255.0, green: 140.0/255.0, blue: 237.0/255.0, alpha: 1).CGColor
            ]
        case .warm:
            return [
                UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1).CGColor,
                UIColor(red: 247.0/255.0, green: 239.0/255.0, blue: 115.0/255.0, alpha: 1).CGColor,
                UIColor(red: 248.0/255.0, green: 173.0/255.0, blue: 123.0/255.0, alpha: 1).CGColor,
                UIColor(red: 247.0/255.0, green: 115.0/255.0, blue: 123.0/255.0, alpha: 1).CGColor
            ]
        case .gray:
            return [
                UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1).CGColor,
                UIColor(red: 222.0/255.0, green: 222.0/255.0, blue: 222.0/255.0, alpha: 1).CGColor,
                UIColor(red: 140.0/255.0, green: 140.0/255.0, blue: 140.0/255.0, alpha: 1).CGColor,
                UIColor(red: 90.0/255.0, green: 90.0/255.0, blue: 90.0/255.0, alpha: 1).CGColor
            ]
        case .forest:
            return [
                UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1).CGColor,
                UIColor(red: 107.0/255.0, green: 222.0/255.0, blue: 107.0/255.0, alpha: 1).CGColor,
                UIColor(red: 123.0/255.0, green: 99.0/255.0, blue: 96.0/255.0, alpha: 1).CGColor,
                UIColor(red: 68.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1).CGColor
            ]
        }
    }
    
}


//default size 100 x 100
class ElementalLoaderView: UIView {
    let bgLayer = CALayer()
    let elementLayer = CALayer()
    let element1 = CAShapeLayer()
    let element2 = CAShapeLayer()
    let element3 = CAShapeLayer()
    let element4 = CAShapeLayer()
    let element5 = CAShapeLayer()
    let element6 = CAShapeLayer()
    let element7 = CAShapeLayer()
    let element8 = CAShapeLayer()

    var sizeFactor:CGFloat = 1{
        didSet{
            self.layer.transform = CATransform3DMakeScale(sizeFactor, sizeFactor, 1)
        }
    }
    var elementalColorStyle:ElementalColorStyle = ElementalColorStyle.warm{
        didSet{
            let colors = self.elementalColorStyle.getColors()
            self.element4.fillColor = colors[0]
            self.element3.fillColor = colors[1]
            self.element2.fillColor = colors[2]
            self.element1.fillColor = colors[3]
            self.element8.fillColor = colors[0]
            self.element7.fillColor = colors[1]
            self.element6.fillColor = colors[2]
            self.element5.fillColor = colors[3]
            
        }
    }
    override func didMoveToSuperview() {
        self.frame = CGRectMake(self.center.x - 50, self.center.y - 50, 100, 100)
        //bg
        self.bgLayer.frame = CGRectMake(0, 0, 100, 100)
        self.bgLayer.cornerRadius = 12
        bgLayer.backgroundColor = UIColor(white: 0.2, alpha: 0.8).CGColor
        self.layer.addSublayer(self.bgLayer)
        //container
        self.elementLayer.frame = self.bgLayer.frame
        self.layer.addSublayer(self.elementLayer)
        self.elementLayer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 0, 0, -1)
        
        let ovalPath = CGPathCreateMutable()
        CGPathAddEllipseInRect(ovalPath, nil, CGRectInset(self.bgLayer.frame, 20, 20))
        //elements
        for member in [element1,element2,element3,element4,element5,element6,element7,element8]{
            member.frame = CGRectMake(0, 0, 100, 100)
            member.path = ovalPath
            member.lineWidth = 10
            member.lineCap = kCALineCapRound
            member.strokeEnd = 0.001
            member.fillColor = UIColor.clearColor().CGColor
            self.elementLayer.addSublayer(member)
        }
        for member in [element5,element6,element7,element8]{
            member.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 1)
        }
        
        //get the right color
        let colors = self.elementalColorStyle.getColors()
        self.element4.strokeColor = colors[0]
        self.element3.strokeColor = colors[1]
        self.element2.strokeColor = colors[2]
        self.element1.strokeColor = colors[3]
        self.element8.strokeColor = colors[0]
        self.element7.strokeColor = colors[1]
        self.element6.strokeColor = colors[2]
        self.element5.strokeColor = colors[3]
    }

    func animationBegin(){
        let animeDurationTotal = 2.0
        let elements1 = [element4,element3,element2,element1]
        let elements2 = [element8,element7,element6,element5]
        let stepCount = 0.1 as Float
        for (var i = 0; i < 4; ++i){
            let animeStrokeStart = CABasicAnimation(keyPath: "strokeStart")
            animeStrokeStart.toValue = 0.499
            animeStrokeStart.duration = animeDurationTotal / 2.0
            animeStrokeStart.speed = 1.0 / (1.0 - stepCount * Float(i))
            animeStrokeStart.beginTime = Double(stepCount * Float(i))
            
            let animeStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
            animeStrokeEnd.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            animeStrokeEnd.toValue = 0.5
            animeStrokeEnd.duration = animeDurationTotal / 2.0
            let animeGroup = CAAnimationGroup()
            animeGroup.duration = animeDurationTotal / 2.0
            animeGroup.animations = [animeStrokeStart,animeStrokeEnd]
            animeGroup.repeatCount = 1000
            elements1[i].addAnimation(animeGroup, forKey: "asds")
            elements2[i].addAnimation(animeGroup, forKey: "dsa")
        }
    }
}
private class ElementalLoaderViewController: UIViewController {
let loaderView = ElementalLoaderView(frame: CGRectMake(0, 0, 100, 100))
    override func viewDidLoad() {
        super.viewDidLoad()
        let grayView = UIView(frame: self.view.bounds)
        grayView.backgroundColor = UIColor(white: 0.3, alpha: 0.4)
        self.view.addSubview(grayView)
        self.view.addSubview(self.loaderView)
        self.loaderView.center = self.view.center
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loaderView.animationBegin()
    }
}
class ElementalLoader: NSObject {
    static let sharedLoader = ElementalLoader()
    private weak var currentLoaderVC:ElementalLoaderViewController? = nil
    override init() {
        super.init()
    }

    class func showInViewController(viewController:UIViewController, withStyle style:ElementalColorStyle){
        let instance = ElementalLoader.sharedLoader
        let vc = ElementalLoaderViewController()
        vc.loaderView.elementalColorStyle = style
        instance.currentLoaderVC = vc
        vc.modalPresentationStyle = .OverFullScreen
        vc.modalTransitionStyle = .CrossDissolve
        viewController.presentViewController(vc, animated: true, completion: nil)
    }
    class func hide(){
        let instance = ElementalLoader.sharedLoader
        instance.currentLoaderVC!.dismissViewControllerAnimated(true, completion: nil)
    }
    
}


