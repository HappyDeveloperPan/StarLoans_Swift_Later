//
//  UserDataTableViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/4.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class UserDataTableViewController: UITableViewController {
    //MARK: - Storyboard连线
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var phoneNumLB: UILabel!
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        setupBasicData()
    }
    
    func setupBasicData() {
        if !(UserManager.shareManager.userModel.tx.isEmpty) {
            headImg.setImage((UserManager.shareManager.userModel.tx), placeholder: nil, completionHandler: { [weak self] (image, error, cacheType, url) in
                self?.headImg.circleImage()
            })
        }
        phoneNumLB.text = UserManager.shareManager.userModel.phone
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            uploadsPic()
        default: break
        }
    }
    
    //MARK: - 控件点击事件
    ///选择头像
    func uploadsPic() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let selectOne = UIAlertAction(title: "拍照", style: .default) { [weak self] (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                //初始化图片控制器
                let picker = UIImagePickerController()
                //设置代理
                picker.delegate = self
                //指定图片控制器类型
                picker.sourceType = UIImagePickerControllerSourceType.camera
                //设置是否允许编辑
                picker.allowsEditing = true
                //弹出控制器，显示界面
                self?.present(picker, animated: true, completion: {
                    () -> Void in
                })
            }else {
                JSProgress.showFailStatus(with: "相机不可用")
            }
        }
        let selectTwo = UIAlertAction(title: "从手机相册选择", style: .default) { [weak self] (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                //初始化图片控制器
                let picker = UIImagePickerController()
                //设置代理
                picker.delegate = self
                //指定图片控制器类型
                picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                //设置是否允许编辑
                picker.allowsEditing = true
                //弹出控制器，显示界面
                self?.present(picker, animated: true, completion: {
                    () -> Void in
                })
            }else {
                JSProgress.showFailStatus(with: "相册不可访问")
            }
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(selectOne)
        alertController.addAction(selectTwo)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }

}

extension UserDataTableViewController {
    ///修改头像
    func modifyHeadImg(_ img: UIImage) {
        var parameters = [String: Any]()
        parameters["token"] = UserManager.shareManager.userModel.token
        parameters["img"] = UIImageJPEGRepresentation(img, 0.5)
        
        JSProgress.showBusy()
        
        NetWorksManager.uploadImages(with: kUrl_ModifyHeadImg, parameters: parameters, success: { [weak self] (jsonData) in
            
            JSProgress.hidden()
            
            if jsonData?["status"] == 200 {
                self?.headImg.image = img
                self?.headImg.circleImage()
//                JSProgress.showSucessStatus(with: "修改成功")
            }else {
                if let msg = jsonData?["msg_zhcn"].stringValue {
                    JSProgress.showFailStatus(with: msg)
                }
            }
        }) { (error) in
            JSProgress.hidden()
            JSProgress.showFailStatus(with: "上传失败")
        }
        
    }
}

//MARK: - 相册代理
extension UserDataTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //查看info对象
        print(info)
        //显示的图片
        let image:UIImage!
        image = info[UIImagePickerControllerEditedImage] as! UIImage
        modifyHeadImg(image)
//        headImg.image = image
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
    }
}
