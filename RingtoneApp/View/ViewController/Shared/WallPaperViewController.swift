//
//  VideoPlayerViewController.swift
//  VideoPlayerViewController
//
//  Created by Zhangali Pernebayev on 22.07.2021.
//

import UIKit
import AVFoundation
import RxCocoa
import RxSwift

class WallPaperViewController: UIViewController {
    enum WallPaperType {
        case live(videoURL: String, player: AVQueuePlayer? = nil, playerLooper: AVPlayerLooper? = nil)
        case regular(imageURL: String)
    }
    @IBOutlet weak var imageViewContainer: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playerView: VideoPlayerView!
    @IBOutlet weak var shareBtn: VerticalButton!
    @IBOutlet weak var downLoadBtn: VerticalButton!
    
    private let type: WallPaperType
    private var player: AVQueuePlayer? {
        didSet {
            playerView.player = player
        }
    }
    private var playerLooper: AVPlayerLooper?
    private let disposeBag = DisposeBag()
    
    init(type: WallPaperType) {
        self.type = type
        super.init(nibName: "WallPaperViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    private func setupViewController() {
        switch type {
        case .live(let videoURL, let player, let playerLooper):
            var newPlayer: AVQueuePlayer? = player
            var newLooper: AVPlayerLooper? = playerLooper
            if player == nil, let url = URL(string: videoURL) {
                let asset = AVAsset(url: url)
                let playerItem = AVPlayerItem(asset: asset)
                let player = AVQueuePlayer(playerItem: playerItem)
                newPlayer = player
                newLooper = AVPlayerLooper(player: player, templateItem: playerItem)
            }
            self.player = newPlayer
            self.playerLooper = newLooper
            
        case .regular(let imageURL):
            imageView.kf.setImage(with: URL(string: imageURL))
            scrollView.delegate = self
        }
        
        shareBtn.tapEvent.subscribe(onNext: {[unowned self]_ in
            self.share()
        }).disposed(by: disposeBag)
        downLoadBtn.tapEvent.subscribe(onNext: {[unowned self]_ in
            self.download()
        }).disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playerView.playVideoImmediately()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        playerView.pauseVideo()
    }
    
    private func share() {
        var items: [Any]
        switch type {
        case .live(let videoURL, _, _):
            items = ["Hey, check out this awesome live", videoURL]
        case .regular(let imageURL):
            items = ["Hey, check out this awesome image", imageURL]
        }
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    private func download() {
        switch type {
        case .live:
            saveVideo()
        case .regular:
            saveImage()
        }
    }
    
    private func saveVideo() {
        
    }
    
    private func saveImage() {
        guard let image = imageView.image else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompletionHandler), nil)
    }
    
    @objc func saveCompletionHandler(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
        let alert = UIAlertController(title: "Image saved to Photo library", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension WallPaperViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
