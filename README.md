# ScrollViewPaging(Swift)
本控件增强UIScrollView的分页功能，提供自定义分页宽度、自动循环播放等功能。  

![image](https://github.com/cd826/ScrollViewPaging/blob/master/demo.gif?raw=true)

## 使用方法
```swift
class ScrollViewPagingDemoViewController: UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(scrollPagingView)
    
    // 添加你的Page view，如：
    let view1 = UIView(frame: CGRectZero)
    view1.backgroundColor = UIColor(red: 0xff/255.0, green: 0x2d/255.0, blue: 0x41/255.0, alpha: 1.0)
    view1.layer.borderColor = UIColor(red: 0xff/255.0, green: 0x2d/255.0, blue: 0x41/255.0, alpha: 1.0).CGColor
    view1.layer.borderWidth = 0.5
    view1.layer.cornerRadius = 5
    scrollPagingView.addPage(view1)

	  // 用户点击事件，如果需要的话        
    let tapGesture = UITapGestureRecognizer(target:self, action: #selector(ScrollViewPagingDemoViewController.scrollViewTapAction(_:)))
    scrollPagingView.addGestureRecognizer(tapGesture)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    // 设置大小，并初始化setup方法必须调用
    self.scrollPagingView.frame = CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 240)
    self.scrollPagingView.setup()    
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
```

