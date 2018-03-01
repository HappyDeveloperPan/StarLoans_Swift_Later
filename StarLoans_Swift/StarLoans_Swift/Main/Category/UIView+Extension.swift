//
//  UIView+Extension.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 17/2/12.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

protocol StoryboardLoadable {}

extension StoryboardLoadable where Self: UIViewController {
    /// 提供 加载方法
    static func loadStoryboard(name: String? = nil) -> Self {
        let storyboard = UIStoryboard(name: "\(self)", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "\(self)") as! Self
    }
}

protocol LoadNibProtocol {}
/// --------------------- UIView extension ---------------------
extension LoadNibProtocol where Self: UIView {
    /// 提供加载XIB方法
    static func loadViewFromNib(name: String? = nil) -> Self {
        return Bundle.main.loadNibNamed(name ?? "\(self)", owner: nil, options: nil)?.last as! Self
    }
}

/// --------------------- Cell extension ---------------------
protocol RegisterCellOrNib {
}

extension RegisterCellOrNib {
    static var identifier: String {
        return "\(self)"
    }
    
    static var xib: UINib? {
        return UINib(nibName: "\(self)", bundle: nil)
    }
}

extension UIView {
    
    /// x
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
    
    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(with rect: CGRect, corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
        //切割的时候阴影也进行了切除，导致阴影显示不出来，就算阴影是添加在shape上，也是显示不出来的,可以用如下方式
//        self.layer.shadowColor = UIColor.orangeColor().CGColor
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowOffset = CGSizeMake(10, 10)
//        self.layer.shadowRadius = 5
//        self.layer.addSublayer(maskLayer)
    }
    
    
    /// 设置view半透明
    func translucence() {
        let shadeLayer = CAGradientLayer()
        shadeLayer.frame = self.bounds
        //设置渐变颜色数组,可以加透明度的渐变
        //        shadeLayer.colors = [(UIColor(white: 0, alpha: 0.5).cgColor as? Any), (UIColor(white: 0, alpha: 1).cgColor as? Any)]
        shadeLayer.colors = [UIColor(white: 0, alpha: 0).cgColor, UIColor(white: 0, alpha: 1).cgColor]
        //设置渐变区域的起始和终止位置（范围为0-1）
        shadeLayer.startPoint = CGPoint(x: 0, y: 0)
        shadeLayer.endPoint = CGPoint(x: 0, y: 0.8)
        //gradientLayer.locations = @[@(0.8f)];//设置渐变位置数组
        //注意：这里不用下边的这句话
        //[gradientView.layer addSublayer:gradientLayer];//将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
        //设置蒙版，用来改变layer的透明度
        self.layer.mask = shadeLayer
    }
    
    /// 增加是否在当前显示的窗口
    public func isShowingnKeyWindow() -> Bool {
        
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return false
        }
        
        //以主窗口的左上角为原点, 计算self的矩形框(谁调用这个方法这个self就是谁)
        let frame = keyWindow.convert(self.frame, from: self.superview)
        
        
        //判断主窗口的bounds和self的范围是否有重叠
        let isIntersects = frame.intersects(keyWindow.bounds)
        return isIntersects && !self.isHidden && self.alpha > 0 && self.window == keyWindow
    }
    
    public func addLine(with startPoint: CGPoint, endPoint: CGPoint) {
        let imageView = UIImageView(frame: self.frame)
        self.addSubview(imageView)
//        self.setNeedsDisplay()
//        self.setNeedsDisplay(self.frame)
        var scaledImage = UIImage()
        UIGraphicsBeginImageContext(self.frame.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setAllowsAntialiasing(true)
        context?.setLineCap(.round)
        context?.setStrokeColor(UIColor.RGB(with: 234, green: 234, blue: 234).cgColor)
        context?.setLineWidth(1)
        context?.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
        context?.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
        context?.strokePath()
        scaledImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        imageView.image = scaledImage
    }
    
}
