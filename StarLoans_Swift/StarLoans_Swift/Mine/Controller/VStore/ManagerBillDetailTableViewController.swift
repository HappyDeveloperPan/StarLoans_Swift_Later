//
//  ManagerBillDisposeTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/7.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class ManagerBillDetailTableViewController: UITableViewController {
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var flowImgBack: UIStackView!
    @IBOutlet weak var flowOneImg: UIImageView!
    @IBOutlet weak var flowTwoImg: UIImageView!
    @IBOutlet weak var flowThreeImg: UIImageView!
    @IBOutlet weak var flowFourImg: UIImageView!
    @IBOutlet weak var flowFiveImg: UIImageView!
    //MARK: - 可操作数据
    fileprivate let sectionHeaderArr:[String] = ["基本信息", "资产信息"]
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasic()
    }
    
    func setupBasic() {
        //绘制横线
        let leftX = flowImgBack.x
        let width = flowOneImg.width
        let centerY = flowImgBack.centerY
        let spaceX = flowTwoImg.x - flowOneImg.x - width
        for index in 1...4 {
            headView.addLine(with: CGPoint(x: leftX+width * CGFloat(index) + spaceX * CGFloat(index-1), y: centerY), endPoint: CGPoint(x: leftX+(width+spaceX)*CGFloat(index), y: centerY))
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 5
        }else {
            return 7
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30))
        view.titleLB.text = sectionHeaderArr[section]
        return view
    }

}
