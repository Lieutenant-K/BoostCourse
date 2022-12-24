//
//  StarStack.swift
//  Movie
//
//  Created by 김윤수 on 2022/02/03.
//

import UIKit

class StarStack: UIStackView {
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .horizontal
        self.distribution = .fillEqually
        
        for _ in 1...5 {
            let image = UIImageView()
            image.image = UIImage(named: "ic_star_large")
            image.contentMode = .scaleAspectFit
            self.addArrangedSubview(image)
        }
    
    }
    

}
