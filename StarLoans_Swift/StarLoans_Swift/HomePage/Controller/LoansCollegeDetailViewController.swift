//
//  LoansCollegeDetailViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/12.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class LoansCollegeDetailViewController: UIViewController, StoryboardLoadable {
    //MARK: - Storyboard连线
    @IBOutlet weak var contentLB: UILabel!
    @IBOutlet weak var shadeView: UIView!
    @IBOutlet weak var commitBtn: UIButton!
    
    //MARK: - 外部属性
    var id: Int = 0
    var resourceModel = ResourceModel()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        basicConfig()
    }
    
    func basicConfig() {
        commitBtn.layer.cornerRadius = commitBtn.height/2
        
        contentLB.numberOfLines = 7
        contentLB.sizeToFit()
        
        let shadeLayer = CAGradientLayer()
        shadeLayer.frame = shadeView.bounds
         //设置渐变颜色数组,可以加透明度的渐变
//        shadeLayer.colors = [(UIColor(white: 0, alpha: 0.5).cgColor as? Any), (UIColor(white: 0, alpha: 1).cgColor as? Any)]
        shadeLayer.colors = [UIColor(white: 0, alpha: 0.5).cgColor, UIColor(white: 0, alpha: 1).cgColor]
        //设置渐变区域的起始和终止位置（范围为0-1）
        shadeLayer.startPoint = CGPoint(x: 0, y: 0)
        shadeLayer.endPoint = CGPoint(x: 0, y: 0.8)
        //gradientLayer.locations = @[@(0.8f)];//设置渐变位置数组
        //注意：这里不用下边的这句话
        //[gradientView.layer addSublayer:gradientLayer];//将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
        //设置蒙版，用来改变layer的透明度
        shadeView.layer.mask = shadeLayer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func commitBtnClick(_ sender: UIButton) {
        JSProgress.showSucessStatus(with: "支付成功")
        navigationController?.pushViewController(PayCompleteViewController.loadStoryboard(), animated: true)
    }
}
