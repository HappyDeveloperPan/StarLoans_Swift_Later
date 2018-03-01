//
//  RadioBtnView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/29.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

protocol RadioBtnViewDelegate: class {
    func selectRadioBtn(_ radioBtnView: RadioBtnView, index: Int)
}

class RadioBtnView: UIView {
    
    weak var delegate: RadioBtnViewDelegate?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
    }
    
    var currentTag:Int = 0
    var btnArr:[UIButton] = [UIButton]()
    //参数一：需要显示的内容数据，参数二：类型：1、横；2、竖
    func hSingleSelBtn(titleArray:NSArray, typeE aTypeE:Int) {
        
        let frameE:CGRect = self.frame
        let aWidthH:CGFloat = frameE.width
        let aHeightT:CGFloat = frameE.height
        
        if aTypeE==1 {
            //横向
//            let widthH:CGFloat = (aWidthH-20-30*CGFloat(titleArray.count))/CGFloat(titleArray.count)
            let widthH:CGFloat = aWidthH/CGFloat(titleArray.count)
            
            for i:Int in 0 ..< titleArray.count {
        
//                let btn = UIButton(frame: CGRect(x: 10+(widthH+20)*CGFloat(i), y: (aHeightT-16)/2, width: 16, height: 16))
                let btn = UIButton()
                self.addSubview(btn)
                btn.snp.makeConstraints({ (make) in
                    make.left.equalTo(widthH * CGFloat(i) + 5)
                    make.centerY.equalToSuperview()
                    make.size.equalTo(CGSize(width: 16, height: 16))
                })
                btn.setImage(#imageLiteral(resourceName: "ICON-weixuanzhong"), for: .normal)
                btn.setImage(#imageLiteral(resourceName: "ICON-xuanzhong"), for: .selected)
//                if i==0 {
//                    btn.isSelected = true
//                }else{
//                    btn.isSelected = false
//                }
                btn.tag = i+10000
                btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
                btnArr.append(btn)
                
//                let labelL = UILabel(frame: CGRect(x: 40+(widthH+20)*CGFloat(i), y: 0, width: widthH, height: aHeightT))
                let labelL = UILabel()
                labelL.text = titleArray[i] as? String
                labelL.adjustsFontSizeToFitWidth = true
                labelL.font = UIFont.systemFont(ofSize: 15)
                labelL.textColor = UIColor.RGB(with: 153, green: 153, blue: 153)
                self.addSubview(labelL)
                labelL.snp.makeConstraints({ (make) in
                    make.left.equalTo(btn.snp.right).offset(5)
                    make.centerY.equalToSuperview()
                    make.size.equalTo(CGSize(width: widthH - 26, height: aHeightT))
                })
            }
        }else{
            //纵向
            let hidthH = CGFloat(aHeightT / CGFloat(titleArray.count))
            
            for i:Int in 0 ..< titleArray.count {
                
                let btn = UIButton(frame: CGRect(x: 10, y: (hidthH-16)/2 + hidthH * CGFloat(i), width: 16, height: 16))
                btn.setImage(#imageLiteral(resourceName: "ICON-weixuanzhong"), for: .normal)
                btn.setImage(#imageLiteral(resourceName: "ICON-xuanzhong"), for: .selected)
                if i==0 {
                    btn.isSelected = true
                }else{
                    btn.isSelected = false
                }
                btn.tag = i+10000
                btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
                self.addSubview(btn)
                
//                let labelL = UILabel.init(frame: CGRectMake(40, hidthH * CGFloat(i), aWidthH, hidthH))
                let labelL = UILabel(frame: CGRect(x: 40, y: hidthH * CGFloat(i), width: aWidthH, height: hidthH))
                labelL.text = titleArray[i] as? String
                labelL.adjustsFontSizeToFitWidth = true
                self.addSubview(labelL)
            }
        }
        currentTag = 10000
    }
    
    @objc func btnClick(_ sender:UIButton) {
//        if !btn.isSelected {
//            btn.isSelected = !btn.isSelected
//            //上一个按钮还原
//            let buttonN = self.viewWithTag(currentTag) as? UIButton
//            buttonN?.isSelected = false
//
//            currentTag = btn.tag
//        }
        for btn in btnArr {
            if btn == sender {
                btn.isSelected = true
            }else {
                btn.isSelected = false
            }
        }
//        delegate?.selectRadioBtn(with: sender.tag - 10000)
        delegate?.selectRadioBtn(self, index: sender.tag - 10000)
    }

}
