//
//  ProblemCell.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/27.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class ProblemCell: UITableViewCell, RegisterCellOrNib {
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var problemLB: UILabel!
    @IBOutlet weak var answerLB: UILabel!
    
//    lazy var formatter: DateFormatter = { [unowned self] in
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        return formatter
//    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        answerLB.sizeToFit()
        answerLB.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setProblemCellData(_ cellData: QuestionModel, formatter: DateFormatter) {
        if !cellData.questioner_tx.isEmpty {
            userImg.setImage(with: cellData.questioner_tx)
        }
        userName.text = cellData.questioner_user
        timeLB.text = formatter.string(from: Date(timeIntervalSince1970: cellData.question_time))
        problemLB.text = "问：" + cellData.question_title
        answerLB.text = cellData.answer_user + "：" + cellData.answer_content
    }
    
}
