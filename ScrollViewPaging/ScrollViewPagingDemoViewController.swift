//
//  ScrollViewPagingDemoViewController.swift
//  ScrollViewPaging
//
//  Created by CD826 on 16/7/25.
//  Copyright © 2016年 cd826. All rights reserved.
//

import UIKit

class ScrollViewPagingDemoViewController: UIViewController {
  struct Static {
    static var dispatchOnceToken: dispatch_once_t = 0
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(scrollPagingView)
    
    let view1 = UIView(frame: CGRectZero)
    view1.backgroundColor = UIColor(red: 0xff/255.0, green: 0x2d/255.0, blue: 0x41/255.0, alpha: 1.0)
    view1.layer.borderColor = UIColor(red: 0xff/255.0, green: 0x2d/255.0, blue: 0x41/255.0, alpha: 1.0).CGColor
    view1.layer.borderWidth = 0.5
    view1.layer.cornerRadius = 5
    scrollPagingView.addPage(view1)
    
    let view2 = UIView(frame: CGRectZero)
    view2.backgroundColor = UIColor(red: 0x00/255.0, green: 0x7a/255.0, blue: 0xff/255.0, alpha: 1.0)
    view2.layer.borderColor = UIColor(red: 0x00/255.0, green: 0x7a/255.0, blue: 0xff/255.0, alpha: 1.0).CGColor
    view2.layer.borderWidth = 0.5
    view2.layer.cornerRadius = 5
    scrollPagingView.addPage(view2)
    
    let view3 = UIView(frame: CGRectZero)
    view3.backgroundColor = UIColor(red: 0x4b/255.0, green: 0xd9/255.0, blue: 0x64/255.0, alpha: 1.0)
    view3.layer.borderColor = UIColor(red: 0x4b/255.0, green: 0xd9/255.0, blue: 0x64/255.0, alpha: 1.0).CGColor
    view3.layer.borderWidth = 0.5
    view3.layer.cornerRadius = 5
    scrollPagingView.addPage(view3)
    
    let view4 = UIView(frame: CGRectZero)
    view4.backgroundColor = UIColor(red: 0xff/255.0, green: 0x96/255.0, blue: 0x00/255.0, alpha: 1.0)
    view4.layer.borderColor = UIColor(red: 0xff/255.0, green: 0x96/255.0, blue: 0x00/255.0, alpha: 1.0).CGColor
    view4.layer.borderWidth = 0.5
    view4.layer.cornerRadius = 5
    scrollPagingView.addPage(view4)
    
    let tapGesture = UITapGestureRecognizer(target:self, action: #selector(ScrollViewPagingDemoViewController.scrollViewTapAction(_:)))
    scrollPagingView.addGestureRecognizer(tapGesture)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    dispatch_once(&Static.dispatchOnceToken) {
      self.scrollPagingView.frame = CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 240)
      self.scrollPagingView.setup()
    }
  }
  
  private lazy var scrollPagingView: CDScrollPagingView = {
    let scrollPagingView = CDScrollPagingView()
    // 控制页与页之间的间隔，默认为10
    scrollPagingView.itemSpacing = 10.0
    // 是否显示分页指示器，默认显示
    scrollPagingView.showPageControl = true
    // 自动切换的时间间隔，默认为3s，0表示不自动切换
    scrollPagingView.timeInterval = 3.0
    return scrollPagingView
  }()
  
  func scrollViewTapAction(sender: CDScrollPagingView){
    if let curPage = scrollPagingView.currentPage() {
      let alertController = UIAlertController(title: "系统提示",
                                              message: "您点击第\(curPage)页", preferredStyle: .Alert)
      let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
      alertController.addAction(okAction)
      self.presentViewController(alertController, animated: true, completion: nil)
      
    }
  }
}
