//
//  QBDUserInfoTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/3.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class QBDUserInfoTableViewController: UITableViewController {
    //头像
    @IBOutlet weak var headImg: NSLayoutConstraint!
    //姓名
    @IBOutlet weak var userNameLB: UILabel!
    //客户类型
    @IBOutlet weak var userTypeLB: UILabel!
    //职业
    @IBOutlet weak var professionLB: UILabel!
    //社保
    @IBOutlet weak var socialSecurityLB: UILabel!
    //公积金
    @IBOutlet weak var providentFundLB: UILabel!
    //工资发放形式
    @IBOutlet weak var salaryTypeLB: UILabel!
    //手机号码
    @IBOutlet weak var phoneNumLB: UILabel!
    
    //MARK: - 外部属性
//    var clientModel = ClientInfoModel()
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasic()
//        setBasicData()
    }
    
    func setupBasic() {
        tableView.tableFooterView = UIView(frame: .zero)
        userTypeLB.layer.backgroundColor = kMainColor.cgColor
        userTypeLB.layer.cornerRadius = userTypeLB.height/2
    }
    
    func setBasicData(_ clientModel: ClientInfoModel) {
//        if !clientModel..isEmpty {
//            userImg.setImage(infoModel.questioner_tx, placeholder: nil, completionHandler: { [weak self] (image, error, cacheType, url) in
//                self?.userImg.circleImage()
//            })
//        }
        userNameLB.text = clientModel.client_name
        userTypeLB.text = clientModel.client_type_name
        professionLB.text = clientModel.client_occupation_name
        if clientModel.client_is_social_security.getServiceBool() {
           socialSecurityLB.text = "有社保"
        }else {
           socialSecurityLB.text = "无社保"
        }
        if clientModel.client_is_accumulated_funds.getServiceBool() {
            providentFundLB.text = "有公积金"
        }else {
            providentFundLB.text = "无公积金"
        }
        salaryTypeLB.text = clientModel.client_income_payment_type_name
        phoneNumLB.text = clientModel.client_phone
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        //        let vc1 = segue.destination as! QBDUserInfoTableViewController
//        //        vc1.clientModel = clientModel
//        let vc2 = segue.destination as! QBDPropertyTableViewController
//        vc2.clientModel = clientModel
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
