//
//  LunBoViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/13.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class LunBoViewController: UIViewController {
    
    ///顶部广告栏
    lazy var topAdBannerView: WRCycleScrollView = { [unowned self] in
        let topAdBannerView = WRCycleScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 235))
        self.view.addSubview(topAdBannerView)
//        topAdBannerView.adverDelegate = self
        return topAdBannerView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        topAdBannerView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 235)
        topAdBannerView.imageContentModel = UIViewContentMode.scaleAspectFill
        topAdBannerView.serverImgArray = ["http://www.jsyinhao.com/Public/image/product/26E14B02E35D91A09711F781F1A2169F/image.png","http://pic.58pic.com/58pic/14/34/62/39S58PIC9jV_1024.jpg","http://pic.qiantucdn.com/58pic/17/70/72/02U58PICKVg_1024.jpg"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
