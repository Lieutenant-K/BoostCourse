//
//  MovieInfoCell.swift
//  Movie
//
//  Created by 김윤수 on 2022/01/30.
//

import UIKit

class MovieInfoCell: UITableViewCell {

    var thumb: UIImageView!
    var titleLabel: UILabel!
    var dateLabel: UILabel!
    var subLabel: UILabel!
    var gradeImage: UIImageView!
    var stackView: UIStackView?
    var reservationLabel: UILabel?
    var userRateLabel: UILabel?
    var audienceLabel: UILabel?
    var starStack: UIStackView?
    
    func addThumbView() {
        
        let image = UIImageView()
        
        self.contentView.addSubview(image)
        
        image.image = UIImage(named: "img_placeholder")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        image.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        
        image.heightAnchor.constraint(equalToConstant: 180).isActive = true
        image.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        self.thumb = image
        
        
    }
    
    func addTitleView(){
        
        let label = UILabel()
        
        self.contentView.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 40).isActive = true
        label.leadingAnchor.constraint(equalTo: self.thumb.trailingAnchor, constant: 10).isActive = true
        
        self.titleLabel = label
        
    }
    
    func addDateLabel() {
        
        let label = UILabel()
        
        self.contentView.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 20)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.thumb.trailingAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15).isActive = true
        
        self.dateLabel = label
        
        
    }
    
    func addDataLabel() {
        
        let label = UILabel()
        
        self.contentView.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.thumb.trailingAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        
        self.subLabel = label
        
        
    }
    
    func addGradeImage() {
        
        let image = UIImageView()
        
        self.contentView.addSubview(image)
        image.contentMode = .scaleAspectFit
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 5).isActive = true
        image.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor).isActive = true
        image.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        image.widthAnchor.constraint(equalToConstant: 22).isActive = true
        image.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        self.gradeImage = image
        
        
    }
    
    func addStackView() {

        let reserveRateView: UIView = {
            
            let view = UIView()
            view.backgroundColor = .white
            
            let title = UILabel()
            view.addSubview(title)
            
            title.text = "예매율"
            title.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            title.translatesAutoresizingMaskIntoConstraints = false
            
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            title.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -15).isActive = true
            
            let subtitle = UILabel()
            view.addSubview(subtitle)
            
            subtitle.font = UIFont.systemFont(ofSize: 18)
            subtitle.translatesAutoresizingMaskIntoConstraints = false
            
            subtitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            subtitle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 15).isActive = true
            
            self.reservationLabel = subtitle
            
            return view
        }()
        
        let userRateView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            
            let title = UILabel()
            view.addSubview(title)
            
            title.text = "평점"
            title.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            
            title.translatesAutoresizingMaskIntoConstraints = false
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            title.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
            
            
            let subtitle = UILabel()
            view.addSubview(subtitle)
            
            subtitle.font = UIFont.systemFont(ofSize: 18)
            
            subtitle.translatesAutoresizingMaskIntoConstraints = false
            subtitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            subtitle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 10).isActive = true
            
            self.userRateLabel = subtitle
            
            
            let starStack = StarStack()
            view.addSubview(starStack)
            
            starStack.translatesAutoresizingMaskIntoConstraints = false
            starStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            starStack.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 5).isActive = true
            starStack.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            starStack.heightAnchor.constraint(equalToConstant: 17).isActive = true
            starStack.widthAnchor.constraint(equalToConstant: 85).isActive = true
            
            self.starStack = starStack
            
            return view
        }()
        
        let audienceView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            
            let title = UILabel()
            view.addSubview(title)
            
            title.text = "누적관객수"
            title.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            
            title.translatesAutoresizingMaskIntoConstraints = false
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            title.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -15).isActive = true
            
            
            let subtitle = UILabel()
            view.addSubview(subtitle)
            
            subtitle.font = UIFont.systemFont(ofSize: 18)
            subtitle.translatesAutoresizingMaskIntoConstraints = false
            
            subtitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            subtitle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 15).isActive = true
            
            self.audienceLabel = subtitle
            
            return view
            
        }()
        
        
        let stack = UIStackView(arrangedSubviews: [reserveRateView, userRateView, audienceView])
        stack.axis = .horizontal
        stack.backgroundColor = .systemGray3
        stack.distribution = .fillEqually
        stack.spacing = 1
        
        self.contentView.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
        stack.topAnchor.constraint(equalTo: self.thumb.bottomAnchor, constant: 15).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -15).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15).isActive = true
        stack.heightAnchor.constraint(lessThanOrEqualToConstant: 80).isActive = true
        
        self.stackView = stack
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("init")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addThumbView()
        self.addTitleView()
        self.addDateLabel()
        self.addDataLabel()
        self.addGradeImage()
        self.addStackView()
        
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
