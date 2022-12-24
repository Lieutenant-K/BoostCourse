//
//  SecondViewController.swift
//  Album
//
//  Created by 김윤수 on 2022/01/18.
//

import UIKit
import Photos

class SecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, PHPhotoLibraryChangeObserver {
    
    
    // MARK: Properties
    
    var assetCollection: PHAssetCollection!
    var fetchResult: PHFetchResult<PHAsset>!
    var collectionView: UICollectionView!
    let imageManager = PHImageManager()
    let cellIdentifier: String = "cell"
    var ascending = false
    var selectionMode = false
    
    
    
    // MARK: Method
    
    func addView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 6
        flowLayout.minimumLineSpacing = 6
        flowLayout.itemSize = CGSize(width: (self.view.bounds.width - 24)/3, height: 122)
        flowLayout.sectionInset = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        self.view.addSubview(collection)
        
        collection.register(ImageCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        collection.dataSource = self
        collection.delegate = self
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        collection.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        collection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        collection.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
        collection.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        self.collectionView = collection
        
    }
    
    func addBarItem(){
        
        guard let navi = self.navigationController else { return }
        
            // Navigation Item
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.touchSelectionButton(_:)))
        
        
            // Toolbar Item
        
        navi.isToolbarHidden = false
        
        let appearance = UIToolbarAppearance()
        appearance.configureWithDefaultBackground()
        
        navi.toolbar.standardAppearance = appearance
        navi.toolbar.scrollEdgeAppearance = appearance
        navi.toolbar.isTranslucent = true
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.touchShareButton(_:)))
        shareButton.isEnabled = false
        
        let sortButton = UIBarButtonItem(title: "최신순", style: .plain, target: self, action: #selector(self.touchSortButton(_:)))
        
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(self.touchDeleteButton(_:)))
        deleteButton.isEnabled = false
        
        self.setToolbarItems([shareButton, UIBarButtonItem.flexibleSpace() ,sortButton,UIBarButtonItem.flexibleSpace(), deleteButton], animated: true)
        
    }
    
    
    // MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! ImageCell
        
        cell.imageView.image = nil
        
        let asset = self.fetchResult.object(at: indexPath.row)

        let option = PHImageRequestOptions()
        option.deliveryMode = .fastFormat
        
        
        self.imageManager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth/2, height: asset.pixelHeight/2), contentMode: .aspectFit, options: nil) { (image, _) in
            
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
            
        }
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let count = collectionView.indexPathsForSelectedItems?.count{
            
            if count > 0 {
                self.toolbarItems?[4].isEnabled = true
                self.toolbarItems?[0].isEnabled = true
            }
                    
            self.navigationItem.title = "\(count)장 선택"
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if let count = collectionView.indexPathsForSelectedItems?.count{
            
            if count < 1 {
                self.toolbarItems?[4].isEnabled = false
                self.toolbarItems?[0].isEnabled = false
            }
            
            self.navigationItem.title = "\(count)장 선택"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if self.selectionMode {
            return true
        } else {
            
            let next = ThirdViewController(self.fetchResult.object(at: indexPath.row))
            
            self.navigationController?.pushViewController(next, animated: true)
            
            return false
        }
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        if let change = changeInstance.changeDetails(for: self.fetchResult){
            self.fetchResult = change.fetchResultAfterChanges
        }
        
        OperationQueue.main.addOperation {
            self.collectionView.reloadData()
        }
    }
    
    
    // MARK: IBAction
    
    @IBAction func touchSortButton(_ sender: UIBarButtonItem){
        
        self.ascending.toggle()
        
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: self.ascending)]
        self.fetchResult = PHAsset.fetchAssets(in: self.assetCollection, options: fetchOption)
        
        self.toolbarItems?[2].title = self.ascending ? "과거순" : "최신순"
        
        self.collectionView.reloadData()
        
    }
    
    @IBAction func touchShareButton(_ sender: UIBarButtonItem){
        
        var images: [UIImage] = []
        
        guard let selectedIndex = self.collectionView.indexPathsForSelectedItems else{
            return
        }
        
        for i in selectedIndex {
            
            if let image = (self.collectionView.cellForItem(at: i) as? ImageCell)?.imageView.image {
                images.append(image)
            }
        }
        
        let activityVC = UIActivityViewController(activityItems: images, applicationActivities: nil)
        
        activityVC.completionWithItemsHandler = {(activity, completion, items, error) in
            if completion {
                print("작업 성공!")
            }
        }
        
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    @IBAction func touchDeleteButton(_ sender: UIBarButtonItem){
        
        var willDeleteIndex: [Int] = []
        if let selectedIndex = self.collectionView.indexPathsForSelectedItems {
            for i in selectedIndex{
                willDeleteIndex.append(i.row)
            }
        }

        let asset = self.fetchResult.objects(at: IndexSet(willDeleteIndex))
        PHPhotoLibrary.shared().performChanges({PHAssetChangeRequest.deleteAssets(asset as NSArray)}, completionHandler: nil)
        
    }
    
    @IBAction func touchSelectionButton(_ sender: UIBarButtonItem){
        
        self.selectionMode.toggle()
        
        self.collectionView.allowsMultipleSelection.toggle()
        
        self.toolbarItems?[2].isEnabled.toggle()
        
        if !self.selectionMode {
            self.collectionView.allowsSelection = false
            self.toolbarItems?[4].isEnabled = false
            self.toolbarItems?[0].isEnabled = false
        }
        
        self.navigationItem.title = self.selectionMode ? "항목 선택" : self.assetCollection.localizedTitle
        sender.title = self.selectionMode ? "취소" : "선택"
        self.collectionView.allowsSelection = true
        
    }
    
    
    // MARK: LifeCycle

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        self.view.backgroundColor = .white
        PHPhotoLibrary.shared().register(self)
        
        self.addBarItem()
        self.addView()

        // Do any additional setup after loading the view.
    }
    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//
    convenience init(collection: PHAssetCollection, assets: PHFetchResult<PHAsset>) {
        self.init()
        self.assetCollection = collection
        self.fetchResult = assets
    }

}
