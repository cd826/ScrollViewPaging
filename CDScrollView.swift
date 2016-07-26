//
//  CDScrollView.swift
//  ScrollViewPaging
//
//  Created by CD826 on 16/7/25.
//  Copyright © 2016年 cd826. All rights reserved.
//

import UIKit

class CDScrollView: UIScrollView, UIScrollViewDelegate {
  var viewObjects: [UIView]?
  var itemSpacing: CGFloat = 0.0
  var numPages: Int = 0
  var pageControl: UIPageControl?
  var showPageControl: Bool = true
  var timer: NSTimer?
  var timeInterval: NSTimeInterval = 3.0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupUI() {
    pagingEnabled = true
    showsHorizontalScrollIndicator = false
    showsVerticalScrollIndicator = false
    clipsToBounds = false
    scrollsToTop = false
    delegate = self
  }
  
  func addPage(pageView: UIView) {
    if (viewObjects == nil) {
      viewObjects = [UIView]()
    }
    
    viewObjects?.append(pageView)
    numPages = (viewObjects?.count)!
  }
  
  func setup() {
    contentSize = CGSize(width: (frame.size.width * (CGFloat(numPages) + 2)), height: frame.size.height)
    
    guard let parent = superview else { return }
    
    if pageControl == nil {
      pageControl = UIPageControl(frame: CGRect(x: 0, y: parent.frame.size.height - 25, width: parent.frame.size.width, height: 25))
      pageControl?.pageIndicatorTintColor = UIColor(red: 0x99/255.0, green: 0x99/255.0, blue: 0x99/255.0, alpha: 0.2)
      pageControl?.userInteractionEnabled = true
      pageControl?.addTarget(self, action: #selector(pageChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    pageControl?.numberOfPages = numPages
    pageControl?.currentPage = 0
    pageControl?.hidden = !showPageControl
    parent.addSubview(pageControl!)
    
    loadScrollViewWithPage(0)
    loadScrollViewWithPage(1)
    loadScrollViewWithPage(2)
    
    var newFrame = frame
    newFrame.origin.x = newFrame.size.width
    newFrame.origin.y = 0
    scrollRectToVisible(newFrame, animated: false)
    
    layoutIfNeeded()
    
    // 先移除旧的定时器，避免多次初始化造成的重复
    removeTimer()
    if timeInterval > 0 {
      addTimer()
    }
  }
  
  // 开启定时器
  func addTimer() {
    timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: #selector(CDScrollView.change(_:)), userInfo: nil, repeats: true)
  }
  
  // 关闭定时器
  func removeTimer() {
    timer?.invalidate()
  }

  private func loadScrollViewWithPage(page: Int) {
    if page < -1 {
      return
    }
    if page > numPages + 2 {
      return
    }
    
    var index = 0
    if page == -1 {
      index = numPages - 2
    } else if page == 0 {
      index = numPages - 1
    } else if page == numPages + 1 {
      index = 0
    } else if page == numPages + 2 {
      index = 1
    } else {
      index = page - 1
    }
    
    let view = viewObjects?[index]
    view?.frame = CGRect(x: frame.size.width * CGFloat(page) + itemSpacing / 2, y: 0, width: frame.size.width - itemSpacing, height: frame.size.height)
    if view?.superview == nil {
      addSubview(view!)
    }
    
    layoutIfNeeded()
  }
  
  // MARK: - ScrollView的事件响应
  func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    removeTimer()
  }
  
  func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if timeInterval > 0 {
      addTimer()
    }
  }

  @objc internal func scrollViewDidScroll(scrollView: UIScrollView) {
    let pageWidth = frame.size.width
    let page = floor((contentOffset.x - (pageWidth / 2)) / pageWidth) + 1
    if Int(page) == (numPages + 1) {
      pageControl?.currentPage = 0
    } else {
      pageControl?.currentPage = Int(page - 1)
    }
    
    loadScrollViewWithPage(Int(page - 1))
    loadScrollViewWithPage(Int(page))
    loadScrollViewWithPage(Int(page + 1))
  }
  
  @objc internal func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    let pageWidth = frame.size.width
    let page : Int = Int(floor((contentOffset.x - (pageWidth / 2)) / pageWidth) + 1)
    
    if page == 0 {
      contentOffset = CGPoint(x: pageWidth*(CGFloat(numPages)), y: 0)
    } else if page == numPages + 1 {
      contentOffset = CGPoint(x: pageWidth, y: 0)
    }
  }
  
  func pageChanged(sender: UIPageControl) {
    let page = sender.currentPage
    let pageWidth = frame.size.width
    setContentOffset(CGPointMake((CGFloat(page + 1)) * pageWidth, 0), animated: true)
    self.performSelector(#selector(CDScrollView.scrollViewDidEndDecelerating(_:)), withObject: nil, afterDelay: 0.8)
  }
  
  func change(timer: NSTimer) {
    let page = (pageControl?.currentPage)! + 1
    let pageWidth = frame.size.width
    setContentOffset(CGPointMake((CGFloat(page + 1)) * pageWidth, 0), animated: true)
    self.performSelector(#selector(CDScrollView.scrollViewDidEndDecelerating(_:)), withObject: nil, afterDelay: 0.8)
  }
}
