//
//  MovieListCollectionCell.swift
//  Movie
//
//  Created by 김윤수 on 2022/01/27.
//

import UIKit

class MovieListCollectionCell: UICollectionViewCell {
    
    var thumb: UIImageView!
    var titleLabel: UILabel!
    var dataLabel: UILabel!
    var dateLabel: UILabel!
    var gradeImage: UIImageView!
    
    func addThumbView() {
        
        let image = UIImageView()
        
        self.contentView.addSubview(image)
        
        image.backgroundColor = nil
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        image.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        image.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        self.thumb = image
        
        
    }
    
    func addTitleView(){
        
        let label = UILabel()
        
        self.contentView.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.thumb.bottomAnchor, constant: 5).isActive = true
        label.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        label.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        label.centerXAnchor.constraint(equalTo: self.thumb.centerXAnchor).isActive = true
        
        self.titleLabel = label
        
    }
    
    func addDataLabel() {
        
        let label = UILabel()
        
        self.contentView.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 15)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5).isActive = true
        label.centerXAnchor.constraint(equalTo: self.titleLabel.centerXAnchor).isActive = true
        
        self.dataLabel = label
        
        
    }
    
    func addDateLabel() {
        
        let label = UILabel()
        
        self.contentView.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 15)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.dataLabel.bottomAnchor, constant: 5).isActive = true
        label.centerXAnchor.constraint(equalTo: self.dataLabel.centerXAnchor).isActive = true
        
        self.dateLabel = label
        
        
    }
    
    func addGradeImage() {
        
        let image = UIImageView()
        
        self.contentView.addSubview(image)
        image.contentMode = .scaleAspectFit
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        image.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 5).isActive = true
        image.widthAnchor.constraint(equalToConstant: 25).isActive = true
        image.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.gradeImage = image
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("init")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addThumbView()
        self.addTitleView()
        self.addDataLabel()
        self.addDateLabel()
        self.addGradeImage()
        
    }
    
    
    
    
}
