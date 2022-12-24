//
//  MovieMadeByCell.swift
//  Movie
//
//  Created by 김윤수 on 2022/01/31.
//

import UIKit

class MovieMadeByCell: UITableViewCell {
    
    var title: UILabel?
    var director: UILabel?
    var actor: UILabel?
    var directorText: UILabel?
    var actorText: UILabel?
    
    
    func addView(){
        
        let title = UILabel()
        
        self.contentView.addSubview(title)
        
        title.text = "감독/출연"
        title.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15).isActive = true
        title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        
        self.title = title
        
        
        
        let director = UILabel()
        
        self.contentView.addSubview(director)
        
        director.text = "감독"
        director.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        director.translatesAutoresizingMaskIntoConstraints = false
        director.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        director.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10).isActive = true
        
        self.director = director
        
        
        let directorText = UILabel()
        self.contentView.addSubview(directorText)
        
        directorText.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        directorText.translatesAutoresizingMaskIntoConstraints = false
        directorText.leadingAnchor.constraint(equalTo: director.trailingAnchor, constant: 5).isActive = true
        directorText.centerYAnchor.constraint(equalTo: director.centerYAnchor).isActive = true
        
        self.directorText = directorText
        
        
        let actor = UILabel()
        self.contentView.addSubview(actor)
        
        actor.text = "출연"
        actor.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        actor.translatesAutoresizingMaskIntoConstraints = false
        
        actor.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        actor.topAnchor.constraint(equalTo: director.bottomAnchor, constant: 5).isActive = true
        actor.centerXAnchor.constraint(equalTo: director.centerXAnchor).isActive = true
        
        self.actor = actor
        
        
        let actorText = UILabel()
        self.contentView.addSubview(actorText)
        
        actorText.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        actorText.numberOfLines = 0
        actorText.lineBreakMode = .byWordWrapping
        
        actorText.translatesAutoresizingMaskIntoConstraints = false
        actorText.leadingAnchor.constraint(equalTo: actor.trailingAnchor, constant: 5).isActive = true
        actorText.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        actorText.topAnchor.constraint(equalTo: directorText.bottomAnchor, constant: 5).isActive = true
        actorText.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20).isActive = true
        
        self.actorText = actorText
        
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
