//
//  JSProgress.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/27.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

//+ (void)show;    显示:状态是一个迅速转动的圈
//+ (void)showWithMaskType:(SVProgressHUDMaskType)maskType; 显示并且带着一个状态
//+ (void)showWithStatus:(NSString*)status; 显示并且带着文字
//+ (void)showWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType;
//
//+ (void)showProgress:(float)progress;  //显示进度:状态是一个进度圈
//+ (void)showProgress:(float)progress maskType:(SVProgressHUDMaskType)maskType;
//+ (void)showProgress:(float)progress status:(NSString*)status;
//+ (void)showProgress:(float)progress status:(NSString*)status maskType:(SVProgressHUDMaskType)maskType;
//
//+ (void)setStatus:(NSString*)string; // 改变正显示着的HUD的文字
//
//// stops the activity indicator, shows a glyph + status, and dismisses HUD a little bit later
//+ (void)showInfoWithStatus:(NSString *)string;   //显示消息信息，其实就是中心图片更换了
//+ (void)showInfoWithStatus:(NSString *)string maskType:(SVProgressHUDMaskType)maskType;
//
//+ (void)showSuccessWithStatus:(NSString*)string; //显示成功消息
//+ (void)showSuccessWithStatus:(NSString*)string maskType:(SVProgressHUDMaskType)maskType;
//
//+ (void)showErrorWithStatus:(NSString *)string; //显示错误消息
//+ (void)showErrorWithStatus:(NSString *)string maskType:(SVProgressHUDMaskType)maskType;
//
//// use 28x28 white pngs
//+ (void)showImage:(UIImage*)image status:(NSString*)status; //显示自己设置的图片,图片大小事28 * 28 px
//+ (void)showImage:(UIImage*)image status:(NSString*)status maskType:(SVProgressHUDMaskType)maskType;
//
//+ (void)setOffsetFromCenter:(UIOffset)offset; //距离中心点的偏移量
//+ (void)resetOffsetFromCenter; //返回中心点
//
//+ (void)popActivity; // 消除一个HUD，根据其实现方法如果前面有执行了好几次show方法，如果给定的progress == 0 或者 pregress < 0那样就会让使一个参数+1，执行这个方法会使那个参数-1，如果参数==0时 执行dismiss方法。
//+ (void)dismiss; 消失
//
//+ (BOOL)isVisible; 是否正在显示

import UIKit
import SVProgressHUD

class JSProgress: NSObject {
    
    
    /// 默认加载
    class func showBusy() {
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.clear)
    }
    
    ///文字加载
    class func showBusy(with title: String) {
        SVProgressHUD.show(withStatus: title)
        SVProgressHUD.setDefaultMaskType(.clear)
    }
    
    ///显示文字提示
    class func showInfoWithStatus(with status: String) {
        SVProgressHUD.showInfo(withStatus: status)
        SVProgressHUD.dismiss(withDelay: 2)
    }
    
    ///显示成功提示
    class func showSucessStatus(with status: String) {
        SVProgressHUD.showSuccess(withStatus: status)
        SVProgressHUD.dismiss(withDelay: 2)
    }
    
    ///显示失败提示
    class func showFailStatus(with status: String) {
        SVProgressHUD.showError(withStatus: status)
        SVProgressHUD.dismiss(withDelay: 2)
    }
    
    ///改变正在显示的文字
    class func changeStatus(with status: String) {
        SVProgressHUD.setStatus(status)
    }
    
    ///显示进度
    class func showProgress(with progress: Float) {
        SVProgressHUD.showProgress(progress)
    }
    
    ///关闭试图
    class func hidden() {
        SVProgressHUD.dismiss()
        SVProgressHUD.setDefaultMaskType(.none)
    }
}
