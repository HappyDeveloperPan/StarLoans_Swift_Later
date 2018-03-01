//
//  VideoPlayViewController.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/12/14.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import BMPlayer

class VideoPlayViewController: UIViewController {
    
    weak var navController: UINavigationController?
    
    var videoModel: VideoModel = VideoModel()
    
    lazy var player: BMPlayer = { [unowned self] in
        var controller: BMPlayerControlView? = nil
        let player = BMPlayer(customControlView: controller)
        self.view.addSubview(player)
        return player
    }()

    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        
        player.delegate = self
        player.backBlock = { [unowned self] (isFullScreen) in
            let _ = self.navigationController?.popViewController(animated: true)
        }
//        let asset = BMPlayerResource(url: URL(string: "http://wvideo.spriteapp.cn/video/2016/0328/56f8ec01d9bfe_wpd.mp4")!,name: "原来你我相爱")
//        let asset = BMPlayerResource(url: URL(string: "http://wvideo.spriteapp.cn/video/2016/0328/56f8ec01d9bfe_wpd.mp4")!, name: "原来你我相爱", cover: nil, subtitle: nil)
        let url = videoModel.video_address
        if !url.isEmpty {
            let asset = BMPlayerResource(url: URL(string: url)!, name: videoModel.video_title, cover: nil, subtitle: nil)
            player.setVideo(resource: asset)
        }
//        let asset = BMPlayerResource(url: URL(string: "")!, name: "原来你我相爱", cover: nil, subtitle: nil)
//        let asset = BMPlayerResource(url: URL(string: videoModel.video_address)!, name: "原来你我相爱", cover: nil, subtitle: nil)
//        player.setVideo(resource: asset)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.delegate = self
        navController = navigationController
        //开启屏幕旋转
        (UIApplication.shared.delegate as? AppDelegate)?.allowRotation = true
        // 使用手势返回的时候，调用下面方法
        player.autoPlay()
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        player.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(player.snp.width).multipliedBy(9.0/16.0).priority(500)
        }
        player.layoutIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 使用手势返回的时候，调用下面方法
        player.pause(allowAutoPlay: true)
        //关闭屏幕旋转
        (UIApplication.shared.delegate as? AppDelegate)?.allowRotation = false
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        // 使用手势返回的时候，调用下面方法手动销毁
        player.prepareToDealloc()
        print("VideoPlayViewController Deinit")
    }

}

// MARK:- BMPlayerDelegate example
extension VideoPlayViewController: BMPlayerDelegate {
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        player.snp.remakeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            if isFullscreen {
                make.bottom.equalTo(view.snp.bottom)
            } else {
                make.height.equalTo(view.snp.width).multipliedBy(9.0/16.0).priority(500)
            }
        }
    }
    
    // Call back when playing state changed, use to detect is playing or not
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        print("| BMPlayerDelegate | playerIsPlaying | playing - \(playing)")
    }
    
    // Call back when playing state changed, use to detect specefic state like buffering, bufferfinished
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        print("| BMPlayerDelegate | playerStateDidChange | state - \(state)")
    }
    
    // Call back when play time change
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        //        print("| BMPlayerDelegate | playTimeDidChange | \(currentTime) of \(totalTime)")
    }
    
    // Call back when the video loaded duration changed
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        //        print("| BMPlayerDelegate | loadedTimeDidChange | \(loadedDuration) of \(totalDuration)")
    }
}

//MARK: - UINavigationController代理
extension VideoPlayViewController: UINavigationControllerDelegate {
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
