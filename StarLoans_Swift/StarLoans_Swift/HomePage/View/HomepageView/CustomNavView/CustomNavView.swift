//
//  CustomNavView.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2018/4/13.
//  Copyright © 2018年 iOS Pan. All rights reserved.
//

import UIKit
import CoreLocation

class CustomNavView: UIView {
    // MARK: - 懒加载
    lazy var addressBtn: UIButton = { [unowned self] in
        let addressBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 45, height: 30))
        self.addSubview(addressBtn)
        addressBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        addressBtn.setTitleColor(UIColor.RGB(with: 102, green: 102, blue: 102), for: .normal)
        addressBtn.set(image: #imageLiteral(resourceName: "xial"), title: "定位", titlePosition: .left, additionalSpacing: 2, state: .normal)
        addressBtn.addTarget(self, action: #selector(locationBtnClick(_:)), for: .touchUpInside)
        return addressBtn
        }()
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLLocationAccuracyKilometer
        return locationManager
    }()
    
    lazy var searchView: SearchView = {
        let searchView = SearchView()
        self.addSubview(searchView)
        searchView.layer.cornerRadius = 15
        searchView.textField.delegate = self
        return searchView
        }()
    
    lazy var notifBtn: UIButton = {
        let notifBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        self.addSubview(notifBtn)
        notifBtn.setImage(#imageLiteral(resourceName: "ICON-message"), for: .normal)
        notifBtn.addTarget(self, action: #selector(notifBtnClick(_:)), for: .touchUpInside)
        return notifBtn
    }()
    
    lazy var badgeView: UIView = {
        let badgeView = UIView(frame: CGRect(x: -4, y: -4, width: 8, height: 8))
        self.notifBtn.addSubview(badgeView)
        badgeView.backgroundColor = kMainColor
        badgeView.layer.cornerRadius = 4
        return badgeView
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
        ///地址按钮
        addressBtn.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.bottom.equalTo(-10)
            make.height.equalTo(26)
        }
        
        ///通知按钮
        notifBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.centerY.equalTo(addressBtn)
        }
        
        ///搜索视图
        searchView.snp.makeConstraints { (make) in
            make.centerY.equalTo(addressBtn)
            make.left.equalTo(addressBtn.snp.right).offset(8)
            make.right.equalTo(notifBtn.snp.left).offset(-18)
            make.height.equalTo(30)
        }
    }
    
    // MARK: - 控件点击事件
    /// 定位按钮点击事件
    ///
    /// - Parameter sender: 定位按钮
    @objc func locationBtnClick(_ sender: UIButton) {
        //根据是否开启了定位权限进行定位服务
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }else {
            let alertController = UIAlertController(title: "温馨提示", message: "请到设置->隐私->定位服务中开启!", preferredStyle: .alert)
            let selectOne = UIAlertAction(title: "返回", style: .cancel, handler: nil)
            let selectTwo = UIAlertAction(title: "去设置", style: .destructive) { (action) in
                let url = URL(string: UIApplicationOpenSettingsURLString)
                if UIApplication.shared.canOpenURL(url!) {
                    UIApplication.shared.openURL(url!)
                }
            }
            alertController.addAction(selectOne)
            alertController.addAction(selectTwo)
            Utils.controlJump(alertController, isNav: false, jumpType: .ControlJumpTypePresent)
        }
    }
    
    /// 通知按钮点击事件
    ///
    /// - Parameter sender: 通知按钮
    @objc func notifBtnClick(_ sender: UIButton) {
        Utils.controlJump(MessageCenterViewController(), isNav: true, jumpType: .ControlJumpTypePush)
    }
}

// MARK: - UITextField代理
extension CustomNavView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        Utils.controlJump(SearchViewController(), isNav: true, jumpType: .ControlJumpTypePresent)
        return false
    }
}

//MARK: - CLLocationManager代理
extension CustomNavView: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currLocation = locations.last {
            print(currLocation.coordinate.longitude)
            print(currLocation.coordinate.latitude)
            UserManager.shareManager.userModel.lat = currLocation.coordinate.latitude
            UserManager.shareManager.userModel.lng = currLocation.coordinate.longitude
            
            let geocoder: CLGeocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(currLocation, completionHandler: { [weak self] (placemarks, error) in
                
                self?.locationManager.stopUpdatingLocation()
                
                if (error == nil) {     //转换成功，解析获取到的各个信息
                    guard let placemark = placemarks?.first else{
                        return
                    }
                    //  print(placemark.name ?? "")
                    //  print(placemark.locality ?? "")
                    let address = placemark.locality?.replacingOccurrences(of: "市", with: "") ?? "定位"
                    self?.addressBtn.set(image: #imageLiteral(resourceName: "xial"), title: address, titlePosition: .left, additionalSpacing: 2, state: .normal)
                    UserManager.shareManager.userModel.location = address
                }else {
                    print("转换失败")
                }
            })
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
