//
//  UserRatingCell.swift
//  Movie
//
//  Created by 김윤수 on 2022/02/01.
//

import UIKit

class UserRatingCell: UITableViewCell {
    
    var titleLabel: UILabel!
    var gradeImage: UIImageView!
    var slider: UISlider!
    var starView: UIStackView!
    var gradeLabel: UILabel!
    
    func addView() {
        
        
        // 영화제목을 표시하는 레이블
        let label = UILabel()
        self.contentView.addSubview(label)
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
                
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        
        self.titleLabel = label
        
        
        // 영화의 상영등급을 표시하는 이미지뷰
        let image = UIImageView()
        self.contentView.addSubview(image)
        
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.widthAnchor.constraint(equalToConstant: 20).isActive = true
        image.heightAnchor.constraint(equalToConstant: 20).isActive = true
        image.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5).isActive = true
        
        self.gradeImage = image
        
        
        // 별점을 조절하는 슬라이더 (0점 ~ 10점)
        let slider = StarSlider()
        self.contentView.addSubview(slider)
        
        slider.addTarget(self, action: #selector(self.sliderValueChanged(_:)), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        slider.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        slider.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
        slider.widthAnchor.constraint(equalToConstant: 250).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.slider = slider
        
        
        
        // 매길 별점 수치를 보여주는 레이블
        let grade = UILabel()
        
        grade.text = String(slider.value)
        
        self.contentView.addSubview(grade)
        grade.translatesAutoresizingMaskIntoConstraints = false
        
        grade.centerXAnchor.constraint(equalTo: slider.centerXAnchor).isActive = true
        grade.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 10).isActive = true
        grade.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -20).isActive = true
        
        self.gradeLabel = grade
    }
    
    @objc func sliderValueChanged(_ sender: StarSlider){
        
        self.gradeLabel.text = String(Int(sender.value))//String(format: "%.1f", sender.value)
        if let stars = sender.starView?.arrangedSubviews as? [UIImageView] {
            calculateStar(stars, Double(sender.value))
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addView()
        
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
