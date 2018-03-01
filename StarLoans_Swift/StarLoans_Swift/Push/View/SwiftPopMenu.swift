//
//  PopView.swift
//  TestSwift
//
//  Created by lyj on 16/5/7.
//  Copyright © 2016年 zyyj. All rights reserved.
//

import UIKit

public protocol SwiftPopMenuDelegate {
    func swiftPopMenuDidSelectIndex(index:Int)
}

public class SwiftPopMenu: UIView {
    
    public var delegate : SwiftPopMenuDelegate?
    
    
    let KScrW:CGFloat = UIScreen.main.bounds.size.width
    let KScrH:CGFloat = UIScreen.main.bounds.size.height
    
    private var myFrame:CGRect!

    private var arrowView : UIView! = nil
    private var arrowViewWidth : CGFloat = 15
    private var arrowViewHeight : CGFloat = 8
    
    
    //／*  -----------------------  可变参数 ------------------------------------------ *／
    
    //小箭头距离右边距离
    public var arrowViewMargin : CGFloat = 15
    //圆角弧度
    public var cornorRadius:CGFloat = 5
    
    //pop文字颜色
    public var popTextColor:UIColor = UIColor(red: 153 / 255.0, green: 153 / 255.0, blue: 153 / 255.0, alpha: 1.0)
    public var onSelectTextColor:UIColor = UIColor(red: 242 / 255.0, green: 56 / 255.0, blue: 61 / 255.0, alpha: 1.0)
    //pop背景色
    public var popMenuBgColor:UIColor = UIColor.white
    
    
    
    var tableView:UITableView! = nil
    public var popData:[(icon:String,title:String)]! = [(icon:String,title:String)](){
        didSet{
            //计算行高
            rowHeightValue = (self.myFrame.height - arrowViewHeight)/CGFloat(popData.count)
            initViews()
        }
        
    }
    
    
    public var didSelectMenuBlock:((_ index:Int)->Void)?
    
    
    static let cellID:String = "SwiftPopMenuCellID"
    var rowHeightValue:CGFloat = 44
    
    
   
    
    /**
     位置是popmenu相对整个屏幕的位置
     
     - parameter frame: <#frame description#>
     
     - returns: <#return value description#>
     */
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = CGRect(x: 0, y: 0, width: KScrW, height: KScrH)
        myFrame = frame
    }
    
    
    /// 位置是popmenu相对整个屏幕的位置
    ///
    /// - Parameters:
    ///   - frame: <#frame description#>
    ///   - arrowMargin: 箭头距离右边距离
    init(frame: CGRect,arrowMargin:CGFloat) {
        super.init(frame: frame)
        
        arrowViewMargin = arrowMargin
        self.frame = CGRect(x: 0, y: 0, width: KScrW, height: KScrH)
        myFrame = frame
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss()
    }
    
    public func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        self.alpha = 0
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.alpha = 1
        }) { (finish) in
        }
    }
    
    public func dismiss() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.alpha = 0
        }) { [weak self] (finish) in
            self?.removeFromSuperview()
        }
    }

    
    func initViews() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        //箭头
        arrowView=UIView(frame: CGRect(x: myFrame.origin.x, y: myFrame.origin.y, width: myFrame.width, height: arrowViewHeight))
        let layer=CAShapeLayer()
        let path=UIBezierPath()
        path.move(to: CGPoint(x:myFrame.width - arrowViewMargin - arrowViewWidth/2, y: 0))
        path.addLine(to: CGPoint(x: myFrame.width - arrowViewMargin - arrowViewWidth, y: arrowViewHeight))
        path.addLine(to: CGPoint(x: myFrame.width - arrowViewMargin, y: arrowViewHeight))
        layer.path=path.cgPath
        layer.fillColor = popMenuBgColor.cgColor
        arrowView.layer.addSublayer(layer)
        self.addSubview(arrowView)
        
        tableView=UITableView(frame: CGRect(x: myFrame.origin.x,y: myFrame.origin.y + arrowViewHeight,width: myFrame.width,height: myFrame.height - arrowViewHeight), style: .plain)
        tableView.register(SwiftPopMenuCell.classForCoder(), forCellReuseIdentifier: SwiftPopMenu.cellID)
        tableView.backgroundColor = popMenuBgColor
        tableView.layer.cornerRadius = cornorRadius
//        tableView.layer.masksToBounds = true
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        self.addSubview(tableView)
//        UIView.animate(withDuration: 0.3) { [weak self] in
//            self?.addSubview((self?.tableView)!)
//        }
        
    }
    
    //一个弹出视图动画
    func shakeToShow(aView: UIView) {
        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.duration = 0.5
        var values = [Any]()
        values.append(NSValue(caTransform3D: CATransform3DMakeScale(0.1, 0.1, 1.0)))
        values.append(NSValue(caTransform3D: CATransform3DMakeScale(1.2, 1.2, 1.0)))
        values.append(NSValue(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1.0)))
        values.append(NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
        animation.values = values
        aView.layer.add(animation, forKey: nil)
    }
    
}


class SwiftPopMenuCell: UITableViewCell {
    var iconImage:UIImageView!
    var lblTitle:UILabel!
    var line:UIView!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        iconImage = UIImageView()
        self.contentView.addSubview(iconImage)
        
        
        lblTitle = UILabel()
        lblTitle.font = UIFont.systemFont(ofSize: 14)
        lblTitle.textAlignment = .center
        self.contentView.addSubview(lblTitle)
        
        line = UIView()
        line.backgroundColor = UIColor(red: 222/255.0, green: 222/255.0, blue: 222/255.0, alpha: 0.5)
        self.contentView.addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(iconImage:String,title:String,textColor:UIColor,islast:Bool = false) {
        self.iconImage.image = UIImage(named: iconImage)
        self.lblTitle.text = title
        self.line.isHidden = islast
        lblTitle.textColor = textColor
        
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(self.bounds)
//        self.iconImage.frame = CGRect(x: 10, y: (self.bounds.size.height - 20)/2, width: 20, height: 20)
        self.lblTitle.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        self.line.frame = CGRect(x: 0, y: self.frame.size.height - 0.5, width: self.frame.size.width, height: 0.5)

    }
    
    
}

extension SwiftPopMenu : UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if popData.count>indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: SwiftPopMenu.cellID) as! SwiftPopMenuCell
            let model = popData[indexPath.row]
            if indexPath.row == popData.count - 1 {
                cell.fill(iconImage: model.icon, title: model.title,textColor: popTextColor, islast: true)
            }else{
                 cell.fill(iconImage: model.icon, title: model.title,textColor: popTextColor)
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension SwiftPopMenu : UITableViewDelegate{
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeightValue
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SwiftPopMenuCell
        cell.lblTitle?.textColor = onSelectTextColor
        if self.delegate != nil{
            self.delegate?.swiftPopMenuDidSelectIndex(index: indexPath.row)
        }
        if didSelectMenuBlock != nil {
            didSelectMenuBlock!(indexPath.row)
        }
        
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SwiftPopMenuCell
        cell.lblTitle?.textColor = popTextColor
    }
}
