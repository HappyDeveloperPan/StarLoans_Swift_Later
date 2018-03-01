//
//  VideoCenterDetailCollectionViewCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/14.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class VideoCenterDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var readNumberLB: UILabel!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var videoTypeLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.white
        videoTypeLB.layer.backgroundColor = UIColor.RGB(with: 248, green: 225, blue: 225).cgColor
        videoTypeLB.layer.cornerRadius = videoTypeLB.height/2
        readNumberLB.sizeToFit()
    }

}

extension VideoCenterDetailCollectionViewCell {
    func setVideoData(with cellData: VideoModel) {
        titleLB.text = cellData.video_title
        videoTypeLB.text = cellData.getVideoType()
        readNumberLB.text = String(cellData.video_view_count)
        //FIXME: - 临时背景图
        backImg.image = #imageLiteral(resourceName: "banner-hangyeziyuan")
    }
}
