//
//  QSMarqueeView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/16.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class QSMarqueeView: UIView {

    // MARK: - 外部属性
    /// 字体颜色
    var textColor: UIColor = UIColor.black

    /// 字体大小
    var font: UIFont = UIFont.systemFont(ofSize: 15)
    
    /// 显示的内容
    var text: String?
    
    /// 移动的速度,默认是0.5
    var speed: CGFloat = 0.5
    
    /// 背景颜色
    var bgColor: UIColor = UIColor.white {
        didSet {
            moveView.backgroundColor = bgColor
        }
    }
    
    /// 滚动的文字
    var textArr = [String]() {
        didSet {
            moveView.reloadData()
            displayLink.isPaused = false
        }
    }
    
    // MARK: - 内部属性
    fileprivate var offsetX: CGFloat = 0
    fileprivate let cellIdentifier = "cellIdentifier"
    fileprivate lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
//        layout.estimatedItemSize = CGSize(width: self.frame.size.width/2, height: self.frame.size.height)
        layout.estimatedItemSize = CGSize(width: 30, height: 30)
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        return layout
    }()

    fileprivate lazy var moveView: UICollectionView = {
        let moveView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), collectionViewLayout: self.layout)
        self.addSubview(moveView)
        moveView.backgroundColor = UIColor.white
        moveView.register(QSMarqueeCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        moveView.bounces = false
        moveView.showsVerticalScrollIndicator = false
        moveView.showsHorizontalScrollIndicator = false
        moveView.delegate = self
        moveView.dataSource = self
        moveView.panGestureRecognizer.isEnabled = false
        return moveView
    }()
    
    fileprivate lazy var displayLink: CADisplayLink = {
        let displayLink = CADisplayLink(target: self, selector: #selector(scrollingLabelAction))
        displayLink.add(to: RunLoop.current, forMode: .defaultRunLoopMode)
        return displayLink
    }()
    
    // MARK: - 生命周期
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        moveView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        moveView.layoutIfNeeded()
    }
    
    deinit {
        displayLink.invalidate()
        displayLink.remove(from: RunLoop.current, forMode: .defaultRunLoopMode)
    }
    
    // MARK: - 数据处理
    @objc func scrollingLabelAction() {
        var point = moveView.contentOffset
        if point.x < moveView.contentSize.width {
            point.x += speed
        }else {
            point.x = -moveView.frame.width
        }
//        print(point)
        moveView.contentOffset = point
    }
}

extension QSMarqueeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! QSMarqueeCollectionViewCell
        cell.label.text = textArr[indexPath.row]
        cell.label.font = font
        cell.label.textColor = textColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("我被点击了")
    }
}
