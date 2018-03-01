//
//  MyTextView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/28.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class MyTextView: UITextView {

    let UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION: Double = 0.25
    var placeholder:String = ""
    var placeholderColor:UIColor?
    var placeHolderLabel:UILabel?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if placeholder.lengthOfBytes(using: .utf8) == 0 {
            placeholder = ""
        }
        if !(placeholderColor != nil) {
            placeholderColor = UIColor.lightGray
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.textChanged), name: .UITextViewTextDidChange, object: nil)
    }
    
//    init(frame: CGRect) {
//        super .init(frame: frame)
//
//        placeholder = ""
//        placeholderColor = UIColor.lightGray
//        NotificationCenter.default.addObserver(self, selector: #selector(self.textChanged), name: .UITextViewTextDidChange, object: nil)
//
//    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super .init(frame: frame, textContainer: textContainer)
        placeholder = ""
        placeholderColor = UIColor.lightGray
        NotificationCenter.default.addObserver(self, selector: #selector(self.textChanged), name: .UITextViewTextDidChange, object: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super .init(coder: aDecoder)
        placeholder = ""
        placeholderColor = UIColor.lightGray
        NotificationCenter.default.addObserver(self, selector: #selector(self.textChanged), name: .UITextViewTextDidChange, object: nil)
    }
    
    @objc func textChanged(_ notification: Notification?) {
        if placeholder.lengthOfBytes(using: .utf8) == 0 {
            return
        }
        UIView.animate(withDuration: UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION, animations: {() -> Void in
            if self.text.lengthOfBytes(using: .utf8) == 0 {
                self.viewWithTag(999)?.alpha = 1
            }
            else {
                self.viewWithTag(999)?.alpha = 0
            }
        })
    }
    
    func setText(_ text: String) {
        super.text = text
        textChanged(nil)
    }
    
    override func draw(_ rect: CGRect) {
        if placeholder.lengthOfBytes(using: .utf8) > 0 {
            if placeHolderLabel == nil {
                placeHolderLabel = UILabel(frame: CGRect(x: 8, y: 8, width: bounds.size.width - 8, height: 10))
                placeHolderLabel?.lineBreakMode = .byWordWrapping
                placeHolderLabel?.numberOfLines = 0
                placeHolderLabel?.font = font
                placeHolderLabel?.backgroundColor = UIColor.clear
                placeHolderLabel?.textColor = placeholderColor
                placeHolderLabel?.alpha = 0
                placeHolderLabel?.tag = 999
                addSubview(placeHolderLabel!)
            }
            placeHolderLabel?.text = placeholder
            placeHolderLabel?.sizeToFit()
            sendSubview(toBack: placeHolderLabel!)
        }
        if text.lengthOfBytes(using: .utf8) == 0 && placeholder.lengthOfBytes(using: .utf8) > 0 {
            viewWithTag(999)?.alpha = 1
        }
        super.draw(rect)
    }

}

