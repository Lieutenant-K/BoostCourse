//
//  CommentCell.swift
//  Movie
//
//  Created by 김윤수 on 2022/01/31.
//

import UIKit

class CommentCell: UITableViewCell {

    var profile: UIImageView!
    var userTitle: UILabel!
    var dateTitle: UILabel!
    var commentLabel: UILabel!
    var stars: UIStackView!
    
    func addProfileView() {
        
        let image = UIImageView()
        
        self.contentView.addSubview(image)
        
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "ic_user_loading")
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        image.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        image.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor,constant:  -10).isActive = true
        image.widthAnchor.constraint(equalToConstant: 80).isActive = true
        image.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.profile = image
        
        
    }
    
    func addUserTitle(){
        
        let label = UILabel()
        
        self.contentView.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15).isActive = true
        label.leadingAnchor.constraint(equalTo: self.profile.trailingAnchor, constant: 10).isActive = true
        
        self.userTitle = label
        
    }
    
    func addDateTitle() {
        
        let label = UILabel()
        
        self.contentView.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.profile.trailingAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: self.userTitle.bottomAnchor, constant: 5).isActive = true
        
        self.dateTitle = label
        
        
    }
    
    func addCommentLabel() {
        
        let label = UILabel()
        
        self.contentView.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping

        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.profile.trailingAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: self.dateTitle.bottomAnchor, constant: 5).isActive = true
        label.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        
        self.commentLabel = label
        
        
    }
    
    func addGradeImage() {
        
        let starStack = StarStack()
        self.contentView.addSubview(starStack)
        
        starStack.translatesAutoresizingMaskIntoConstraints = false
        
        starStack.centerYAnchor.constraint(equalTo: self.userTitle.centerYAnchor).isActive = true
        starStack.leadingAnchor.constraint(equalTo: self.userTitle.trailingAnchor, constant: 5).isActive = true
        starStack.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        starStack.heightAnchor.constraint(lessThanOrEqualToConstant: 17).isActive = true
        starStack.widthAnchor.constraint(lessThanOrEqualToConstant: 85).isActive = true
        
        self.stars = starStack
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("init")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addProfileView()
        self.addUserTitle()
        self.addDateTitle()
        self.addCommentLabel()
        self.addGradeImage()
        
        self.selectionStyle = .none
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
