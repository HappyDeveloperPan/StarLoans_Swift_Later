//
//  PickerView.swift
//  Mhome
//
//  Created by mHome on 2017/6/9.
//  Copyright © 2017年 mHome. All rights reserved.
//

import UIKit

fileprivate let PICKERHEIGHT: CGFloat = 216
fileprivate let BGHEIGHT: CGFloat = 256
fileprivate let BGWIDTH = UIScreen.main.bounds.width
fileprivate let KEY_WINDOW_HEIGHT = UIApplication.shared.keyWindow?.frame.size.height

class PickerView: UIView ,UIPickerViewDelegate,UIPickerViewDataSource{
    

    //定义一个闭包
    var changeTitleAndClosure:((_ title:String,_ num:Int) -> Void)?
//    var nameArr : NSMutableArray!
    var nameArr: [Any] = [Any]()
    //MARK: - 懒加载
    fileprivate lazy var bgView: UIView = {
        let view = UIView()
        view.frame = CGRect.init(x: 0, y: UIScreen.main.bounds.height, width: BGWIDTH, height: BGHEIGHT)
        view.backgroundColor = UIColor.white
        return view
    }()
    fileprivate lazy var pickerView :UIPickerView = { [unowned self] in
        let pv = UIPickerView()
        pv.frame = CGRect.init(x: 0, y: BGHEIGHT - PICKERHEIGHT, width: BGWIDTH, height: PICKERHEIGHT)
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    fileprivate lazy var toolBarView: UIView = { [unowned self] in
        let tv = UIView()
        tv.frame = CGRect.init(x: 0, y: 0, width: BGWIDTH, height: BGHEIGHT - PICKERHEIGHT)
        tv.backgroundColor = UIColor.groupTableViewBackground
        return tv
    }()
    
    fileprivate lazy var cancleBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.frame = CGRect.init(x: 10, y: 5, width: 50, height: BGHEIGHT - PICKERHEIGHT - 10)
        btn.setTitle("取消", for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
//        btn.layer.cornerRadius = 5
//        btn.backgroundColor = UIColor.orange
        btn.setTitleColor(kTitleColor, for: .normal)
        btn.addTarget(self, action: #selector(cancleBtnClick), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    fileprivate lazy var sureBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.frame = CGRect.init(x: BGWIDTH - 60, y: 5, width: 50, height: BGHEIGHT - PICKERHEIGHT - 10)
        btn.setTitle("确定", for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
//        btn.layer.cornerRadius = 5
//        btn.backgroundColor = UIColor.orange
        btn.setTitleColor(kMainColor, for: .normal)
        btn.addTarget(self, action: #selector(sureBtnClick), for: UIControlEvents.touchUpInside)
        
        return btn
        
    }()
    //MARK: - 生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = kMainScreenFrame
        
        self.bgView.addSubview(self.pickerView)
        self.bgView.addSubview(self.toolBarView)
        self.toolBarView.addSubview(self.cancleBtn)
        self.toolBarView.addSubview(self.sureBtn)
        self.addSubview(bgView)
        showPickerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //showPickerView
    func showPickerView() -> Void {
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.bgView.frame = CGRect.init(x: 0, y: KEY_WINDOW_HEIGHT! - BGHEIGHT, width: BGWIDTH, height: BGHEIGHT)
        }
    }
    
    //hidePickerView
    func hidePickerView() -> Void {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.bgView.frame = CGRect.init(x: 0, y: KEY_WINDOW_HEIGHT!, width: BGWIDTH, height: BGHEIGHT)
            self.alpha = 0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    //取消按钮
    @objc func cancleBtnClick()  {
        self.hidePickerView()
    }
    
    //确定按钮
    @objc func sureBtnClick()  {
        let value = pickerView.selectedRow(inComponent: 0)
//        print(nameArr[value])
//        changeTitleAndClosure?(String(describing: nameArr[value]),value)
        if nameArr.count != 0 {
            changeTitleAndClosure?(String(stringInterpolationSegment: nameArr[value]),value)
        }
//        changeTitleAndClosure?(String(stringInterpolationSegment: nameArr[value]),value)
        self.hidePickerView()
    }
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nameArr.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return nameArr[row] as? String
        return String(stringInterpolationSegment: nameArr[row])
    }
    override func  touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.hidePickerView()
    }
    
}
