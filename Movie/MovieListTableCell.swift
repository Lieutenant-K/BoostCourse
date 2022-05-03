//
//  MovieListTableCell.swift
//  Movie
//
//  Created by 김윤수 on 2022/01/26.
//

import UIKit

class MovieListTableCell: UITableViewCell {
    
    var thumb: UIImageView!
    var titleLabel: UILabel!
    var dataLabel: UILabel!
    var dateLabel: UILabel!
    var gradeImage: UIImageView!
    
    func addThumbView() {
        
        let image = UIImageView()
        
        self.contentView.addSubview(image)
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        image.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        image.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant:  -5).isActive = true
        image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        image.heightAnchor.constraint(greaterThanOrEqualToConstant: 140).isActive = true
        
        self.thumb = image
        
        
    }
    
    func addTitleView(){
        
        let label = UILabel()
        
        self.contentView.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15).isActive = true
        label.leadingAnchor.constraint(equalTo: self.thumb.trailingAnchor, constant: 10).isActive = true
        
        self.titleLabel = label
        
    }
    
    func addDataLabel() {
        
        let label = UILabel()
        
        self.contentView.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.thumb.trailingAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15).isActive = true
        label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        
        self.dataLabel = label
        
        
    }
    
    func addDateLabel() {
        
        let label = UILabel()
        
        self.contentView.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 18)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.thumb.trailingAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: self.dataLabel.bottomAnchor, constant: 10).isActive = true
        
        self.dateLabel = label
        
        
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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("init")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addThumbView()
        self.addTitleView()
        self.addDataLabel()
        self.addDateLabel()
        self.addGradeImage()
        
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
