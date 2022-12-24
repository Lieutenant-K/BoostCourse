//
//  DetailViewController.swift
//  Movie
//
//  Created by 김윤수 on 2022/01/30.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: Properties
    
    var tableView: UITableView?
    var movieDetail: MovieDetail?
    var comments: [Comment] = []
    let subURL = "movie"
    let infoCellIdentifier = "infoCell"
    let synopsisCellIdentifier = "synopsisCell"
    let madeByCellIdentifier = "madeByCell"
    let commentCellIdentifier = "commentCell"
    
    
    // MARK: Method
    
    func addTableView() {
        
        let table = UITableView(frame: .zero, style: .grouped)
        
        self.view.addSubview(table)
        
        table.dataSource = self
        table.delegate = self
        
        // 셀 재사용을 위해 사용할 모든 커스텀셀을 등록
        table.register(MovieInfoCell.self, forCellReuseIdentifier: self.infoCellIdentifier)
        table.register(MovieSynopsisCell.self, forCellReuseIdentifier: self.synopsisCellIdentifier)
        table.register(MovieMadeByCell.self, forCellReuseIdentifier: self.madeByCellIdentifier)
        table.register(CommentCell.self, forCellReuseIdentifier: self.commentCellIdentifier)
        
        // 테이블뷰 설정
        table.sectionHeaderTopPadding = 0
        table.separatorStyle = .none
        
        
        // 테이블뷰 오토레이아웃
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        
        self.tableView = table
        
    }
    
    
    // MARK: Action
    
    @objc func receivedData(_ noti: Notification) {
        
        // NotificationCenter로부터 Notification을 받았을 때 실행되는 메소드
        // Notification을 보낸 스레드와 동일한 백그라운드 스레드에서 실행된다.
        
        switch noti.name {
            
        case DidReceiveMovieDetailNotification:
            if let data = noti.userInfo?["data"] as? MovieDetail {
                self.movieDetail = data
            }
        case DidReceiveCommentsNotification:
            if let data = noti.userInfo?["data"] as? Comments {
                self.comments = data.comments
            }
        case DidRecieveRepleNotification:
            DispatchQueue.main.async {
                requestData("comments", "movie_id=\(self.movieDetail!.id)", Comments.self, DidReceiveCommentsNotification)
            }
        default:
            return
        }
        
        // UI관련 작업은 메인 스레드로 보냄.
        OperationQueue.main.addOperation {
            self.tableView?.reloadData()
        }
        
    }
    
    
    @objc func touchPostingButton(_ sender: UIButton) {
        
        let postViewController = PostCommentViewController()
        
        postViewController.grade = movieDetail?.grade
        postViewController.movieTitle = movieDetail?.title
        postViewController.movieId = movieDetail?.id
        
        self.navigationController?.pushViewController(postViewController, animated: true)
        
    }
    
    
    // MARK: Delegate
    
    // 테이블뷰의 섹션별 각 row에 들어갈 cell 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let movie = self.movieDetail else { return UITableViewCell() }
        
        switch indexPath.section {
        
        case 0:
            // 영화 세부 정보

            let cell = tableView.dequeueReusableCell(withIdentifier: self.infoCellIdentifier, for: indexPath) as! MovieInfoCell
            
            DispatchQueue.global().async {
                guard let url = URL(string: movie.image) else { return }
                guard let data = try? Data(contentsOf: url) else { return }
                
                DispatchQueue.main.async {
                    cell.thumb.image = UIImage(data: data)
                }
            }
            
            cell.titleLabel.text = movie.title
            cell.dateLabel.text = "\(movie.date)개봉"
            cell.subLabel.text = "\(movie.genre) / \(movie.duration)분"
            cell.reservationLabel?.text = "\(movie.reserveGrade)위 \(movie.reserveRate)%"
            cell.userRateLabel?.text = "\(movie.userRating)"
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.groupingSeparator = ","
            
            cell.audienceLabel?.text = numberFormatter.string(from: NSNumber(value: movie.audience))
            cell.gradeImage.image = UIImage(named: "ic_\(movie.grade)")
            
            if let stack = cell.starStack?.arrangedSubviews as? [UIImageView] {
                let rate = movie.userRating
                calculateStar(stack, rate)
            }
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: self.synopsisCellIdentifier, for: indexPath) as! MovieSynopsisCell
            
            cell.text?.text = movie.synopsis
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: self.madeByCellIdentifier, for: indexPath) as! MovieMadeByCell
            
            cell.directorText?.text = movie.director
            cell.actorText?.text = movie.actor
            
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: self.commentCellIdentifier, for: indexPath) as! CommentCell
            
            let comment = self.comments[indexPath.row]
            
            cell.userTitle.text = comment.writer
            cell.commentLabel.text = comment.contents

            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateStyle = .long
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            cell.dateTitle.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(comment.timestamp)))
            
            if let stack = cell.stars.arrangedSubviews as? [UIImageView] {
                calculateStar(stack, comment.rating)
            }
            
            return cell
            
        default:
            return UITableViewCell()
            
        }
        
    }
    
    
    // 섹션별 행의 개수 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return self.comments.count
        }
        
        return 1
    }
    
    // 섹션 개수 설정
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 3 { return UITableView.automaticDimension }
        else { return 0 }
    }
    
    
    // 한줄평 헤더 설정
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 3 {
            
            let view = UIView()
            
            let title = UILabel()
            view.addSubview(title)
            view.backgroundColor = .white
            
            title.text = "한줄평"
            title.font = UIFont.systemFont(ofSize: 25, weight: .medium)
            
            title.translatesAutoresizingMaskIntoConstraints = false
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
            title.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
            title.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
            
            // 버튼 생성
            let button = UIButton(type: .system)
            view.addSubview(button)
            
            button.setImage(UIImage(named: "btn_compose"), for: .normal)
            button.tintColor = .red
            button.contentMode = .scaleAspectFill
            button.addTarget(self, action: #selector(self.touchPostingButton(_:)), for: .touchUpInside)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
            
            return view
            
        }
        
       return nil
    }
    
    
   // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
      
        self.addTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // indicatorView는 한 번에 하나의 뷰에만 서브뷰로 등록될 수 있다.
        self.view.addSubview(indicatorView)
        self.view.bringSubviewToFront(indicatorView)
        indicatorView.center = self.view.center
        
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.receivedData(_:)), name: DidReceiveMovieDetailNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.receivedData(_:)), name: DidReceiveCommentsNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.receivedData(_:)), name: DidRecieveRepleNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
