//
//  MineTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/16.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

public let kReloadUserData = "reloadUserData"

class MineTableViewController: UITableViewController {

    //MARK: - 控件加载
    @IBOutlet weak var accountNumberLB: UILabel!
    @IBOutlet weak var indentCell: UITableViewCell!
    @IBOutlet weak var endShopCell: UITableViewCell!
    //  用户名
    @IBOutlet weak var userNameBtn: UIButton!
    @IBOutlet weak var userNameBtnTop: NSLayoutConstraint!
    //  用户头像
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userImgTop: NSLayoutConstraint!
    //  用户认证
    @IBOutlet weak var approveBackView: UIView!
    @IBOutlet weak var approveImg: UIImageView!
    @IBOutlet weak var approveLB: UILabel!
    //账户
    
    fileprivate let indentArr:Array<Any> = ["已推订单", "已发资源", "已发产品", "急速抢单"]
    fileprivate let endShopArr:Array<Any> = ["视频", "推广工具", "文案教程"]
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfig()
        setupIndentCellUI()
        setupendShopCellUI()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadUserData), name: NSNotification.Name(rawValue: kReloadUserData), object: nil)
//        reloadUserData()
//        getUserData()
    }
    
    //基本配置
    func setupConfig() {
        view.backgroundColor = kHomeBackColor
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.tableHeaderView?.height = kNavHeight + 45
        userImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userImgClick(_:))))
        userImg.isUserInteractionEnabled = true
        
        userNameBtn.contentHorizontalAlignment = .left
        userNameBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0 )
        userNameBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        userNameBtnTop.constant = kStatusHeight + 10
        userImgTop.constant = kStatusHeight + 8
        let corners: UIRectCorner = [.topLeft,.bottomLeft]
        approveBackView.corner(with: approveBackView.bounds, corners: corners, radii: 15)
        approveLB.adjustsFontSizeToFitWidth = true
    }
    
    func setupIndentCellUI() {
        
        let labWidth = (indentCell.contentView.width-30) / 4
        
        for index in 0...indentArr.count-1 {
            let numberLB = UILabel()
            numberLB.textColor = kMainColor
            numberLB.textAlignment = .center
            numberLB.font = UIFont.systemFont(ofSize: 16)
            numberLB.tag = index + 1
            numberLB.text = "0"
            indentCell.contentView.addSubview(numberLB)
            
            let nameLB = UILabel()
            nameLB.textColor = kTitleColor
            nameLB.textAlignment = .center
            nameLB.font = UIFont.systemFont(ofSize: 12)
            nameLB.tag = (index + 1) * 10
            nameLB.text = indentArr[index] as? String
            indentCell.contentView.addSubview(nameLB)
            
            numberLB.snp.makeConstraints({ (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(labWidth * CGFloat(index))
                make.size.equalTo(CGSize(width: labWidth, height: 20))
            })
            
            nameLB.snp.makeConstraints({ (make) in
                make.top.equalTo(numberLB.snp.bottom).offset(8)
                make.left.equalTo(labWidth * CGFloat(index))
                make.size.equalTo(CGSize(width: labWidth, height: 20))
            })
        }
    }
    
    func setupendShopCellUI() {
        
        let labWidth = (endShopCell.contentView.width-30) / 4
        
        for index in 0...endShopArr.count-1 {
            let numberLB = UILabel()
            numberLB.textColor = kMainColor
            numberLB.textAlignment = .center
            numberLB.font = UIFont.systemFont(ofSize: 16)
            numberLB.tag = index + 10
            numberLB.text = "0"
            endShopCell.contentView.addSubview(numberLB)
            
            let nameLB = UILabel()
            nameLB.textColor = kTitleColor
            nameLB.textAlignment = .center
            nameLB.font = UIFont.systemFont(ofSize: 12)
            nameLB.tag = (index + 1) * 10
            nameLB.text = endShopArr[index] as? String
            endShopCell.contentView.addSubview(nameLB)
            
            numberLB.snp.makeConstraints({ (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(labWidth * CGFloat(index))
                make.size.equalTo(CGSize(width: labWidth, height: 20))
            })
            
            nameLB.snp.makeConstraints({ (make) in
                make.top.equalTo(numberLB.snp.bottom).offset(8)
                make.left.equalTo(labWidth * CGFloat(index))
                make.size.equalTo(CGSize(width: labWidth, height: 20))
            })
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
//        reloadUserData()
        getUserData()
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 3
        }else {
            return 4
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0, 0]:    //账户
            guard UserManager.shareManager.isLogin else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
                return
            }
            let vc = AccountViewController.loadStoryboard()
            navigationController?.pushViewController(vc, animated: true)
        case [0, 1]:    //微店订单
            guard UserManager.shareManager.isLogin else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
                return
            }
            guard UserManager.shareManager.userModel.is_audit == 4 else {
                JSProgress.showFailStatus(with: "还未认证成功")
                return
            }
            let vc = VStoreViewController.loadStoryboard()
            navigationController?.pushViewController(vc, animated: true)
        case [0, 2]:    //已购
            guard UserManager.shareManager.isLogin else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
                return
            }
            let vc = PurchasedViewController()
            navigationController?.pushViewController(vc, animated: true)
        case [1, 0]:    //认证
            guard UserManager.shareManager.isLogin else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
                return
            }
            let vc = ApproveSelectViewController()
            navigationController?.pushViewController(vc, animated: true)
        case [1, 1]:    //设置
            let vc = SettingViewController.loadStoryboard()
            navigationController?.pushViewController(vc, animated: true)
        case [1, 2]:    //常见问题
            let vc = CommonProblemViewController()
            navigationController?.pushViewController(vc, animated: true)
        case [1, 3]:    //关于我们
            let vc = AboutViewController.loadStoryboard()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
        
    }
    
    //MARK: - Method
    @IBAction func userNameBtnClick(_ sender: UIButton) {
        //如果用户没有登录就跳转到登录界面
        guard UserManager.shareManager.isLogin else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
            return
        }
    }
    
    @objc func userImgClick(_ sender: UIGestureRecognizer) {
        guard UserManager.shareManager.isLogin else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
            return
        }
        let vc = UserDataViewController.loadStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }

}

