//
//  ViewController.swift
//  Movie
//
//  Created by 김윤수 on 2022/01/26.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: Properties

    var tableView: UITableView?
    var movies:[Movie] = []
    let cellIdentifier = "cell"
    let subURL = "movies"
    
    
    // MARK: Method
    
    func addTableView() {
        
        let table = UITableView(frame: .zero, style: .plain)
        
        self.view.addSubview(table)
        
        // 테이블뷰 설정
        
        table.delegate = self
        table.dataSource = self
        table.register(MovieListTableCell.self, forCellReuseIdentifier: self.cellIdentifier)
        
        
        // 뷰를 아래로 당길 시 새로고침 => UIRefreshControl 사용
        table.refreshControl = UIRefreshControl()
        table.refreshControl?.addTarget(self, action: #selector(self.scrollToRefresh(_:)), for: .valueChanged)
        
        
        // 오토레이아웃
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.tableView = table
        
    }
    
    
    func setNavigation() {
        
        self.navigationItem.title = "예매율순"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_settings"), style: .plain, target: self, action: #selector(self.touchSettingButton(_:)))
        
    }
    
    
    // MARK: Action
    
    
    @objc func touchSettingButton(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: .actionSheet)
        
        for i in 0...2 {
            
            let orderAction = UIAlertAction(title: naviTitle[i], style: .default) { action in
                requestData(self.subURL, "order_type=\(i)", MovieList.self, DidReceiveMovieListNotification)
            }
            
            alert.addAction(orderAction)
            
        }
        
        // 모달 방식으로 AlertController를 보여줌
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func scrollToRefresh(_ sender: UIRefreshControl) {
        
        // 현재 시간부터 1초 대기하고 메인큐로 작업을 보냄
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tableView?.reloadData()
            sender.endRefreshing()
        }
        
    }
    
    @objc func receivedData(_ noti: Notification) {
        
        // NotificationCenter로부터 Notification을 받았을 때 실행되는 메소드
        // Notification을 보낸 스레드와 동일한 백그라운드 스레드에서 실행된다.
        
        guard let data = noti.userInfo?["data"] as? MovieList else {
            return
        }
        
        self.movies = data.movies
        
        // UI관련 작업은 메인 스레드로 보냄.
        OperationQueue.main.addOperation {
            self.tableView?.reloadData()
            self.navigationItem.title = naviTitle[data.order]
        }
        
    }
    
    
    
    // MARK: Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! MovieListTableCell
        
        let movie = self.movies[indexPath.row]
        
        cell.titleLabel.text = movie.title
        cell.dataLabel.text = "평점: \(movie.userRating) 예매순위: \(movie.reserveGrade) 예매율: \(movie.reserveRate)"
        cell.dateLabel.text = "개봉일: \(movie.date)"
        cell.thumb.image = nil
        
        let image = UIImage(named: "ic_\(movie.grade)")
        cell.gradeImage.image = image
        
        indicatorView.startAnimating()
        
        
        // 네트워킹을 통해 셀 이미지 데이터를 받아오는 작업
        // 작업이 완료될 때까지 기다리지 않기 위해 백그라운드 스레드로 작업을 보냄.
        
        DispatchQueue.global().async {
            
            guard let thumb = URL(string: movie.thumb) else { return }
            guard let data = try? Data(contentsOf: thumb) else { return }
            
            DispatchQueue.main.async {
                if let cell = tableView.cellForRow(at: indexPath) as? MovieListTableCell {
                    cell.thumb.image = UIImage(data: data)
                }
                
                indicatorView.stopAnimating()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // NotificationCenter에 특정 알림에 대해 알림을 받는 뷰 컨트롤러 등록
        NotificationCenter.default.addObserver(self, selector: #selector(self.receivedData), name: DidReceiveMovieListNotification, object: nil)
        
        self.setNavigation()
        self.addTableView()
        requestData(self.subURL, "order_type=0", MovieList.self
                    , DidReceiveMovieListNotification)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // indicatorView는 한 번에 하나의 뷰에만 서브뷰로 등록될 수 있다.
        self.view.addSubview(indicatorView)
        self.view.bringSubviewToFront(indicatorView)
        indicatorView.center = self.view.center
    }


}

