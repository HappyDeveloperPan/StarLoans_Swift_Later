//
//  String+Extension.swift
//  BSBDJ
//
//  Created by apple on 2017/11/6.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

extension String {
    
    /// 获取高度计算
    ///
    /// - Parameters:
    ///   - size: 矩形已知范围
    ///   - attributes: 文字属性
    /// - Returns: 高度
    public func height(_ size: CGSize, _ attributes: [NSAttributedStringKey: Any]?) -> CGFloat {

        let string = self as NSString

        let stringSize = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

        return stringSize.height

    }
    /// 获取宽度计算
    ///
    /// - Parameters:
    ///   - size: 矩形已知范围
    ///   - attributes: 文字属性
    /// - Returns: 宽度
    public func width(_ size: CGSize, _ attributes: [NSAttributedStringKey: Any]?) -> CGFloat {

        let string = self as NSString

        let stringSize = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

        return stringSize.width

    }
    
    /// 判断手机号
    ///
    /// - Parameter mobileNum: 手机号码
    /// - Returns: 判断结果Bool类型
    public func judgeMobileNumber() -> Bool {
        let MOBILE = "^1(3[0-9]|4[57]|5[0-35-9]|7[01678]|8[0-9])\\d{8}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", MOBILE)
        return regextestmobile.evaluate(with: self)
    }
    
    ///判断网址
    public func judgeURL() -> Bool {
        let MOBILE = "^(http|https)://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", MOBILE)
        return regextestmobile.evaluate(with: self)
    }
    
    /// MD5加密
    var md5 : String{
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        
        return String(format: hash as String)
    }
    
    // 判断输入的字符串是否为数字，不含其它字符
    
    func isPurnInt() -> Bool {
        
        let scan: Scanner = Scanner(string: self)
        
        var val:Int = 0
        
        return scan.scanInt(&val) && scan.isAtEnd
        
    }
    
}
