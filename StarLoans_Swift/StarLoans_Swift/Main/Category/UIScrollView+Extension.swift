//
//  UIScrollView+Extension.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/22.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

//import Foundation
import UIKit
import MJRefresh

extension UIScrollView {
    /** 添加头部刷新 */
//    - (void)addHeaderRefresh:(MJRefreshComponentRefreshingBlock)block{
//    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
//    }
    func addHeaderRefresh(_ refreshingBlock: @escaping  MJRefreshComponentRefreshingBlock) {
        mj_header = MJRefreshNormalHeader(refreshingBlock: refreshingBlock)
    }
    
    ///开始头部刷新
    func beginHeaderRefresh() {
        mj_header.beginRefreshing()
    }
    
    ///开始脚部刷新
    func beginFooterRefresh() {
        mj_footer.beginRefreshing()
    }
    
    ///结束头部刷新
    func endHeaderRefresh() {
        mj_header.endRefreshing()
    }
    ///结束脚部刷新
    func endFooterRefresh() {
        mj_footer.endRefreshing()
    }
}
