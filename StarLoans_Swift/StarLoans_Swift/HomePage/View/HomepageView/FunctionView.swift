//
//  FunctionView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/30.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

@objc protocol FunctionViewDelegate {
//    /// 点击图片回调
//    func topAdverViewDidSelect(at index:Int, cycleScrollView:WRCycleScrollView)
//    /// 图片滚动回调
//    func topAdverViewDidScroll(to index:Int, cycleScrollView:WRCycleScrollView)
    
    func buttonDidSelect(at index: Int)
}

//MARK: - 功能栏
class FunctionView: UIView {
    
    var imagesArr: Array<UIImage> = [#imageLiteral(resourceName: "ICON-hangyeziyuan"), #imageLiteral(resourceName: "ICON-daikuanxueyuan"), #imageLiteral(resourceName: "ICON-tuiguanggongju"), #imageLiteral(resourceName: "ICON-meiriqiandao"), #imageLiteral(resourceName: "ICON-zixunyandu"), #imageLiteral(resourceName: "ICON-video")]
    var listArr: Array<String> = ["行业资源", "贷款学院", "推广工具", "每日签到", "资讯研读", "视频中心"]
    
    // 标识子控件是否布局完成，布局完成后在layoutSubviews方法中就不执行
    fileprivate var isLoadOver = false
    
    weak var delegate:FunctionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        createBtn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        if isLoadOver == false {
            
            let left = width/3
            let btnW = width/3
            let btnH = height/2
            
            for index in 0...5 {
                let button = viewWithTag(index + 1) as? FuncButton
                if index < 3 {
                    button?.snp.makeConstraints({ (make) in
                        make.left.equalTo(left * CGFloat(index))
                        make.top.equalToSuperview()
                        make.size.equalTo(CGSize(width: btnW, height: btnH))
                    })
                }else {
                    button?.snp.makeConstraints({ (make) in
                        make.left.equalTo(left * CGFloat(index - 3))
                        make.top.equalTo(btnH)
                        make.size.equalTo(CGSize(width: btnW, height: btnH))
                    })
                }
            }
            isLoadOver = true
        }
    }
    
    
    func createBtn() {
        for index in 0...5 {
            let funcBtn = FuncButton()
            addSubview(funcBtn)
            funcBtn.tag = index + 1
            funcBtn.setTitle(listArr[index], for: .normal)
            funcBtn.setImage(imagesArr[index], for: .normal)
            funcBtn.addTarget(self, action: #selector(funcBtnClick(_:)), for: .touchUpInside)
        }
    }
    
    //按钮点击
    @objc func funcBtnClick(_ button: UIButton) {
//        print("第\(button.tag)个按钮被点击了")
        delegate?.buttonDidSelect(at: button.tag)
    }
}

//MARK: - 自定义功能按钮
class FuncButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置按钮的基本属性
    func commonInit() {
        titleLabel?.textAlignment = .center
        imageView?.contentMode = .scaleAspectFit
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        setTitleColor(kTextColor, for: .normal)
    }
    
    //调整系统UIButton的文字的位置
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleX = 0
        let titleY = contentRect.size.height * 0.6
        let titleW = contentRect.size.width
        let titleH = contentRect.size.height - titleY
        return CGRect(x: CGFloat(titleX), y: titleY, width: titleW, height: titleH)
    }
    
    //调整系统UIButton的图片的位置
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageW = contentRect.size.width
        let imageH = contentRect.size.height * 0.3
        return CGRect(x: 0, y: 27.5, width: imageW, height: imageH)
    }
}
