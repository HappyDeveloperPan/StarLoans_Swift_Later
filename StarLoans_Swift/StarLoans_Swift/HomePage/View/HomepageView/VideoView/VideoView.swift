//
//  VideoView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/2.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

//@objc protocol VideoViewDelegate
//{
//    /// 点击图片回调
//    @objc optional func videoScrollViewDidSelect(at index:Int, videoScrollView:VideoView)
//    /// 图片滚动回调
//    @objc optional func videoScrollViewDidScroll(to index:Int, videoScrollView:VideoView)
//}

fileprivate let cellMargin: CGFloat = 50
fileprivate let cellSpace: CGFloat = 16
fileprivate let cellWidth: CGFloat = kScreenWidth - cellMargin
fileprivate let cellHeight: CGFloat = 175
fileprivate let cellID = "VideoCollectionViewCell"

class VideoView: UIView {

    //MARK: - 可操作数据
    var videoArr: [HomePageModel] = [HomePageModel](){
        didSet {
            collectionView?.reloadData()
        }
    }
    //真实item数量
    var itemsInSection: Int {
//        return adverList.count * 20
        return videoArr.count == 0 ? 60: videoArr.count * 20
    }
    
    var contentOffsetX: CGFloat = 0
    
    fileprivate var flowLayout:CustomLayout?
    fileprivate var collectionView:UICollectionView?
    
    // 标识子控件是否布局完成，布局完成后在layoutSubviews方法中就不执行 changeToFirstCycleCell 方法
    fileprivate var isLoadOver = false
    
    //MARK: - 生命周期
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = UIColor.white
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        
        collectionView?.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        collectionView?.layoutIfNeeded()
        if isLoadOver == false {
            changeToFirstCycleCell(animated: false, collectionView: collectionView!)
            isLoadOver = true
        }
//        print(collectionView?.contentOffset.x)
    }
 
    fileprivate func setupCollectionView() {
        
        flowLayout = CustomLayout()
        flowLayout?.itemSize = CGSize(width: cellWidth, height: cellHeight)
//        flowLayout?.minimumLineSpacing = cellSpace
//        flowLayout?.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout!)
        collectionView?.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        collectionView?.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
//        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        addSubview(collectionView!)
    }
    
}

extension VideoView {
    func reloadData(with videoArr: Array<Any>) {
        
    }
}

//MARK: - UICollectionView代理
extension VideoView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! VideoCollectionViewCell
        let videoModel: HomePageModel
        if videoArr.count == 0 {
            videoModel = HomePageModel()
        }else {
            videoModel = videoArr[indexPath.item % videoArr.count]
        }
        cell.setCellData(with: videoModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = VideoDetailViewController.loadStoryboard()
        let videoModel: HomePageModel
        if videoArr.count == 0 {
            videoModel = HomePageModel()
        }else {
            videoModel = videoArr[indexPath.item % videoArr.count]
        }
        vc.videoID = videoModel.video_id
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
}

//MARK: - UIScrollView代理
extension VideoView: UIScrollViewDelegate {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        contentOffsetX = scrollView.contentOffset.x
    }
    
    //滑动减速时触发的代理，当用户用力滑动或者清扫时触发
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if fabs(scrollView.contentOffset.x - contentOffsetX) > 10 {
            scrollOnePage(with: scrollView)
        }
    }
    
    //用户拖拽时调用
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if fabs(scrollView.contentOffset.x - contentOffsetX) > 25 {
            scrollOnePage(with: scrollView)
        }
    }
    
//    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//        if fabs(scrollView.contentOffset.x - contentOffsetX) > 25 {
//
//        }
//    }
    
    //跳转到第一个cell
    func changeToFirstCycleCell(animated: Bool, collectionView: UICollectionView)
    {
        guard itemsInSection != 0 else {
            return
        }
        let firstItem = itemsInSection / 2
        let indexPath = IndexPath(item: firstItem, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
    }
    
    func scrollOnePage(with scrollView: UIScrollView) {
        let curItem = (scrollView.contentOffset.x) / (cellWidth + cellSpace) + 1
        print(curItem)
        if Int(curItem) == 1 || Int(curItem) == (itemsInSection - 1){
            changeToFirstCycleCell(animated: false, collectionView: collectionView!)
        }else {
            if scrollView.contentOffset.x > contentOffsetX {
                let index = IndexPath(item: Int(curItem), section: 0)
                collectionView?.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            }else{
                let index = IndexPath(item: Int(curItem - 1), section: 0)
                collectionView?.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            }
        }
    }
}