//MARK: - 数据处理部分
extension MineTableViewController {
    ///获取用户数据
    @objc func getUserData() {
        guard UserManager.shareManager.isLogin else {
            return
        }
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        NetWorksManager.requst(with: kUrl_UserData, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"][0] {
                    let userModel = UserModel(with: data)
                    UserManager.shareManager.userModel.is_audit = userModel.is_audit
                    UserManager.shareManager.userModel.tx = userModel.tx
                    UserManager.shareManager.userModel.account = userModel.account
                    UserManager.shareManager.userModel.wd_push_order = userModel.wd_push_order
                    UserManager.shareManager.userModel.wd_publish_resource = userModel.wd_publish_resource
                    UserManager.shareManager.userModel.wd_publish_product = userModel.wd_publish_product
                    UserManager.shareManager.userModel.wd_quick_bill = userModel.wd_quick_bill
                    UserManager.shareManager.userModel.buy_video = userModel.buy_video
                    UserManager.shareManager.userModel.buy_tools = userModel.buy_tools
                    UserManager.shareManager.userModel.buy_list = userModel.buy_list
                    UserManager.shareManager.userModel.buy_course = userModel.buy_course
                    self?.reloadUserData()
                }
            }else {
                if error == nil {
                    if let msg = jsonData?["msg_zhcn"].stringValue {
                        JSProgress.showFailStatus(with: msg)
                    }
                }else {
                    JSProgress.showFailStatus(with: "请求失败")
                }
            }
        }
    }
    ///刷新用户数据
    @objc func reloadUserData() {
        if UserManager.shareManager.isLogin {
            userNameBtn.setTitle(UserManager.shareManager.userModel.name, for: .normal)
            if !(UserManager.shareManager.userModel.tx.isEmpty) {
                userImg.setImage((UserManager.shareManager.userModel.tx), placeholder: nil, completionHandler: { [weak self] (image, error, cacheType, url) in
                    self?.userImg.circleImage()
                })
            }
            if UserManager.shareManager.userModel.is_audit == 4 {
                approveLB.text = UserManager.shareManager.userModel.getApproveType()
                approveImg.image = #imageLiteral(resourceName: "ICON-yirenzhen")
            }else {
                approveLB.text = UserManager.shareManager.userModel.getAuditStatus()
            }
        }else {
            userNameBtn.setTitle("未登录", for: .normal)
            userImg.image = #imageLiteral(resourceName: "ICON-MORENTOUXIANG")
            approveImg.image = #imageLiteral(resourceName: "ICON-weirenzhen")
            approveLB.text = "未认证"
        }
        accountNumberLB.text = String(UserManager.shareManager.userModel.account)
        for index in 0...indentArr.count-1 {
            let label = view.viewWithTag(index + 1) as? UILabel
            switch index {
            case 0: label?.text = String(UserManager.shareManager.userModel.wd_push_order)
            case 1: label?.text = String(UserManager.shareManager.userModel.wd_publish_resource)
            case 2: label?.text = String(UserManager.shareManager.userModel.wd_publish_product)
            case 3: label?.text = String(UserManager.shareManager.userModel.wd_quick_bill)
            default:break
            }
        }
        for index in 0...endShopArr.count-1 {
            let label = view.viewWithTag(index + 10) as? UILabel
            switch index {
            case 0: label?.text = String(UserManager.shareManager.userModel.buy_video)
            case 1: label?.text = String(UserManager.shareManager.userModel.buy_tools)
            case 2: label?.text = String(UserManager.shareManager.userModel.buy_course)
            default:break
            }
        }
    }
    
}
