//
//  HotAgencyView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/5.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit

fileprivate let cellSpace: CGFloat = 16
fileprivate let cellWidth: CGFloat = kScreenWidth - 32
fileprivate let cellHeight: CGFloat = 300
fileprivate let cellID = "HotAgencyCollectionViewCell"

class HotAgencyView: UIView {
    //MARK: - 可操作数据
    var productList: Array<String> = ["http://p.lrlz.com/data/upload/mobile/special/s252/s252_05471521705899113.png",
                                      "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007678060723.png",
                                      "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007470310935.png"]
    var cellDataArr: [ProductModel] = [ProductModel]() {
        didSet {
            productCollectionView.reloadData()
        }
    }
    fileprivate var itemsInSection: Int {
//        return cellDataArr.count * 50
        return cellDataArr.count == 0 ? 150: cellDataArr.count * 50
    }
    fileprivate var contentOffsetX: CGFloat = 0
    // 标识子控件是否布局完成，布局完成后在layoutSubviews方法中就不执行 changeToFirstCycleCell 方法
    fileprivate var isLoadOver = false
    
    //MARK: - 懒加载
    lazy var topMoreBtn: UIButton = { [unowned self] in
        let topMoreBtn = UIButton()
        addSubview(topMoreBtn)
        topMoreBtn.setTitle("热门产品代理>", for: .normal)
        topMoreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        topMoreBtn.setTitleColor(UIColor.RGB(with: 51, green: 51, blue: 51), for: .normal)
        topMoreBtn.setImage(#imageLiteral(resourceName: "ICON-fire"), for: .normal)
        topMoreBtn.addTarget(self, action: #selector(topMoreBtnClick(_:)), for: .touchUpInside)
        return topMoreBtn
    }()
    
    lazy var productCollectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth - cellSpace * 2, height: cellHeight)
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        
        let productCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(productCollectionView)
        productCollectionView.backgroundColor = UIColor.white
        productCollectionView.register(HotAgencyCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
//        productCollectionView.isPagingEnabled = true
        productCollectionView.bounces = false
        productCollectionView.showsVerticalScrollIndicator = false
        productCollectionView.showsHorizontalScrollIndicator = false
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        return productCollectionView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        addSubview(pageControl)
        pageControl.numberOfPages = 3
        pageControl.currentPage = 1
        pageControl.hidesForSinglePage = false
        pageControl.pageIndicatorTintColor = UIColor.RGB(with: 238, green: 238, blue: 238)
        pageControl.currentPageIndicatorTintColor = kMainColor
        return pageControl
    }()

    //MARK: - 生命周期
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        
        topMoreBtn.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 140, height: 20))
        }
        
        productCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(topMoreBtn.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: cellHeight + 2))
        }
        productCollectionView.layoutIfNeeded()
        if isLoadOver == false {
            //跳转到中间页
            let firstItem = itemsInSection / 2 + 1
            let indexPath = IndexPath(item: firstItem, section: 0)
            productCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            contentOffsetX = productCollectionView.contentOffset.x
            isLoadOver = true
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.centerX.bottom.equalToSuperview()
        }
    }
    
    @objc func topMoreBtnClick(_ sender: UIButton) {
//        print("更多热门代理")
    }
    
}

//MARK: - UICollectionView代理
extension HotAgencyView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HotAgencyCollectionViewCell
        let cellModel: ProductModel
        if cellDataArr.count == 0 {
            cellModel = ProductModel()
        }else {
            cellModel = cellDataArr[indexPath.item%cellDataArr.count]
        }
        cell.setHotAgencyData(with: cellModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = LoansDetailViewController.loadStoryboard()
        let cellModel: ProductModel
        if cellDataArr.count == 0 {
            cellModel = ProductModel()
        }else {
            cellModel = cellDataArr[indexPath.item%cellDataArr.count]
        }
        vc.loansProductType = .selfSupport
        vc.productModel = cellModel
        vc.productModel.product_id = cellModel.id
        let topViewController = Utils.currentTopViewController()
        if topViewController?.navigationController != nil{
            topViewController?.navigationController?.pushViewController(vc, animated: true)
        }else{
            topViewController?.present(vc, animated: true , completion: nil)
        }
    }
    
    //跳转到第一个cell
    func changeToFirstCycleCell(animated: Bool, collectionView: UICollectionView){
        guard itemsInSection != 0 else {
            return
        }
        let firstItem = itemsInSection / 2
        let indexPath = IndexPath(item: firstItem, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
        contentOffsetX = productCollectionView.contentOffset.x
    }
    //跳转到最后一个cell
    func changeToLastCycleCell(animated: Bool, collectionView: UICollectionView) {
        guard itemsInSection != 0 else {
            return
        }
        let firstItem = itemsInSection / 2 + (productList.count - 1)
        let indexPath = IndexPath(item: firstItem, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
        contentOffsetX = productCollectionView.contentOffset.x
    }
}

extension HotAgencyView: UIScrollViewDelegate {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        contentOffsetX = scrollView.contentOffset.x
//        print(contentOffsetX)
    }
    
    //滑动减速时触发的代理，当用户用力滑动或者清扫时触发
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        if fabs(scrollView.contentOffset.x - contentOffsetX) > 10 {
//            scrollOnePage(with: scrollView)
//        }
        scrollOnePage(with: scrollView)
    }
    
    //用户拖拽时调用
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        if fabs(scrollView.contentOffset.x - contentOffsetX) > 25 {
//            scrollOnePage(with: scrollView)
//        }
        scrollOnePage(with: scrollView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        var curItem: Int = 0
        if scrollView.contentOffset.x > contentOffsetX {
            curItem = Int((scrollView.contentOffset.x + cellSpace) / (cellWidth + cellSpace))
        }else{
            curItem = Int((scrollView.contentOffset.x) / (cellWidth + cellSpace) + 1)
        }
        let curPage = curItem % productList.count
        pageControl.currentPage = curPage
        print(curPage)
    }
    
    func scrollOnePage(with scrollView: UIScrollView) {
        let curItem = Int((scrollView.contentOffset.x + cellSpace) / (cellWidth + cellSpace))
//        print("当前item:\(curItem)")
        if scrollView.contentOffset.x > contentOffsetX {
            if curItem == (itemsInSection - 2) {
                changeToFirstCycleCell(animated: false, collectionView: productCollectionView)
            }else {
                let index = IndexPath(item: curItem + 1, section: 0)
                productCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            }
        }else{
            if curItem == 0 {
                changeToLastCycleCell(animated: false, collectionView: productCollectionView)
            }else {
                let index = IndexPath(item: curItem, section: 0)
                productCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            }
        }
    }
}
