//
//  StarSlider.swift
//  Movie
//
//  Created by 김윤수 on 2022/02/01.
//

import UIKit

class StarSlider: UISlider {
    
    var starView: UIStackView?
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let width = self.bounds.width
        let x = touch.location(in: self).x
        let divide = Float(width / x)
        self.value = self.maximumValue / divide
        
//        슬라이더 길이 = 100, 최댓값 10,
//        x가 50일때 값 5
//        x가 20일때 값 2
//        슬라이더 값 = 슬라이더 길이 / x값
        return true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.maximumValue = 10.0
        self.value = 0
        self.thumbTintColor = .clear
        self.maximumTrackTintColor = .clear
        self.minimumTrackTintColor = .clear
        
        
        // 설정한 수치에 따른 별을 보여주는 뷰
        
        let stack = StarStack()
        self.addSubview(stack)
        self.sendSubviewToBack(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.starView = stack

        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
