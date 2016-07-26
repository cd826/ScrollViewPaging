//
//  CDScrollViewEnhancer.swift
//  ScrollViewPaging
//
//  Created by CD826 on 16/7/25.
//  Copyright © 2016年 cd826. All rights reserved.
//

import UIKit

class CDScrollViewEnhancer: UIScrollView {
  var _scrollView: UIScrollView?
  
  override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
    if(self.pointInside(point, withEvent: event)) {
      return _scrollView
    }
    return nil
  }
}
