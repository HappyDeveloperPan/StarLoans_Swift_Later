//
//  HomePageViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/7.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

fileprivate let IMAGE_HEIGHT:CGFloat = 200
fileprivate let NAVBAR_COLORCHANGE_POINT:CGFloat = IMAGE_HEIGHT - CGFloat(64 * 2)

class HomePageViewController: UIViewController {
    //MARK: - 可操作数据
    ///广告栏数据
    var adverList: Array<String> = ["http://p.lrlz.com/data/upload/mobile/special/s252/s252_05471521705899113.png",
                                    "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007678060723.png",
                                    "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007470310935.png"]
    
    var topBannerLocalArr: Array<String> = ["WechatIMG49", "WechatIMG49", "WechatIMG49"]
    //    var topBannerArr: [BannerModel] = [BannerModel]()
    ///视频栏数据
    var hotVideoArr: [HomePageModel]?
    ///nav栏
    weak var navController: UINavigationController?
    ///记录顶部状态栏颜色
//    var statusBarColor: UIStatusBarStyle = .default {
//        didSet {
//            UIApplication.shared.statusBarStyle = statusBarColor
//        }
//    }
    var statusBarColor: UIStatusBarStyle = .default {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    ///记录是否显示顶部状态栏
    var isHiddenStatus: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    lazy var locationManager: CLLocationManager = { [unowned self] in
        let locationManager = CLLocationManager()
        locationManager.delegate = self
//        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//            locationManager.requestWhenInUseAuthorization()
//        }
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLLocationAccuracyKilometer
        return locationManager
    }()
    
    //MARK: - 主界面部分
    lazy var mainView: UIScrollView = { [unowned self] in
        let mainView = UIScrollView()
        self.view.addSubview(mainView)
        mainView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        mainView.showsVerticalScrollIndicator = false
        mainView.showsHorizontalScrollIndicator = false
        if #available(iOS 11.0, *) {
            mainView.contentInsetAdjustmentBehavior = .never
        }
        mainView.delegate = self
        return mainView
    }()
    
    ///顶部渐变搜索栏
    lazy var navView: UIView = { [unowned self] in
        let navView = UIView()
        self.view.addSubview(navView)
        navView.backgroundColor = kMainColor
        navView.alpha = 0
        return navView
    }()
    
