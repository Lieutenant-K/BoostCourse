//
//  ThirdViewController.swift
//  Album
//
//  Created by 김윤수 on 2022/01/20.
//

import UIKit
import Photos
    
class ThirdViewController: UIViewController, UIScrollViewDelegate, PHPhotoLibraryChangeObserver, UIGestureRecognizerDelegate {

    
    // MARK: Properties
    
    var scrollView: UIScrollView!
    var asset: PHAsset!
    var imageView: UIImageView!
    let imageManager = PHImageManager()
    var favorite: String {
        if self.asset.isFavorite {
            return "❤️"
        }
        else {
            return "🖤"
        }
    }
    
    
    // MARK: Method
    
    func addScrollView() {
        
        let scroll = UIScrollView()
        
        self.view.addSubview(scroll)
        
        scroll.delegate = self
        
        let gesture = UITapGestureRecognizer()
        gesture.delegate = self
        scroll.addGestureRecognizer(gesture)
        
        scroll.maximumZoomScale = 5.0
        
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        scroll.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        scroll.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scroll.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
        scroll.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.scrollView = scroll
        
    }
    
    func addImageView() {
        
        let image = UIImageView()
        
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFit
        
        self.scrollView.addSubview(image)
        
        let requsetOption = PHImageRequestOptions()
        requsetOption.deliveryMode = .highQualityFormat
        
        self.imageManager.requestImage(for: self.asset, targetSize: CGSize(width: self.asset.pixelWidth, height: self.asset.pixelHeight), contentMode: .aspectFit, options: requsetOption, resultHandler: { img, _ in
            image.image = img
            }
        )
        
        
        image.translatesAutoresizingMaskIntoConstraints = false
        if let superview = image.superview {
            image.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            image.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            image.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
            image.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
            image.widthAnchor.constraint(equalTo: superview.widthAnchor).isActive = true
            image.heightAnchor.constraint(equalTo: superview.heightAnchor).isActive = true
            
        }
        
        self.imageView = image
    }
    
    func setTitle() {
        
        let view = UIStackView()
        let titleLabel = UILabel()
        let subtitleLabel = UILabel()
        
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fillEqually
        view.addArrangedSubview(titleLabel)
        view.addArrangedSubview(subtitleLabel)
        
        
        if let date = asset.creationDate {
            let dateFormatter = DateFormatter()
            let timeFormatter = DateFormatter()
            
            dateFormatter.dateStyle = .short
            dateFormatter.locale = .init(identifier: "ko_KR")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            timeFormatter.timeStyle = .medium
            timeFormatter.dateFormat = "a hh:mm:ss"
            timeFormatter.locale = .init(identifier: "en_US")
            
            titleLabel.text = dateFormatter.string(from: date)
            subtitleLabel.text = timeFormatter.string(from: date)
            
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        subtitleLabel.textColor = .gray
        subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        self.navigationItem.titleView = view
        
        
        
    }
    
    func addBarButton() {
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.touchShareButton(_:)))
        
        
        let favoriteButton = UIBarButtonItem(title: self.favorite, style: .plain, target: self, action: #selector(self.touchFavoriteButton(_:)))
        
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(self.touchDeleteButton(_:)))
        
        self.toolbarItems = [shareButton, UIBarButtonItem.flexibleSpace(), favoriteButton, UIBarButtonItem.flexibleSpace(), deleteButton]
    }
    
    
    //MARK: Delegate
    
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        let change = changeInstance.changeDetails(for: self.asset)
        
        if let asset = change?.objectAfterChanges {
            self.asset = asset
            OperationQueue.main.addOperation {
                self.toolbarItems?[2].title = self.favorite
            }
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
    
        self.navigationController?.setToolbarHidden(true, animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.view.backgroundColor = .black
        self.imageView.backgroundColor = .black
        
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
        if scale == 1.0 {
            self.navigationController?.setToolbarHidden(false, animated: true)
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            self.view.backgroundColor = .white
            self.imageView.backgroundColor = .white
        }
        
    }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {

        guard let navi = self.navigationController else { return true }
        if self.scrollView.zoomScale == 1.0 {
            navi.setToolbarHidden(!navi.isToolbarHidden, animated: false)
            navi.setNavigationBarHidden(!navi.isNavigationBarHidden, animated: false)
        }
        
        return true
    }
    
    
    // MARK: IBAction
    
    @IBAction func touchFavoriteButton(_ sender: UIBarButtonItem) {
        
        PHPhotoLibrary.shared().performChanges(
            {
                let request = PHAssetChangeRequest.init(for: self.asset)
                request.isFavorite = !self.asset.isFavorite
            }, completionHandler: nil)
        
    }
    
    @IBAction func touchDeleteButton(_ sender: UIBarButtonItem) {
        
        PHPhotoLibrary.shared().performChanges({PHAssetChangeRequest.deleteAssets([self.asset!] as NSArray )}, completionHandler: {(success, error) in
            if success {
                print("삭제 완료!")
                OperationQueue.main.addOperation {
                    self.navigationController?.popViewController(animated: true)}
            }
        })
        
    }
    
    @IBAction func touchShareButton(_ sender: UIBarButtonItem) {
        
        guard let image = self.imageView.image else {
            return
        }
        
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        activityVC.completionWithItemsHandler = {(activity, completion, items, error) in
            if completion{
                print("작업 성공!")
            }
        }
        
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        PHPhotoLibrary.shared().register(self)
        
        self.addBarButton()
        self.addScrollView()
        self.addImageView()
        self.setTitle()
        // Do any additional setup after loading the view.
    }
    
    convenience init(_ asset: PHAsset) {
        self.init()
        self.asset = asset
        
    }

}
