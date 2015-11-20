//
//  TBVerticalTabBar.swift
//  TBVerticalTabBarController
//
//  Created by ChenHao on 11/18/15.
//  Copyright © 2015 HarriesChen. All rights reserved.
//

import UIKit

class TBVerticalTabBar: UIView {

    var selectedIndex: Int = 0
    var itemsArray: Array<TBTabBarButton> = []
    var delegate: switchTabBarProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setItemArray(items: Array<UIViewController>) {
        for i in 0..<items.count {
            
            let item = items[i].tabBarItem
            let frame: CGRect = CGRect(x: 0.0, y: 20.0 + 78.0 * Double(i), width: 78, height: 78)
            let tabBar = TBTabBarButton(frame: frame, index: i)
            tabBar.setTitle(item.title, forState: .Normal)
            tabBar.setImage(item.image, forState: .Normal)
            tabBar.titleLabel?.font = UIFont.systemFontOfSize(14)
            let width: CGFloat = (tabBar.titleLabel?.bounds.size.width)!
            tabBar.imageEdgeInsets = UIEdgeInsetsMake(5,19,5,20)
            tabBar.titleEdgeInsets = UIEdgeInsetsMake(70, -width-39, 0, width)
            
            tabBar.addTarget(self, action: Selector("tabBarTouch:"), forControlEvents: .TouchUpInside)
            self.itemsArray.append(tabBar)
            self.addSubview(tabBar)
        }
    }
    
    func setSelectIndex(index: Int) {
        itemsArray[selectedIndex].setSelect(false)
        itemsArray[index].setSelect(true)
    }
    
    func tabBarTouch(button: TBTabBarButton) {
        if (delegate != nil) {
            itemsArray[selectedIndex].setSelect(false)
            button.selected = !button.selected
            button.setSelect(button.selected)
            selectedIndex = button.index
            delegate?.didChangeViewController(button.index)
        }
    }

    func adjustTabBar() {
        self.frame =  CGRect(x: 0, y: 0, width: self.frame.size.width, height: UIScreen.mainScreen().bounds.height)
    }
    
    override func drawRect(rect: CGRect) {

        let context = UIGraphicsGetCurrentContext()

        CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 1)
        CGContextMoveToPoint(context, 78, 0)
        CGContextAddLineToPoint(context, 78, UIScreen.mainScreen().bounds.height)
        CGContextStrokePath(context)
    }
}

protocol switchTabBarProtocol {

    func didChangeViewController(selectedIndex: Int)
}