    lazy var addressBtn: UIButton = { [unowned self] in
        let addressBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 45, height: 30))
        self.view.addSubview(addressBtn)
        addressBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        addressBtn.setTitleColor(UIColor.white, for: .normal)
        addressBtn.set(image: #imageLiteral(resourceName: "ICON-xiala"), title: "定位", titlePosition: .left, additionalSpacing: 2, state: .normal)
        addressBtn.addTarget(self, action: #selector(locationBtnClick(_:)), for: .touchUpInside)
        return addressBtn
    }()
    
    lazy var searchView: SearchView = { [unowned self] in
        let searchView = SearchView()
        self.view.addSubview(searchView)
        searchView.layer.cornerRadius = 17
        searchView.alpha = 0.7
        searchView.textField.delegate = self
        return searchView
    }()
    
    ///顶部广告栏
    lazy var topAdBannerView: TopAdverView = { [unowned self] in
        let topAdBannerView = TopAdverView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 235))
        self.mainView.addSubview(topAdBannerView)
        topAdBannerView.adverDelegate = self
        return topAdBannerView
    }()
    
    ///功能栏
    lazy var functionView: FunctionView = { [unowned self] in
        let functionView = FunctionView()
        self.mainView.addSubview(functionView)
        functionView.delegate = self
        return functionView
    }()
    
    ///视频栏
    lazy var videoView: VideoView = { [unowned self] in
        let videoView = VideoView()
        self.mainView.addSubview(videoView)
        return videoView
    }()
    
    ///产品代理
    lazy var hotAgencyView: HotAgencyView = { [unowned self] in
        let hotAgencyView = HotAgencyView()
        self.mainView.addSubview(hotAgencyView)
        return hotAgencyView
    }()
    
    ///中部广告栏
    lazy var centerAdverView: UIImageView = { [unowned self] in
        let centerAdverView = UIImageView()
        self.mainView.addSubview(centerAdverView)
        centerAdverView.backgroundColor = kLineColor
        return centerAdverView
    }()
    
    ///急速抢单
    lazy var quickRobView: QuickRobView = { [unowned self] in
        let quickRobView = QuickRobView()
        self.mainView.addSubview(quickRobView)
        quickRobView.delegate = self
        return quickRobView
    }()
    
    ///信用卡专区
    lazy var partnerPlanView: PlanView = { [unowned self] in
        let partnerPlanView = PlanView()
        self.mainView.addSubview(partnerPlanView)
        return partnerPlanView
    }()
    
    ///消息栏
    lazy var infoView: InformationView = { [unowned self] in
        let infoView = InformationView()
        self.mainView.addSubview(infoView)
        return infoView
    }()
    
    ///资讯研读
    lazy var messageReadView: MessageReadView = { [unowned self] in
        let messageReadView = MessageReadView()
        self.mainView.addSubview(messageReadView)
        return messageReadView
    }()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasic()
        locationManager.startUpdatingLocation()
        getHomePageData()
    }
    
    func setupBasic() {
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        topAdBannerView.localImgArray = topBannerLocalArr
        //  给界面添加下拉刷新
        mainView.addHeaderRefresh { [weak self] in
            self?.getHomePageData()
        }
        //  setNeedsStatusBarAppearanceUpdate()
    }
    
    override var prefersStatusBarHidden: Bool {
        return isHiddenStatus
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarColor
    }
    
    ///刷新主界面数据
    func getHomePageData() {
        getTopBannerData()
        getVideoData()
        getHotProductData()
        getBottomBannerData()
        getHotQuickRobData()
        getActivityCenterData()
        getHotNewsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        topAdBannerView.isAutoScroll = true
//        UIApplication.shared.statusBarStyle = statusBarColor
        
        navigationController?.delegate = self
        navController = navigationController
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        ///全局滚动视图
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        ///渐变假nav栏
        navView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: kNavHeight))
        }
        ///搜索视图
        addressBtn.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(kStatusHeight + 2)
            make.height.equalTo(34)
        }
        addressBtn.layoutIfNeeded()
        
        searchView.snp.makeConstraints { (make) in
            make.top.equalTo(kStatusHeight + 2)
            make.left.equalTo(addressBtn.snp.right).offset(8)
            make.right.equalTo(-30)
            make.height.equalTo(34)
        }
        searchView.layoutIfNeeded()
    
        ///广告栏
        topAdBannerView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(235)
        }
        topAdBannerView.layoutIfNeeded()
        
        ///功能栏
        functionView.snp.makeConstraints { (make) in
            make.top.equalTo(topAdBannerView.snp.bottom)
            make.left.equalToSuperview()
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(200)
        }
        functionView.layoutIfNeeded()
        
        ///视频栏
        videoView.snp.makeConstraints { (make) in
            make.top.equalTo(functionView.snp.bottom)
            make.left.right.equalToSuperview()
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(175 + 12 + 12)
        }
        videoView.layoutIfNeeded()
        
        ///热门栏
        hotAgencyView.snp.makeConstraints { (make) in
            make.top.equalTo(videoView.snp.bottom)
            make.left.right.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: 375))
        }
        hotAgencyView.layoutIfNeeded()
        
        ///急速抢单
        quickRobView.snp.makeConstraints { (make) in
            make.top.equalTo(hotAgencyView.snp.bottom).offset(8.5)
            make.left.right.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: 376))
        }
        quickRobView.layoutIfNeeded()
        
        ///信用卡专区
        partnerPlanView.snp.makeConstraints { (make) in
            make.top.equalTo(quickRobView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: 206))

        }
        partnerPlanView.layoutIfNeeded()
        
        ///中部广告栏
        centerAdverView.snp.makeConstraints { (make) in
            make.top.equalTo(partnerPlanView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: 120))
        }
        centerAdverView.layoutIfNeeded()
        
        ///消息栏
        infoView.snp.makeConstraints { (make) in
            make.top.equalTo(centerAdverView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: 30))
        }
        infoView.layoutIfNeeded()
        
        ///资讯栏
        messageReadView.snp.makeConstraints { (make) in
            make.top.equalTo(infoView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: 353))
            make.bottom.equalToSuperview()
        }
        messageReadView.layoutIfNeeded()
        //layoutNeeded可以立即获取到frame
        mainView.layoutIfNeeded()
//        mainView.contentSize = CGSize(width: kScreenWidth, height: kScreenHeight * 3)
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        topAdBannerView.isAutoScroll = false
//        UIApplication.shared.statusBarStyle = .default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - 控件点击事件
    @objc func locationBtnClick(_ sender: UIButton) {
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
            present(alertController, animated: true, completion: nil)
        }
    }

}

