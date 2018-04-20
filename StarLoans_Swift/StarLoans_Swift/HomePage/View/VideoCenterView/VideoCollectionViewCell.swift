//
//  VideoCollectionViewCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/19.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell, RegisterCellOrNib {
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var readNumberLabel: UILabel!
    @IBOutlet weak var likeNumberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setVideoCollectionViewCellData(with cellData: VideoModel) {
        backImg.setImage(with: cellData.video_img)
        readNumberLabel.text = "666"
        likeNumberLabel.text = "888"
        titleLabel.text = cellData.video_title
        timeLabel.text = Utils.getDateToYMD(with: cellData.video_upload_time)
    }
}
