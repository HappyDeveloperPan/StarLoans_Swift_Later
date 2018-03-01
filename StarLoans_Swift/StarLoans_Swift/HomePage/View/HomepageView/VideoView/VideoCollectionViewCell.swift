//
//  VideoCollectionViewCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/1.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

fileprivate let cellWidth: CGFloat = kScreenWidth - 50
fileprivate let cellHeight: CGFloat = 175

class VideoCollectionViewCell: UICollectionViewCell {
    //播放图片
    lazy var backImg: UIImageView = { [unowned self] in
        let backImg = UIImageView()
        contentView.addSubview(backImg)
        backImg.backgroundColor = UIColor.gray
        return backImg
    }()
    
    //左上角视频预告lable
    lazy var leftPredictView: UIView = { [unowned self] in
        let leftPredictView = UIView()
        backImg.addSubview(leftPredictView)
        leftPredictView.backgroundColor = UIColor.white
        leftPredictView.alpha = 0.4
        return leftPredictView
    }()
    
    lazy var leftPredictLB: UILabel = { [unowned self] in
        let leftPredictLB = UILabel()
        backImg.addSubview(leftPredictLB)
        leftPredictLB.text = "视频预告"
        leftPredictLB.font = UIFont.systemFont(ofSize: 17)
        leftPredictLB.textColor = UIColor.white
        leftPredictLB.textAlignment = .center
        return leftPredictLB
    }()
    
    //中间播放图片
    lazy var playImageView: UIImageView = { [unowned self] in
        let playImageView = UIImageView()
        backImg.addSubview(playImageView)
        playImageView.image = #imageLiteral(resourceName: "ICON-play")
        return playImageView
    }()
    
    //倒计时lable
    lazy var countDownLB: UILabel = { [unowned self] in
        let countDownLB = UILabel()
        backImg.addSubview(countDownLB)
//        countDownLB.text = "倒计时: 23: 59: 59"
        countDownLB.textColor = UIColor.white
        countDownLB.font = UIFont.systemFont(ofSize: 12)
        countDownLB.textAlignment = .center
        return countDownLB
    }()
    
    //底部介绍lable
    lazy var bottomLB: UILabel = { [unowned self] in
        let bottomLB = UILabel()
        backImg.addSubview(bottomLB)
//        bottomLB.text = "这段话以后要删掉!"
        bottomLB.textColor = UIColor.white
        bottomLB.font = UIFont.systemFont(ofSize: 14)
        bottomLB.textAlignment = .center
        return bottomLB
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = UIColor.gray
        layer.cornerRadius = 4
        layer.shadowColor = kLineColor.cgColor//shadowColor阴影颜色
        layer.shadowOffset = CGSize(width: 2, height: 2)//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        layer.shadowOpacity = 0.5//阴影透明度，默认0
        layer.shadowRadius = 3//阴影半径，默认3
        layer.masksToBounds = false
        
        contentView.layer.cornerRadius = 4
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backImg.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        leftPredictView.snp.makeConstraints { (make) in
            make.top.equalTo(7.5)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 25))
        }
        leftPredictView.layoutIfNeeded()
        let corners: UIRectCorner = [.topRight,.bottomRight]
        leftPredictView.corner(with: leftPredictView.bounds, corners: corners, radii: 4)
        
        leftPredictLB.snp.makeConstraints { (make) in
            make.top.equalTo(7.5)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 25))
        }
        
        playImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(45)
        }
        
        countDownLB.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(playImageView.snp.bottom).offset(7.5)
            make.size.equalTo(CGSize(width: 120, height: 12))
        }
        
        bottomLB.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-7.5)
            make.size.equalTo(CGSize(width: kScreenWidth - 50, height: 14))
        }
    }
}

extension VideoCollectionViewCell {
    func setCellData(with cellData:HomePageModel) {
        bottomLB.text = cellData.videoTitle
        backImg.setImage(with: cellData.video_img)
//        backImg.image?.cornerImage(size: (backImg.image?.size)!, radius: 4, fillColor: kHomeBackColor, completion: { [weak self] (image) in
//            self?.backImg.image = image
//        })
    }
}
