//
//  UIImageView+Extension.swift
//  News
//
//  Created by 杨蒙 on 2017/9/13.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    /// 设置圆形图片
    func circleImage() {
        // 建立上下文
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0)
        // 获取当前上下文
        let ctx = UIGraphicsGetCurrentContext()
        // 添加一个圆，并裁剪
        ctx?.addEllipse(in: self.bounds)
        ctx?.clip()
        // 绘制图像
        self.draw(self.bounds)
        // 获取绘制的图像
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        // 异步执行，防止阻塞主线程
        self.image = image
//        DispatchQueue.global().async {
//            self.image = image
//        }
    }
    
    ///绘制虚线
    func drawImaginaryLine(with color: UIColor) {
        UIGraphicsBeginImageContext(self.frame.size) // 位图上下文绘制区域
        self.image?.draw(in: self.bounds)
        
        let context:CGContext = UIGraphicsGetCurrentContext()!
        
        context.setLineCap(CGLineCap.square)
        
        context.setStrokeColor(color.cgColor)
        //画笔宽度
        context.setLineWidth(1)
        //lengths通常都包含两个数字，第一个是绘制的宽度，第二个表示跳过的宽度，也可以设置多个(比如: [10,20,10])，绘制按照先绘制，跳过，再绘制，再跳过，无限循环.
        let lengths:[CGFloat] = [2,2]
        //phase表示开始绘制之前跳过多少点进行绘制，默认一般设置为0
        context.setLineDash(phase: 0, lengths: lengths)
        //设置起始位置
        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: self.frame.width, y: 0))
        context.strokePath()
        
        self.image = UIGraphicsGetImageFromCurrentImageContext()
    }
    
    ///获取网络图片
    func setImage(with url: String) {
//        kf.setImage(with: URL(string: url)!)
        kf.setImage(with: URL(string: url))
    }
    
    ///获取网络图片
    func setImage(_ url: String, placeholder: UIImage?, completionHandler: @escaping CompletionHandler) {
        kf.setImage(with: URL(string: url), placeholder: placeholder, options: nil, progressBlock: nil) { (image, error, cacheType, url) in
            completionHandler(image, error, cacheType, url)
        }
    }
}
