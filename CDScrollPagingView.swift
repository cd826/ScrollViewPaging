//
//  CDScrollPagingView.swift
//  ScrollViewPaging
//
//  Created by CD826 on 16/7/25.
//  Copyright © 2016年 cd826. All rights reserved.
//

import UIKit

class CDScrollPagingView: UIView {
  var itemSpacing: CGFloat = 10.0
  var pageWidth: CGFloat = 0.85
  var showPageControl: Bool = true
  var timeInterval: NSTimeInterval = 3.0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }

  private func setupUI() {
    backgroundColor = UIColor.whiteColor()
    
    addSubview(_scrollView)
    
    _scrollViewEnhancer._scrollView = _scrollView
    addSubview(_scrollViewEnhancer)
  }
  
  private lazy var _scrollView: CDScrollView = {
    let scrollView = CDScrollView(frame: CGRectZero)
    scrollView.clipsToBounds = false
    return scrollView
  }()
  
  private lazy var _scrollViewEnhancer: CDScrollViewEnhancer = {
    let scrollViewEnhancer = CDScrollViewEnhancer()
    scrollViewEnhancer.opaque = true
    return scrollViewEnhancer
  }()
  
  func addPage(pageView: UIView) {
    _scrollView.addPage(pageView)
  }
  
  func currentPage() -> Int? {
    if let pageControl = _scrollView.pageControl {
      return pageControl.currentPage
    } else {
      return nil
    }
  }
  
  func setup() {
    _scrollViewEnhancer.frame = self.bounds
    if pageWidth <= 0 {
      pageWidth = 0.85
    }
    if pageWidth > 1 {
      pageWidth = 0.85
    }
    
    let _scrollViewWidth = self.bounds.width * pageWidth
    _scrollView.frame = CGRect(x: (self.bounds.width - _scrollViewWidth) / 2, y: 0, width: _scrollViewWidth, height: self.bounds.height)
    
    _scrollView.itemSpacing = itemSpacing
    _scrollView.showPageControl = showPageControl
    _scrollView.timeInterval = timeInterval
    _scrollView.setup()
  }
}
