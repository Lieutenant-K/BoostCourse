//
//  CollectionViewController.swift
//  Movie
//
//  Created by 김윤수 on 2022/01/26.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: Properties
    
    var collection: UICollectionView?
    let cellIdentifier = "cell"
    var movies: [Movie] = []
    let subURL = "movies"
    
    
    // MARK: Method
    
    func addCollectionView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: 175, height: 330)
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 10
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        self.view.addSubview(collection)
        
        collection.delegate = self
        collection.dataSource = self
        collection.register(MovieListCollectionCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        
        collection.refreshControl = UIRefreshControl()
        collection.refreshControl?.addTarget(self, action: #selector(self.scrollToRefresh), for: .valueChanged)
        
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        collection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collection.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.collection = collection
        
        
    }
    
    
    func setNavigation() {
        
        self.navigationItem.title = "예매율순"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_settings"), style: .plain, target: self, action: #selector(self.touchSettingButton(_:)))
        
    }
    
    // MARK: Action
    
    @objc func receivedData(_ noti: Notification) {
        
        guard let data = noti.userInfo?["data"] as? MovieList else {
            return
        }
        
        self.movies = data.movies
        
        OperationQueue.main.addOperation {
            self.collection?.reloadData()
            self.navigationItem.title = naviTitle[data.order]
        }
        
    }
    
    @objc func touchSettingButton(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: .actionSheet)
        
        for i in 0...2 {
            
            let orderAction = UIAlertAction(title: naviTitle[i], style: .default) { action in
                
                requestData(self.subURL, "order_type=\(i)", MovieList.self, DidReceiveMovieListNotification)
            }
            
            alert.addAction(orderAction)
            
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func scrollToRefresh(_ sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.collection?.reloadData()
            sender.endRefreshing()
        }
    }
    
    
    // MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! MovieListCollectionCell
        
        let movie = self.movies[indexPath.row]
        
        cell.titleLabel.text = movie.title
        cell.dataLabel.text = "\(movie.reserveGrade)위(\(movie.userRating)) / \(movie.reserveRate)%"
        cell.dateLabel.text = movie.date
        cell.thumb.image = nil
        
        let image = UIImage(named: "ic_\(movie.grade)")
        cell.gradeImage.image = image
        
        DispatchQueue.global().async {
            
            guard let url = URL(string: movie.thumb) else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                if let cell = collectionView.cellForItem(at: indexPath) as? MovieListCollectionCell {
                    
                    cell.thumb.image = UIImage(data: data)
                    
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.row]
        
        let detailViewController = DetailViewController()
        
        detailViewController.navigationItem.titleView = {
        
            let title = UILabel()
            
            title.text = movie.title
            title.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            
            return title
            
        }()
        
        
        requestData("movie", "id=\(movie.id)", MovieDetail.self, DidReceiveMovieDetailNotification)
        requestData("comments","movie_id=\(movie.id)", Comments.self, DidReceiveCommentsNotification)
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.addCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // indicatorView는 한 번에 하나의 뷰에만 서브뷰로 등록될 수 있다.
        self.view.addSubview(indicatorView)
        self.view.bringSubviewToFront(indicatorView)
        indicatorView.center = self.view.center
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.receivedData(_:)), name: DidReceiveMovieListNotification, object: nil)
        self.setNavigation()
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
