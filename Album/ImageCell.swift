//
//  ImageCell.swift
//  Album
//
//  Created by 김윤수 on 2022/01/18.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = UIColor.lightGray.cgColor
                self.layer.borderWidth = 3.0
                self.imageView.alpha = 0.5
            }
            else {
                self.layer.borderWidth = 0.0
                self.layer.borderColor = nil
                self.imageView.alpha = 1.0
            }
        }
    }
    
    func addView() {
        
        let image = UIImageView()
        
        self.contentView.addSubview(image)
        
        image.backgroundColor = .white
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        
        image.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        image.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        
        image.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
        self.imageView = image
        
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addView()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        
    }
    
}