//MARK: - 数据处理
extension HomePageViewController {
    ///获取顶部广告栏
    func getTopBannerData() {
        NetWorksManager.requst(with: kUrl_HomePageTopBanner, type: .post, parameters: nil) { [weak self] (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"].array {
                    var bannerArr = [String]()
                    for index in 0...2 {
                        if !(data[index].isEmpty) {
                            let bannerModel = BannerModel(with: data[index])
                            bannerArr.append(bannerModel.image)
                        }else {
                            bannerArr.append("")
                        }
                    }
                    self?.topAdBannerView.serverImgArray = bannerArr
                }
            }else {
                if error == nil {
                    if let msg = jsonData?["msg_zhcn"].stringValue {
                        JSProgress.showFailStatus(with: msg)
                    }
                }else {
                    JSProgress.showFailStatus(with: "网络请求失败")
                }
            }
            self?.mainView.endHeaderRefresh()
        }
    }
    ///获取热门视频
    func getVideoData() {
        NetWorksManager.requst(with: kUrl_HotVideo, type: .post, parameters: nil) { [weak self] (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"].array {
                    var videoArr = [HomePageModel]()
                    for dict in data {
                        videoArr.append(HomePageModel(with: dict))
                    }
                    self?.videoView.videoArr = videoArr
                }
            }else {
                if error == nil {
                    if let msg = jsonData?["msg_zhcn"].stringValue {
                        JSProgress.showFailStatus(with: msg)
                    }
                }else {
                    JSProgress.showFailStatus(with: "请求失败")
                }
            }
        }
    }
    
    ///获取热门产品
    func getHotProductData() {
        NetWorksManager.requst(with: kUrl_HotProduct, type: .post, parameters: nil) { [weak self] (jsonData, error) in
            if jsonData?["status"] == 200 {
                
                if let data = jsonData?["data"].array {
                    var cellArr = [ProductModel]()
                    for dict in data {
                        cellArr.append(ProductModel(with: dict))
                    }
                    self?.hotAgencyView.cellDataArr = cellArr
                }
                
            }else {
                if error == nil {
                    if let msg = jsonData?["msg_zhcn"].stringValue {
                        JSProgress.showFailStatus(with: msg)
                    }
                }else {
                    JSProgress.showFailStatus(with: "请求失败")
                }
            }
        }
    }
    ///中部广告页
    func getBottomBannerData() {
        NetWorksManager.requst(with: kUrl_BottomBanner, type: .post, parameters: nil) { [weak self] (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"][0] {
                    let bannerModel = BannerModel(with: data)
                    self?.centerAdverView.setImage(with: bannerModel.image)
                }
            }else {
                if error == nil {
                    if let msg = jsonData?["msg_zhcn"].stringValue {
                        JSProgress.showFailStatus(with: msg)
                    }
                }else {
                    JSProgress.showFailStatus(with: "请求失败")
                }
            }
        }
    }
    ///热门急速抢单
    func getHotQuickRobData() {
        NetWorksManager.requst(with: kUrl_HotQuickRob, type: .post, parameters: nil) { [weak self] (jsonData, error) in
            if jsonData?["status"] == 200 {
                if let data = jsonData?["data"].array {
                    var cellArr = [ClientInfoModel]()
                    for dict in data {
                        cellArr.append(ClientInfoModel(with: dict))
                    }
                    self?.quickRobView.cellArr = cellArr
                }
            }else {
                if error == nil {
                    if let msg = jsonData?["msg_zhcn"].stringValue {
                        JSProgress.showFailStatus(with: msg)
                    }
                }else {
                    JSProgress.showFailStatus(with: "请求失败")
                }
            }
        }
    }
    
    ///活动中心
    func getActivityCenterData() {
        NetWorksManager.requst(with: kUrl_ActivityCenter, type: .post, parameters: nil) { [weak self](jsonData, error) in
            if jsonData?["status"] == 200 {
                if let activity = jsonData?["data"]["activity"].array {
                    var dataArr = [HomePageModel]()
                    for data in activity {
                        dataArr.append(HomePageModel(with: data))
                    }
                    self?.partnerPlanView.dataArr = dataArr
                }
            }else {
                if error == nil {
                    if let msg = jsonData?["msg_zhcn"].stringValue {
                        JSProgress.showFailStatus(with: msg)
                    }
                }else {
                    JSProgress.showFailStatus(with: "请求失败")
                }
            }
        }
    }
    
    ///获取热点新闻
    func getHotNewsData() {
        var parameters = [String: Any]()
        parameters["key"] = NewsAppKey
        parameters["type"] = "caijing"
        NetWorksManager.requst(with: kUrl_HotNews, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
            if jsonData?["result"]["stat"].intValue == 1 {
                if let dataArr = jsonData?["result"]["data"].array {
                    var newsArr = [ResourceModel]()
                    for index in 0...2 {
                        if !(dataArr[index].isEmpty) {
                            newsArr.append(ResourceModel(with: dataArr[index]))
                        }else {
                            newsArr.append(ResourceModel())
                        }
                    }
                    self?.messageReadView.messageDataArr = newsArr
                    self?.messageReadView.tableView.reloadData()
                }
            }else {
                if error == nil {
                    if let msg = jsonData?["reason"].stringValue {
                        JSProgress.showFailStatus(with: msg)
                    }
                }else {
                    JSProgress.showFailStatus(with: "请求失败")
                }
            }
        }
    }
}

