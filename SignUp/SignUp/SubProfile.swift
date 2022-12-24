//
//  SubProfileViewController.swift
//  SignUp
//
//  Created by 김윤수 on 2021/12/29.
//

import UIKit

class SubProfile: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: Properties
    
    lazy var dateFormatter: DateFormatter = {
        let date: DateFormatter = DateFormatter()
        date.timeStyle = .none
        date.dateStyle = .long
        date.locale = Locale(identifier: "US")
        return date
    }()
    
    // MARK: Interface Builder Outlet
    
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var birthdayLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var backButton: UIButton!
    
    
    // MARK: Method
    
    func addView(){
        
        self.addPhoneNumberLabel()
        self.addPhoneNumberTextField()
        self.addBirthdayLabel()
        self.addDateLabel()
        self.addDatePicker()
        self.addCancelButton()
        self.addSignUpButton()
        self.addBackButton()
    }
    
    func addPhoneNumberLabel() {
        let label: UILabel = UILabel()
        
        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "전화번호"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        let top: NSLayoutConstraint
        top = label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20)
        
        let leading: NSLayoutConstraint
        leading = label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        
        top.isActive = true
        leading.isActive = true
        
        self.phoneNumberLabel = label
        
    }
    
    func addPhoneNumberTextField() {
        let text: UITextField = UITextField()
        
        self.view.addSubview(text)
        
        text.addTarget(self, action: #selector(self.phoneNumberChanged(_:)), for: .editingChanged)
        
        text.translatesAutoresizingMaskIntoConstraints = false
        
        text.placeholder = "전화번호를 입력하세요"
        text.keyboardType = .phonePad
        text.textContentType = .telephoneNumber
        text.borderStyle = .roundedRect
        text.enablesReturnKeyAutomatically = true
        
        let top: NSLayoutConstraint
        top = text.topAnchor.constraint(equalTo: self.phoneNumberLabel.bottomAnchor, constant: 5)
        
        let leading: NSLayoutConstraint
        leading = text.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        
        let trailing: NSLayoutConstraint
        trailing = text.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        
        top.isActive = true
        leading.isActive = true
        trailing.isActive = true
        
        self.phoneNumberTextField = text
        
    }
    
    func addBirthdayLabel() {
        let label: UILabel = UILabel()
        
        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "생년월일"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        let top: NSLayoutConstraint
        top = label.topAnchor.constraint(equalTo: self.phoneNumberTextField.bottomAnchor, constant: 10)
        
        let leading: NSLayoutConstraint
        leading = label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        
        top.isActive = true
        leading.isActive = true
        
        self.birthdayLabel = label
        
    }
    
    func addDateLabel() {
        let label: UILabel = UILabel()
        
        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        let centerY: NSLayoutConstraint
        centerY = label.centerYAnchor.constraint(equalTo: self.birthdayLabel.centerYAnchor)
        
        let trailing: NSLayoutConstraint
        trailing = label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -50)
        
        centerY.isActive = true
        trailing.isActive = true
        
        self.dateLabel = label
        
    }
    
    func addDatePicker() {
        let date: UIDatePicker = UIDatePicker()
        
        self.view.addSubview(date)
        date.addTarget(self, action: #selector(self.dateValueChanged(_:)), for: .valueChanged)
        
        date.translatesAutoresizingMaskIntoConstraints = false
        
        date.preferredDatePickerStyle = .wheels
        date.datePickerMode = .date
        date.locale = .init(identifier: "US")
        
        let top: NSLayoutConstraint
        top = date.topAnchor.constraint(equalTo: self.birthdayLabel.bottomAnchor, constant: 5)
        
        let leading: NSLayoutConstraint
        leading = date.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        
        let trailing: NSLayoutConstraint
        trailing = date.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        
        top.isActive = true
        leading.isActive = true
        trailing.isActive = true
        
        self.datePicker = date
        
    }
    
    func addSignUpButton() {
        
        let button: UIButton = UIButton(type: UIButton.ButtonType.system)
        
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(self.touchSignUpButton(_sender:)), for: .touchUpInside)
        
        button.isEnabled = false
        button.setTitle("가입", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        let top: NSLayoutConstraint
        top = button.topAnchor.constraint(equalTo: self.datePicker.bottomAnchor, constant: 20)
        
        let trailing: NSLayoutConstraint
        trailing = button.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -70)
        
        let height: NSLayoutConstraint
        height = button.heightAnchor.constraint(equalToConstant: 50)
        
        top.isActive = true
        trailing.isActive = true
        height.isActive = true
        
        self.signUpButton = button
        
    }
    
    func addCancelButton() {
        
        let button: UIButton = UIButton(type: UIButton.ButtonType.system)
        
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.touchCancelButton(_:)), for: .touchUpInside)
        
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        let leading: NSLayoutConstraint
        leading = button.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 70)
        
        let top: NSLayoutConstraint
        top = button.topAnchor.constraint(equalTo: self.datePicker.bottomAnchor, constant: 20)
        
        let height: NSLayoutConstraint
        height = button.heightAnchor.constraint(equalToConstant: 50)
        
        leading.isActive = true
        top.isActive = true
        height.isActive = true
        
        self.cancelButton = button
        
    }
    
    func addBackButton() {
        
        let button: UIButton = UIButton(type: UIButton.ButtonType.system)
        
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.touchBackButton(_:)), for: .touchUpInside)
        
        button.setTitle("이전", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        let centerX: NSLayoutConstraint
        centerX = button.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        
        let centerY: NSLayoutConstraint
        centerY = button.centerYAnchor.constraint(equalTo: self.cancelButton.centerYAnchor)
        
        centerX.isActive = true
        centerY.isActive = true
        
        self.backButton = button
        
    }
    
    func inputCheck(){
        if let number = self.phoneNumberTextField.text, let _ = dateLabel.text {
            if number != "" {
                self.signUpButton.isEnabled = true
            }
            else { self.signUpButton.isEnabled = false }
        } else { self.signUpButton.isEnabled = false }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let gestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.delegate = self
        
        self.view.addGestureRecognizer(gestureRecognizer)
        
        self.addView()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.inputCheck()
    }
    
    // MARK: IBAction
    
    @IBAction func dateValueChanged(_ sender: UIDatePicker){
        self.dateLabel.text = self.dateFormatter.string(from: sender.date)
        self.inputCheck()
    }
    
    @IBAction func phoneNumberChanged(_ sender: UITextField){
        self.inputCheck()
    }
    
    @IBAction func touchBackButton(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchCancelButton(_ sender: UIButton){
        
        self.phoneNumberTextField.text = nil
        self.datePicker = nil
        
        if let presenting = self.presentingViewController as? ProfileViewController {
            presenting.deleteInfo()
        }
        
        if let root = self.view.window?.rootViewController {
            root.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func touchSignUpButton(_sender: UIButton){
        
        self.phoneNumberTextField.text = nil
        self.datePicker = nil
        
        guard let presenting = self.presentingViewController as? ProfileViewController else {
            return
        }
        
        Info.info.id = presenting.id.text
        presenting.deleteInfo()
        
        if let root = presenting.presentingViewController as? ViewController {
            root.idTextField.text = Info.info.id
            root.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: Delegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(false)
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
