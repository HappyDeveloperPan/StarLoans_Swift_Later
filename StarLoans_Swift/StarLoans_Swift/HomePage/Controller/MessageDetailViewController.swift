//
//  MessageDetailViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/22.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class MessageDetailViewController: BaseViewController, StoryboardLoadable{
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var typeLB: UILabel!
    @IBOutlet weak var readNumLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var contentLB: UILabel!
    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "资讯详情"
        setupConfig()
    }
    
    func setupConfig() {
        contentLB.numberOfLines = 0
        contentLB.sizeToFit()
        contentLB.text = "奥斯卡记得付款话说尽快恢复还是看好房康师傅控件回家时刻发挥是否看见还是开发和收款方回克奥斯卡记得付款话说尽快恢复还是看好房康师傅控件回家时刻发挥是否看见还是开发和收款方回克奥斯卡记得付款话说尽快恢复还是看好房康师傅控件回家时刻发挥是否看见还是开发和收款方回克奥斯卡记得付款话说尽快恢复还是看好房康师傅控件回家时刻发挥是否看见还是开发和收款方回克奥斯卡记得付款话说尽快恢复还是看好房康师傅控件回家时刻发挥是否看见还是开发和收款方回克奥斯卡记得付款话说尽快恢复还是看好房康师傅控件回家时刻发挥是否看见还是开发和收款方回克奥斯卡记得付款话说尽快恢复还是看好房康师傅控件回家时刻发挥是否看见还是开发和收款方回克奥斯卡记得付款话说尽快恢复还是看好房康师傅控件回家时刻发挥是否看见还是开发和收款方回克奥斯卡记得付款话说尽快恢复还是看好房康师傅控件回家时刻发挥是否看见还是开发和收款方回克奥斯卡记得付款话说尽快恢复还是看好房康师傅控件回家时刻发挥是否看见还是开发和收款方回克奥斯卡记得付款话说尽快恢复还是看好房康师傅控件回家时刻发挥是否看见还是开发和收款方回克奥斯卡记得付款话说尽快恢复还是看好房康师傅控件回家时刻发挥是否看见还是开发和收款方回克奥斯卡记得付款话说尽快恢复还是看好房康师傅控件回家时刻发挥是否看见还是开发和收款方回克奥斯卡记得付款话说尽快恢复还是看好房康师傅控件回家时刻发挥是否看见还是开发和收款方回克奥斯卡记得付款话说尽快恢复还是看好房康师傅控件回家时刻发挥是否看见还是开发和收款方回克奥斯卡记得付款话说尽快恢复还是看好房康师傅控件回家时刻发挥是否看见还是开发和收款方回克奥斯卡记得付款话说尽快恢复还是看好房康师傅控件回家时刻发挥是否看见还是开发和收款方回克奥斯卡记得付款话说尽快恢复还是看好房康师傅控件回家时刻发挥是否看见还是开发和收款方回克"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        isNavLineHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        mainView.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenWidth)
        }
        mainView.layoutIfNeeded()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
