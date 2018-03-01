//
//  GridView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/27.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

class GridView: UICollectionView {

    //表头数据
    var cols: [String]! = []
    //行数据
    var rows: [[Any]]! = []
    //单元格内容居左时的左侧内边距
    private var cellPaddingLeft:CGFloat = 5
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super .init(frame: frame, collectionViewLayout: layout)
        backgroundColor = UIColor.white
        register(UICollectionViewCell.self,
                 forCellWithReuseIdentifier: "cell")
        delegate = self
        dataSource = self
        isDirectionalLockEnabled = true
        contentInset = UIEdgeInsetsMake(0, 10, 0, 10)
        bounces = false
    }
    
//    init() {
//        //初始化表格布局
//        let layout = UICollectionGridViewLayout()
//        super.init(collectionViewLayout: layout)
//        
//        layout.viewController = self
//        backgroundColor = UIColor.white
//        register(UICollectionViewCell.self,
//                                 forCellWithReuseIdentifier: "cell")
//        delegate = self
//        dataSource = self
//        isDirectionalLockEnabled = true
//        contentInset = UIEdgeInsetsMake(0, 10, 0, 10)
//        bounces = false
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //设置列头数据
    func setColumns(columns: [String]) {
        cols = columns
    }
    
    //添加行数据
    func addRow(row: [Any]) {
        rows.append(row)
        collectionViewLayout.invalidateLayout()
        reloadData()
    }
    
}

extension GridView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //返回表格总行数
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        if cols.isEmpty {
            return 0
        }
        //总行数是：记录数＋1个表头
        return rows.count + 1
    }
    
    //返回表格的列数
     func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return cols.count
    }
    
    //单元格内容创建
     func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as UICollectionViewCell
        //单元格边框
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.RGB(with: 217, green: 217, blue: 217).cgColor
        cell.backgroundColor = UIColor.white
        cell.clipsToBounds = true
        
        //先清空内部原有的元素
        for subview in cell.subviews {
            subview.removeFromSuperview()
        }
        
        //添加内容标签
        let label = UILabel(frame: CGRect(x:0, y:0, width:cell.frame.width,
                                          height:cell.frame.height))
        //FIXME: - 修改
        //第一列的内容左对齐，其它列内容居中
        //        if indexPath.row != 0 {
        //            label.textAlignment = .center
        //        }else {
        //            label.textAlignment = .left
        //            label.frame.origin.x = cellPaddingLeft
        //        }
        
        //设置列头单元格，内容单元格的数据
//        if indexPath.section == 0 {
//            let text = NSAttributedString(string: cols[indexPath.row], attributes: [
//                NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)
//                ])
//            label.attributedText = text
//        } else {
//            label.font = UIFont.systemFont(ofSize: 14)
//            label.text = "\(rows[indexPath.section-1][indexPath.row])"
//        }
        if indexPath.section == 0 {
            label.text = cols[indexPath.row]
            label.textColor = UIColor.RGB(with: 51, green: 51, blue: 51)
        } else {
            label.text = rows[indexPath.section-1][indexPath.row] as? String
            
            if indexPath.row > 0 {
                label.textColor = kMainColor
            }else {
                label.textColor = UIColor.RGB(with: 51, green: 51, blue: 51)
            }
        }
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        cell.addSubview(label)
        
        return cell
    }
    
    //单元格选中事件
//     func collectionView(_ collectionView: UICollectionView,
//                                 didSelectItemAt indexPath: IndexPath) {
//        //打印出点击单元格的［行,列］坐标
//        print("点击单元格的[行,列]坐标: [\(indexPath.section),\(indexPath.row)]")
//    }
}
