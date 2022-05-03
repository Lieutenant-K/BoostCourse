//
//  MovieSynopsisCell.swift
//  Movie
//
//  Created by 김윤수 on 2022/01/31.
//

import UIKit

class MovieSynopsisCell: UITableViewCell {
    
    var title: UILabel?
    var text: UILabel?
    
    func addView(){
        
        let label = UILabel()
        
        self.contentView.addSubview(label)
        
        label.text = "줄거리"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15).isActive = true
        label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        
        self.title = label
        
        
        let text = UILabel()
        self.contentView.addSubview(text)
        
        text.lineBreakMode = .byCharWrapping
        text.numberOfLines = 0
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        text.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        text.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        text.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -20).isActive = true
        
        self.text = text
        
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("init")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addView()
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
