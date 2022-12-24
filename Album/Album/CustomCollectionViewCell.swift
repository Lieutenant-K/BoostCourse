//
//  CustomCollectionViewCell.swift
//  Album
//
//  Created by 김윤수 on 2022/01/16.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var textLabel: UILabel!
    var countLabel: UILabel!
    
    func addImageView() {
        
        let imageView = UIImageView()
        
        self.contentView.addSubview(imageView)
        
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        
        imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        
        imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
        imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -40).isActive = true
                
        self.imageView = imageView
        
    }
    
    func addTextLabel() {
        
        let label = UILabel()
        
        self.contentView.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 3).isActive = true
        
        label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        
        self.textLabel = label
        
    }
    
    func addCountLabel() {
        
        let label = UILabel()
        
        self.contentView.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: self.textLabel.bottomAnchor, constant: 1).isActive = true
        
        label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        
        self.countLabel = label
        
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.backgroundColor = .white
        
        self.addImageView()
        self.addTextLabel()
        self.addCountLabel()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white

        self.addImageView()
        self.addTextLabel()
        self.addCountLabel()
    }
}
