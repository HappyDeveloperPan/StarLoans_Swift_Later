//
//  SearchViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/1/23.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    
    lazy var searchView: UIView = { [unowned self] in
        let searchView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth - 32, height: 35))
        return searchView
    }()
    
    lazy var searchBar: UISearchBar = { [unowned self] in
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: kScreenWidth - 32, height: 35))
        searchBar.placeholder = "经纪人, 视频, 资讯"
        searchBar.layer.cornerRadius = 17.5
        searchBar.backgroundColor = kHomeBackColor
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        for subView in (searchBar.subviews.last?.subviews)! {
            if subView is UITextField {
                var textField = subView as? UITextField
                textField?.font = UIFont.systemFont(ofSize: 16)
                textField?.backgroundColor = kHomeBackColor
                break
            }
        }
        let button = searchBar.value(forKey: "cancelButton") as? UIButton
        button?.setTitle("取消", for: .normal)
        button?.setTitleColor(kTitleColor, for: .normal)
        return searchBar
    }()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.addSubview(searchBar)
        navigationItem.titleView = searchView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        isNavLineHidden = false
        searchBar.becomeFirstResponder()
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        isNavLineHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}
