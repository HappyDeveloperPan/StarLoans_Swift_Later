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
    var activityArr = [HomePageModel]()
    ///nav栏
    weak var navController: UINavigationController?
    var popDelegate: UIGestureRecognizerDelegate?
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
    
    //MARK: - 主界面部分
    lazy var mainView: UIScrollView = {
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
    
    /// 自定义Nav栏
    lazy var customNavView: CustomNavView = {
        let customNavView = CustomNavView()
        self.view.addSubview(customNavView)
        return customNavView
    }()
    
    /// 顶部广告栏
    lazy var topAdBannerView: TopAdverView = {
        let topAdBannerView = TopAdverView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 170))
        self.mainView.addSubview(topAdBannerView)
        topAdBannerView.adverDelegate = self
        return topAdBannerView
    }()
    
    /// 消息栏
    lazy var infoView: InformationView = {
        let infoView = InformationView()
        self.mainView.addSubview(infoView)
        return infoView
        }()
    
    /// 功能栏
    lazy var functionView: FunctionView = {
        let functionView = FunctionView()
        self.mainView.addSubview(functionView)
        functionView.delegate = self
        return functionView
    }()
    
    /// 热门产品
    lazy var hotProductView: HotProductView = {
        let hotProductView = HotProductView()
        self.mainView.addSubview(hotProductView)
        return hotProductView
    }()
    
    /// 产品代理
//    lazy var hotAgencyView: HotAgencyView = {
//        let hotAgencyView = HotAgencyView()
//        self.mainView.addSubview(hotAgencyView)
//        return hotAgencyView
//    }()
    
    /// 中部广告栏
    lazy var centerAdverView: TopAdverView = {
        let centerAdverView = TopAdverView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 120))
        self.mainView.addSubview(centerAdverView)
        centerAdverView.adverDelegate = self
        centerAdverView.isAutoScroll = false
        return centerAdverView
    }()
    
    ///急速抢单
//    lazy var quickRobView: QuickRobView = { [unowned self] in
//        let quickRobView = QuickRobView()
//        self.mainView.addSubview(quickRobView)
//        quickRobView.delegate = self
//        return quickRobView
//    }()
    
    ///信用卡专区
//    lazy var partnerPlanView: PlanView = { [unowned self] in
//        let partnerPlanView = PlanView()
//        self.mainView.addSubview(partnerPlanView)
//        return partnerPlanView
//    }()
    
    lazy var robMonadView: RobMonadView = {
        let robMonadView = RobMonadView()
        self.mainView.addSubview(robMonadView)
        return robMonadView
    }()
    
    ///资讯研读
