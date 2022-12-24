//
//  WheatherCell.swift
//  Weather
//
//  Created by 김윤수 on 2022/01/06.
//

import UIKit

class WheatherCell: UITableViewCell {
    
    // MARK: Properties
    
    var image: UIImageView!
    var city: UILabel!
    var degree: UILabel!
    var potential: UILabel!
    
    // MARK: Method
    
    func addImage() {
        
        let image = UIImageView()
        
        self.contentView.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false

        let bottom: NSLayoutConstraint
        bottom = image.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        
        let top: NSLayoutConstraint
        top = image.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
        
        let leading: NSLayoutConstraint
        leading = image.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 10)
        
        let width: NSLayoutConstraint
        width = image.widthAnchor.constraint(equalToConstant: 80)
        
        bottom.isActive = true
        top.isActive = true
        leading.isActive = true
        width.isActive = true
        
        self.image = image
        
    }
    
    func addCityLabel() {
        
        let label = UILabel()
        
        self.contentView.addSubview(label)

        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)

        label.translatesAutoresizingMaskIntoConstraints = false
        
        let top: NSLayoutConstraint
        top = label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
        
        let leading: NSLayoutConstraint
        leading = label.leadingAnchor.constraint(equalTo: self.image.trailingAnchor, constant: 10)
        
        leading.isActive = true
        top.isActive = true
        
        self.city = label
        
    }
    
    func addDegreeLabel() {
        
        let label = UILabel()
        
        self.contentView.addSubview(label)

        label.textColor = .black
//        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)

        label.translatesAutoresizingMaskIntoConstraints = false
        
        let top: NSLayoutConstraint
        top = label.topAnchor.constraint(equalTo: self.city.bottomAnchor, constant: 7)
        
        let leading: NSLayoutConstraint
        leading = label.leadingAnchor.constraint(equalTo: self.image.trailingAnchor, constant: 10)
        
        leading.isActive = true
        top.isActive = true
        
        self.degree = label
        
    }
    
    func addPotentialLabel() {
        
        let label = UILabel()
        
        self.contentView.addSubview(label)

        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)

        label.translatesAutoresizingMaskIntoConstraints = false
        
        let top: NSLayoutConstraint
        top = label.topAnchor.constraint(equalTo: self.degree.bottomAnchor, constant: 7)
        
        let leading: NSLayoutConstraint
        leading = label.leadingAnchor.constraint(equalTo: self.image.trailingAnchor, constant: 10)
        
        leading.isActive = true
        top.isActive = true
        
        self.potential = label
        
    }
    
    // MARK: LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awake From Nib")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: " ")
        self.backgroundColor = .white
        self.accessoryType = .disclosureIndicator
        
        self.addImage()
        self.addCityLabel()
        self.addDegreeLabel()
        self.addPotentialLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
