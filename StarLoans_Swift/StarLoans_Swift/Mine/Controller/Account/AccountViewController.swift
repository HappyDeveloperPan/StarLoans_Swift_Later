//
//  AccountViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/18.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, StoryboardLoadable {
    //MARK: - 懒加载
    lazy var detailBtn: UIButton = { [unowned self] in
        let detailBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        detailBtn.setTitle("明细", for: .normal)
        detailBtn.setTitleColor(kTitleColor, for: .normal)
        detailBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        detailBtn.addTarget(self, action: #selector(detailBtnClick(_:)), for: .touchUpInside)
        return detailBtn
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "账户"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: detailBtn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func detailBtnClick(_ sender: UIButton) {
        let vc = MoneyDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