//    lazy var messageReadView: MessageReadView = { [unowned self] in
//        let messageReadView = MessageReadView()
//        self.mainView.addSubview(messageReadView)
//        return messageReadView
//    }()
    
    lazy var bottomView: HomeBottomView = {
        let bottomView = HomeBottomView()
        self.mainView.addSubview(bottomView)
        return bottomView
    }()
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasic()
        customNavView.locationManager.startUpdatingLocation()
        getHomePageData()
        /*********测试数据**********/
        infoView.textArr = ["深圳市的周先生刚申请的包易贷，200000元已成功下款", "深圳市的李先生刚申请的新一贷，500000元已成功下款", "深圳市的刘先生刚申请的包易贷，800000元已成功下款"]
        /*************************/
    }
    
    func setupBasic() {
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
//        topAdBannerView.localImgArray = topBannerLocalArr
        //  给界面添加下拉刷新
        mainView.addHeaderRefresh { [weak self] in
            self?.getHomePageData()
        }
        //  setNeedsStatusBarAppearanceUpdate()
        let imagesArr: [UIImage] = [#imageLiteral(resourceName: "ICON-products"), #imageLiteral(resourceName: "ICON-college"), #imageLiteral(resourceName: "ICON-video-1"), #imageLiteral(resourceName: "ICON-information")]
        let titleArr: [String] = ["热门产品", "贷款学院", "视频中心", "资讯研读"]
        functionView.setFuncBtn(imagesArr, selectImgArr: nil, titleArr: titleArr, norColor: kTitleColor, selectColor: nil)
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
        getHotProductData()
        getHotQuickRobData()
        getActivityCenterData()
//        getHotNewsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
//        topAdBannerView.isAutoScroll = true
//        UIApplication.shared.statusBarStyle = statusBarColor
        /***暂时**/
        customNavView.badgeView.isHidden = false
        /*****/
        navigationController?.delegate = self
        navController = navigationController
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        ///渐变假nav栏
//        navView.snp.makeConstraints { (make) in
//            make.top.left.right.equalToSuperview()
//            make.size.equalTo(CGSize(width: kScreenWidth, height: kNavHeight))
//        }
        
        //自定义nav栏
        customNavView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: kNavHeight))
        }
        customNavView.layoutIfNeeded()
        
        /// 滚动视图
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(customNavView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
//            make.edges.equalToSuperview()
        }
    
        ///广告栏
        topAdBannerView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(170)
        }
        topAdBannerView.layoutIfNeeded()
        
        ///消息栏
        infoView.snp.makeConstraints { (make) in
            make.top.equalTo(topAdBannerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: 40))
        }
        infoView.layoutIfNeeded()
        
        /// 功能栏
        functionView.snp.makeConstraints { (make) in
            make.top.equalTo(infoView.snp.bottom)
            make.left.equalToSuperview()
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(80)
        }
        functionView.layoutIfNeeded()
        
        /// 热门产品
        hotProductView.snp.makeConstraints { (make) in
            make.top.equalTo(functionView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: 210))
        }
        hotProductView.layoutIfNeeded()
        
        /// 中部广告栏
        centerAdverView.snp.makeConstraints { (make) in
            make.top.equalTo(hotProductView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(120)
        }
        centerAdverView.layoutIfNeeded()
        
        /// 热门栏
//        hotAgencyView.snp.makeConstraints { (make) in
//            make.top.equalTo(centerAdverView.snp.bottom).offset(10)
//            make.left.right.equalToSuperview()
//            make.size.equalTo(CGSize(width: kScreenWidth, height: 375))
//        }
//        hotAgencyView.layoutIfNeeded()
        
        /// 信用卡专区
//        partnerPlanView.snp.makeConstraints { (make) in
//            make.top.equalTo(centerAdverView.snp.bottom).offset(10)
//            make.left.right.equalToSuperview()
//            make.size.equalTo(CGSize(width: kScreenWidth, height: 206))
//
//        }
//        partnerPlanView.layoutIfNeeded()
        
        /// 急速抢单
        robMonadView.snp.makeConstraints { (make) in
            make.top.equalTo(centerAdverView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.size.equalTo(CGSize(width: kScreenWidth, height: 210))
        }
        robMonadView.layoutIfNeeded()
        
        /// 急速抢单
//        quickRobView.snp.makeConstraints { (make) in
//            make.top.equalTo(robMonadView.snp.bottom).offset(10)
//            make.left.right.equalToSuperview()
//            make.size.equalTo(CGSize(width: kScreenWidth, height: 376))
////            make.bottom.equalToSuperview()
//        }
//        quickRobView.layoutIfNeeded()
        
        /// 资讯栏
//        messageReadView.snp.makeConstraints { (make) in
//            make.top.equalTo(infoView.snp.bottom).offset(8)
//            make.left.right.equalToSuperview()
//            make.size.equalTo(CGSize(width: kScreenWidth, height: 353))
//            make.bottom.equalToSuperview()
//        }
//        messageReadView.layoutIfNeeded()
        
        /// 底部视图
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(robMonadView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        bottomView.layoutIfNeeded()
        //layoutNeeded可以立即获取到frame
        mainView.layoutIfNeeded()
//        mainView.contentSize = CGSize(width: kScreenWidth, height: kScreenHeight * 3)
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
//        topAdBannerView.isAutoScroll = false
//        UIApplication.shared.statusBarStyle = .default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - 控件点击事件
    /// 定位
    ///
    /// - Parameter sender: 定位按钮
//    @objc func locationBtnClick(_ sender: UIButton) {
//        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//            locationManager.startUpdatingLocation()
//        }else {
//            let alertController = UIAlertController(title: "温馨提示", message: "请到设置->隐私->定位服务中开启!", preferredStyle: .alert)
//            let selectOne = UIAlertAction(title: "返回", style: .cancel, handler: nil)
//            let selectTwo = UIAlertAction(title: "去设置", style: .destructive) { (action) in
//                let url = URL(string: UIApplicationOpenSettingsURLString)
//                if UIApplication.shared.canOpenURL(url!) {
//                    UIApplication.shared.openURL(url!)
//                }
//            }
//            alertController.addAction(selectOne)
//            alertController.addAction(selectTwo)
//            present(alertController, animated: true, completion: nil)
//        }
//    }

    /// 通知中心
    ///
    /// - Parameter sender: 通知按钮
//    @objc func notifBtnClick(_ sender: UIButton) {
//        let vc = MessageCenterViewController()
//        navigationController?.pushViewController(vc, animated: true)
//    }
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
    
    ///获取热门产品
    func getHotProductData() {
        NetWorksManager.requst(with: kUrl_HotProduct, type: .post, parameters: nil) { [weak self] (jsonData, error) in
            if jsonData?["status"] == 200 {
                
                if let data = jsonData?["data"].array {
                    var cellArr = [ProductModel]()
                    for dict in data {
                        cellArr.append(ProductModel(with: dict))
                    }
//                    self?.hotAgencyView.cellDataArr = cellArr
                    self?.hotProductView.cellDataArr = cellArr
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
//                    self?.quickRobView.cellArr = cellArr
                    self?.robMonadView.cellDataArr = cellArr
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
                    self?.activityArr.removeAll()
                    var imgArr = [String]()
                    for data in activity {
                        let model = HomePageModel(with: data)
                        imgArr.append(model.img)
                        self?.activityArr.append(model)
                    }
//                    self?.partnerPlanView.dataArr = (self?.activityArr)!
                    self?.centerAdverView.serverImgArray = imgArr
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
//    func getHotNewsData() {
//        var parameters = [String: Any]()
//        parameters["key"] = NewsAppKey
//        parameters["type"] = "caijing"
//        NetWorksManager.requst(with: kUrl_HotNews, type: .post, parameters: parameters) { [weak self] (jsonData, error) in
//            if jsonData?["result"]["stat"].intValue == 1 {
//                if let dataArr = jsonData?["result"]["data"].array {
//                    var newsArr = [ResourceModel]()
//                    for index in 0...2 {
//                        if !(dataArr[index].isEmpty) {
//                            newsArr.append(ResourceModel(with: dataArr[index]))
//                        }else {
//                            newsArr.append(ResourceModel())
//                        }
//                    }
//                    self?.messageReadView.messageDataArr = newsArr
//                    self?.messageReadView.tableView.reloadData()
//                }
//            }else {
//                if error == nil {
//                    if let msg = jsonData?["reason"].stringValue {
//                        JSProgress.showFailStatus(with: msg)
//                    }
//                }else {
//                    JSProgress.showFailStatus(with: "请求失败")
//                }
//            }
//        }
//    }
}

//MARK: - 滚动代理
extension HomePageViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
//        let offsetY = scrollView.contentOffset.y
//        if (offsetY > NAVBAR_COLORCHANGE_POINT)
//        {
//            let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / CGFloat(64)
//            navView.alpha = alpha
//            statusBarColor = .lightContent
//            isHiddenStatus = false
//        }else if offsetY < 0 {
//            navView.alpha = 0
//            isHiddenStatus = true
//            searchView.alpha = (offsetY + 32) / 32
//            addressBtn.alpha = (offsetY + 32) / 32
//        }
//        else
//        {
//            addressBtn.alpha = 1
//            searchView.alpha = 1
//            navView.alpha = 0
//            statusBarColor = .default
//            isHiddenStatus = false
//        }
    }
}

//MARK: - 顶部广告栏代理
extension HomePageViewController: TopAdverViewDelegate {
    /// 点击图片回调
    func topAdverViewDidSelect(at index: Int, cycleScrollView: WRCycleScrollView) {
        switch cycleScrollView {
        case centerAdverView:
            guard !activityArr[index].url.isEmpty else {
                return
            }
            let vc = ActivityCenterViewController()
            vc.url = activityArr[index].url
            vc.title = activityArr[index].title
            Utils.controlJump(vc, isNav: true, jumpType: .ControlJumpTypePush)
        default:break
        }
    }
    /// 图片滚动回调
    func topAdverViewDidScroll(to index: Int, cycleScrollView: WRCycleScrollView) {
    }
}

//MARK: - 工具栏代理
extension HomePageViewController: FunctionViewDelegate {
    func buttonDidSelect(at index: Int) {
        switch index {
        case 0:
            let vc = BusinessResourceViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = LoansCollegeViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = VideoCenterViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = MessageReadViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = SignInViewController.loadStoryboard()
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
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //实现滑动返回功能
        if viewController == self.navigationController?.viewControllers[0] {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self.popDelegate
        }else {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        }
    }
}

//MARK: - CLLocationManager代理
//extension HomePageViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let currLocation = locations.last {
//            print(currLocation.coordinate.longitude)
//            print(currLocation.coordinate.latitude)
//            UserManager.shareManager.userModel.lat = currLocation.coordinate.latitude
//            UserManager.shareManager.userModel.lng = currLocation.coordinate.longitude
//
//            let geocoder: CLGeocoder = CLGeocoder()
//            geocoder.reverseGeocodeLocation(currLocation, completionHandler: { [weak self] (placemarks, error) in
//
//                self?.locationManager.stopUpdatingLocation()
//
//                if (error == nil) {//转换成功，解析获取到的各个信息
//                    guard let placemark = placemarks?.first else{
//                        return
//                    }
////                    print(placemark.name ?? "")
////                    print(placemark.locality ?? "")
//                    let address = placemark.locality?.replacingOccurrences(of: "市", with: "") ?? "定位"
////                    self?.addressBtn.set(image: #imageLiteral(resourceName: "ICON-xiala"), title: address, titlePosition: .left, additionalSpacing: 2, state: .normal)
//                    self?.customNavView.addressBtn.set(image: #imageLiteral(resourceName: "xial"), title: address, titlePosition: .left, additionalSpacing: 2, state: .normal)
//                    UserManager.shareManager.userModel.location = address
//                }else {
//                    print("转换失败")
//                }
//            })
//        }
//
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error)
//    }
//}

//MARK: - TextFiled代理
extension HomePageViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let vc = SearchViewController()
        let navVC = AXDNavigationController(rootViewController: vc)
        navigationController?.present(navVC, animated: true, completion: nil)
        return false
    }
}

