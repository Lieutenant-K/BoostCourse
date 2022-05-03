//
//  EditCommentCell.swift
//  Movie
//
//  Created by 김윤수 on 2022/02/01.
//

import UIKit

class EditCommentCell: UITableViewCell, UITextViewDelegate, UITextFieldDelegate {
    
    var nicknameField: UITextField!
    var commentView: UITextView!
    let placeHolder = "한줄평을 입력해주세요"
    
    func addNickNameField() {
        
        let textField = UITextField()
        self.contentView.addSubview(textField)
        
        textField.text = nil
        textField.delegate = self
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.placeholder = "닉네임을 입력해주세요"
        textField.borderStyle = .roundedRect
        textField.textContentType = .nickname
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        textField.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        
        self.nicknameField = textField
        
    }
    
    func addCommentView() {
        
        let text = UITextView()
        self.contentView.addSubview(text)
        
        text.delegate = self
        text.layer.borderWidth = 1
        text.font = self.nicknameField.font
        text.layer.borderColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
        text.layer.cornerRadius = 5
        text.textColor = .systemGray3
        text.text = self.placeHolder
        text.autocapitalizationType = .none
        text.autocorrectionType = .no
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.topAnchor.constraint(equalTo: self.nicknameField.bottomAnchor, constant: 10).isActive = true
        text.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        text.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        text.heightAnchor.constraint(equalToConstant: 300).isActive = true
        text.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20).isActive = true
        
        self.commentView = text
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(false)
        return true
    }
    
    
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == self.placeHolder{
            textView.textColor = .black
            textView.text = nil
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == nil || textView.text == "" {
            textView.text = self.placeHolder
            textView.textColor = .systemGray3
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addNickNameField()
        self.addCommentView()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
