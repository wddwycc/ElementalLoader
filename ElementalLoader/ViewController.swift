//
//  ViewController.swift
//  ElementalLoader
//
//  Created by Carrl on 15/8/13.
//  Copyright (c) 2015年 monk-studio. All rights reserved.
//

import UIKit
func delay(#seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

class ViewController: UIViewController {
    var loader:ElementalLoaderView?
    var showingLoader = false
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func didPressShowElementLoader(sender: AnyObject) {
        if(self.showingLoader == true){
            self.showingLoader = false
            self.loader?.removeFromSuperview()
            return;
        }
        self.loader = ElementalLoaderView()
        loader!.center = self.view.center
//        loader!.elementalColorStyle = ElementalColorStyle.forest
        self.view.addSubview(loader!)
        loader!.animationBegin()
        self.showingLoader = true
    }
    @IBAction func didPressShowAsGlobal(sender: AnyObject) {
        self.loader?.removeFromSuperview()
        
        
        ElementalLoader.showInViewController(self, withStyle: ElementalColorStyle.cold)
        //when you have done, use the code below
        delay(seconds: 2, {
            ElementalLoader.hide()
        })
    }
    
    
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



