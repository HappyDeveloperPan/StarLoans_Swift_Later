//
//  CommitCompleteViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/30.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class CommitCompleteViewController: BaseViewController, StoryboardLoadable{
    @IBOutlet weak var completeImg: UIImageView!
    @IBOutlet weak var returnBtn: UIButton!
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: - 根据状态修改
        title = "提交成功"
        returnBtn.layer.cornerRadius = returnBtn.height/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        isNavLineHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnBtnClick(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
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