//MARK: - 滚动代理
extension HomePageViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let offsetY = scrollView.contentOffset.y
        if (offsetY > NAVBAR_COLORCHANGE_POINT)
        {
            let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / CGFloat(64)
            navView.alpha = alpha
            statusBarColor = .lightContent
            isHiddenStatus = false
        }else if offsetY < 0 {
            navView.alpha = 0
            isHiddenStatus = true
            searchView.alpha = (offsetY + 32) / 32
            addressBtn.alpha = (offsetY + 32) / 32
        }
        else
        {
            addressBtn.alpha = 1
            searchView.alpha = 1
            navView.alpha = 0
            statusBarColor = .default
            isHiddenStatus = false
        }
    }
}

//MARK: - 顶部广告栏代理
extension HomePageViewController: TopAdverViewDelegate {
    /// 点击图片回调
    func topAdverViewDidSelect(at index: Int, cycleScrollView: WRCycleScrollView) {
//        print("点击了第\(index+1)个图片")
    }
    /// 图片滚动回调
    func topAdverViewDidScroll(to index: Int, cycleScrollView: WRCycleScrollView) {
//        print("滚动到了第\(index+1)个图片")
    }
}

//MARK: - 工具栏代理
extension HomePageViewController: FunctionViewDelegate {
    func buttonDidSelect(at index: Int) {
        switch index {
        case 1:
            let vc = BusinessResourceViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = LoansCollegeViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            JSProgress.showInfoWithStatus(with: "功能暂未开放")
        case 4:
            let vc = SignInViewController.loadStoryboard()
            navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = MessageReadViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 6:
            let vc = VideoCenterViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

//MARK: - 急速抢单代理
extension HomePageViewController: QuickRobViewDelegate {
    func moreQuickBill() {
        //如果用户没有登录就跳转到登录界面
        guard UserManager.shareManager.isLogin else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPresentLogin), object: nil)
            return
        }
        let vc = QuickRobbingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UINavigationController代理
extension HomePageViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController == self {
            navController?.setNavigationBarHidden(true, animated: animated)
        }
        else {
            //不在本页时，显示真正的nav bar
            navController?.setNavigationBarHidden(false, animated: animated)
            //当不显示本页时，要么就push到下一页，要么就被pop了，那么就将delegate设置为nil，防止出现BAD ACCESS
            //之前将这段代码放在viewDidDisappear和dealloc中，这两种情况可能已经被pop了，self.navigationController为nil，这里采用手动持有navigationController的引用来解决
            if navController?.delegate === self  {
                //如果delegate是自己才设置为nil，因为viewWillAppear调用的比此方法较早，其他controller如果设置了delegate就可能会被误伤
                navController?.delegate = nil
            }
        }
    }
}

//MARK: - CLLocationManager代理
extension HomePageViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currLocation = locations.last {
            print(currLocation.coordinate.longitude)
            print(currLocation.coordinate.latitude)
            UserManager.shareManager.userModel.lat = currLocation.coordinate.latitude
            UserManager.shareManager.userModel.lng = currLocation.coordinate.longitude
            
            let geocoder: CLGeocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(currLocation, completionHandler: { [weak self] (placemarks, error) in
                
                self?.locationManager.stopUpdatingLocation()
                
                if (error == nil) {//转换成功，解析获取到的各个信息
                    guard let placemark = placemarks?.first else{
                        return
                    }
//                    print(placemark.name ?? "")
//                    print(placemark.locality ?? "")
                    let address = placemark.locality?.replacingOccurrences(of: "市", with: "") ?? "定位"
                    self?.addressBtn.set(image: #imageLiteral(resourceName: "ICON-xiala"), title: address, titlePosition: .left, additionalSpacing: 2, state: .normal)
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

//MARK: - TextFiled代理
extension HomePageViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let vc = SearchViewController()
        let navVC = AXDNavigationController(rootViewController: vc)
//        navigationController?.pushViewController(vc, animated: true)
        navigationController?.present(navVC, animated: true, completion: nil)
        return false
    }
}

