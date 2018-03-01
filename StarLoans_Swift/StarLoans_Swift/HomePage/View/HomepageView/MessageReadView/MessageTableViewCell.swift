//
//  MessageTableViewCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/7.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell, RegisterCellOrNib {

    @IBOutlet weak var messImageView: UIImageView!
    @IBOutlet weak var readNumber: UILabel!
    @IBOutlet weak var contentLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    
    lazy var bottomLine: UIView = { [unowned self] in
        let bottomLine = UIView()
        contentView.addSubview(bottomLine)
        bottomLine.backgroundColor = kLineColor
        return bottomLine
    }()
    
    //MARK: - 生命周期
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
//        let attribute = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
//        let lableSize = contentLB.text?.boundingRect(with: CGSize(width: contentLB.frame.size.width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: attribute, context: nil).size
//        contentLB.frame = CGRect(x: contentLB.frame.origin.x, y: contentLB.frame.origin.y, width: contentLB.frame.size.width, height: (lableSize?.height)!)
        contentLB.numberOfLines = 2
        contentLB.sizeToFit()
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        bottomLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension MessageTableViewCell {
    func setMessageReadData(with cellData: ResourceModel) {
        //TODO: - 图片地址拼接要改
//        messImageView.setImage(with: cellData.image_video)
        messImageView.setImage(with: picAdress + cellData.image_video)
        contentLB.text = cellData.title
        readNumber.text = String(cellData.reading_number)
        timeLB.text = cellData.time
    }
    ///设置热点新闻数据
    func setHotNewsData(_ cellData: ResourceModel) {
        messImageView.setImage(with: cellData.thumbnail_pic_s)
        contentLB.text = cellData.title
        let max: UInt32 = 99999
        let min: UInt32 = 9999
        let number = arc4random_uniform(max - min) + min
        readNumber.text = String(number)
        timeLB.text = cellData.date
    }
}
