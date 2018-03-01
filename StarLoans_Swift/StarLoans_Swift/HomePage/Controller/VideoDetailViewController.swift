//
//  VideoDetailViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/25.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class VideoDetailViewController: BaseViewController, StoryboardLoadable {

    var videoID: Int = 0
    var videoModel: VideoModel = VideoModel()
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var videoImg: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var videoTypeLB: UILabel!
    @IBOutlet weak var readNumLB: UILabel!
    @IBOutlet weak var topTimeLB: UILabel!
    
    @IBOutlet weak var themeLB: UILabel!
    @IBOutlet weak var themeContent: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var timeContent: UILabel!
    @IBOutlet weak var mainGuestLb: UILabel!
    @IBOutlet weak var mainGuestContent: UILabel!
    @IBOutlet weak var sponsorLB: UILabel!
    @IBOutlet weak var sponsorContent: UILabel!
    @IBOutlet weak var durationLB: UILabel!
    @IBOutlet weak var durationContent: UILabel!
    @IBOutlet weak var videoIntroLB: UILabel!
    @IBOutlet weak var videoIntroContent: UILabel!
    @IBOutlet weak var freePlayBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "视频详情"
        setupBasic()
        getVideoDetailData()
    }
    
    func setupBasic() {
        videoImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(videoImgClick(_:))))
        videoImg.isUserInteractionEnabled = true
        videoTypeLB.layer.backgroundColor = UIColor.RGB(with: 248, green: 225, blue: 225).cgColor
        videoTypeLB.layer.cornerRadius = videoTypeLB.height/2
        readNumLB.sizeToFit()
        themeLB.textAlignmentLeftAndRight()
        timeLB.textAlignmentLeftAndRight()
        mainGuestLb.textAlignmentLeftAndRight()
        sponsorLB.textAlignmentLeftAndRight()
        durationLB.textAlignmentLeftAndRight()
        videoIntroLB.textAlignmentLeftAndRight()
        videoIntroContent.numberOfLines = 0
        videoIntroContent.sizeToFit()
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        mainView.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenWidth)
        }
        
        freePlayBtn.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenWidth/2)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func freePlayClick(_ sender: UIButton) {
        guard UserManager.shareManager.isLogin else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
            return
        }
        guard UserManager.shareManager.userModel.is_audit == 4 else {
            
            if UserManager.shareManager.userModel.is_audit == 2{
                JSProgress.showFailStatus(with: "审核中")
            }else {
                let vc = ApproveSelectViewController()
                navigationController?.pushViewController(vc, animated: true)
            }
            return
        }
        let vc = VideoPlayViewController()
        vc.videoModel = videoModel
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func videoImgClick(_ sender: UIGestureRecognizer) {
        guard UserManager.shareManager.isLogin else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
            return
        }
        guard UserManager.shareManager.userModel.is_audit == 4 else {
            
            if UserManager.shareManager.userModel.is_audit == 2{
                JSProgress.showFailStatus(with: "审核中")
            }else {
                let vc = ApproveSelectViewController()
                navigationController?.pushViewController(vc, animated: true)
            }
            return
        }
        let vc = VideoPlayViewController()
        vc.videoModel = videoModel
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension VideoDetailViewController {
    func getVideoDetailData() {
        
        let parameters = ["video_id": videoID] as [String: Any]
        
        JSProgress.showBusy()
        
        NetWorksManager.requst(with: kUrl_VideoDetail, type: .post, parameters: parameters) { [weak self](jsonData, error) in
            
            JSProgress.hidden()
            
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"][0] {
                    self?.videoModel = VideoModel(with: data)
                    self?.videoImg.setImage(with: (self?.videoModel.video_img)!)
                    self?.titleLB.text = self?.videoModel.video_title
                    self?.videoTypeLB.text = self?.videoModel.getVideoType()
                    self?.readNumLB.text = String((self?.videoModel.video_view_count)!)
                    self?.topTimeLB.text = self?.videoModel.video_duration
                    self?.themeContent.text = self?.videoModel.video_theme
                    self?.timeContent.text = Utils.getDateToYMD(with: (self?.videoModel.video_upload_time)!)
                    self?.sponsorContent.text = self?.videoModel.video_sponsor
                    self?.mainGuestContent.text = self?.videoModel.video_speakers
                    self?.durationContent.text = self?.videoModel.video_duration
                    self?.videoIntroContent.text = self?.videoModel.video_desc
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
}
