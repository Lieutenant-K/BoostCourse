//
//  ViewController.swift
//  Album
//
//  Created by 김윤수 on 2022/01/13.
//

import UIKit
import Photos

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PHPhotoLibraryChangeObserver {
    
    // MARK: Properties
    
    var collectionView: UICollectionView!
    let cellIdentifier = "cell"
    var fetchResult: PHFetchResult<PHAssetCollection>!
    let imageManager = PHImageManager()

    // MARK: Method
    
    func addView(){
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.itemSize = CGSize(width: 180, height: 220)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        self.view.addSubview(collection)
        
        collection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        
        collection.delegate = self
        collection.dataSource = self
        
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        collection.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        collection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        collection.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
        collection.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.collectionView = collection
        
    }
    
    func requestCollection() {
        
        let assetCollection = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        self.fetchResult = assetCollection
        
    }
    
    func checkAuthorization() {
        
        let authorization = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        switch authorization {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) {
                [unowned self] status in
                switch status {
                case .authorized:
                    print("사용자가 승인함")
                    PHPhotoLibrary.shared().register(self)
                    self.requestCollection()
                    OperationQueue.main.addOperation {
                        self.collectionView.reloadData()
                    }
                case.denied:
                    print("사용자가 거부함")
                default:
                    break
                }
            }
        case .restricted:
            print("제한됨")
        case .denied:
            print("거부됨")
        case .authorized:
            print("승인됨")
            self.requestCollection()
            PHPhotoLibrary.shared().register(self)
        default:
            print("default")
        }
        
    }
    
    // MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let asset = PHAsset.fetchAssets(in: self.fetchResult.object(at: indexPath.row), options: fetchOption)
        
        imageManager.requestImage(for: asset.object(at: 0), targetSize: CGSize(width: 175, height: 175), contentMode: .aspectFill, options: nil, resultHandler: {image, info in
            cell.imageView?.image = image
        })
        
        cell.textLabel.text = self.fetchResult.object(at: indexPath.row).localizedTitle
        cell.countLabel.text = "\(asset.count)"
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell else{
            return
        }
        
        
        
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let correntAssetCollection = self.fetchResult.object(at: indexPath.row)
        
        let next = SecondViewController(collection: correntAssetCollection, assets: PHAsset.fetchAssets(in: correntAssetCollection, options: fetchOption))
        
        
        next.navigationItem.title = cell.textLabel.text
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        if let change = changeInstance.changeDetails(for: self.fetchResult){
            self.fetchResult = change.fetchResultAfterChanges
        }
        
        OperationQueue.main.addOperation {
            self.collectionView.reloadData()
        }
    }
    
    
    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "앨범"

        self.checkAuthorization()
        self.addView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isToolbarHidden = true
    }


}

