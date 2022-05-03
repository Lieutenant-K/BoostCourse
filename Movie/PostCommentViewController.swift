//
//  PostCommentViewController.swift
//  Movie
//
//  Created by 김윤수 on 2022/02/01.
//

import UIKit

class PostCommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    
    // MARK: Properties
    
    var tableView: UITableView!
    var movieTitle: String!
    var grade: Int!
    var movieId: String!
    var userRatingCell: UserRatingCell!
    var editCommentCell: EditCommentCell!
    let userRatingCellIdentifier = "userRatingCell"
    let editCommentCellIdentifier = "editCommentCell"
    
    
    
    // MARK: Method
    
    func setNavigation() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.touchDoneButton(_:)))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.touchCancleButton(_:)))
        
        self.navigationItem.title = "한줄평 작성"
        
    }
    
    func addTableView() {
        
        let table = UITableView(frame: .zero, style: .grouped)
        
        self.view.addSubview(table)
        
        table.delegate = self
        table.dataSource = self
        
        // 테이블뷰 재사용 셀 등록
        table.register(UserRatingCell.self, forCellReuseIdentifier: self.userRatingCellIdentifier)
        table.register(EditCommentCell.self, forCellReuseIdentifier: self.editCommentCellIdentifier)
        
        // 테이블뷰 설정
        table.sectionHeaderTopPadding = 0
        
        
        // 테이블뷰 오토 레이아웃
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.tableView = table
        
    }
    
    
    // MARK: Action
    
    @objc func touchDoneButton(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "작성 오류", message: "닉네임과 한줄평을 모두 썼는지 확인해주세요", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .cancel) { action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        
        guard let name = self.editCommentCell.nicknameField.text, let comment = self.editCommentCell.commentView.text else {
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if name.isEmpty || comment.isEmpty {
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let reple = Reple(rating: Double(self.userRatingCell.slider.value), writer: name, movieId: self.movieId, contents: comment)
        postData("comment", reple, PostedComment.self, DidRecieveRepleNotification)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func touchCancleButton(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    
    // MARK: Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // 테이블뷰 내부의 각 행에 대한 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: self.userRatingCellIdentifier, for: indexPath) as! UserRatingCell
            
            cell.titleLabel.text = self.movieTitle
            cell.gradeImage.image = UIImage(named: "ic_\(self.grade!)")
            
            self.userRatingCell = cell
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: self.editCommentCellIdentifier, for: indexPath) as! EditCommentCell
            
            self.editCommentCell = cell
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
    }
    
    // 테이블뷰 내부 각 행의 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // 셀 내부 컨텐츠에 따라 높이 자동 설정
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(false)
        return true
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let gesture = UITapGestureRecognizer()
        gesture.delegate = self
        self.view.addGestureRecognizer(gesture)
        
        self.setNavigation()
        self.addTableView()
        // Do any additional setup after loading the view.
    }

}
