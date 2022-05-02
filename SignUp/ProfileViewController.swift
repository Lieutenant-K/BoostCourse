//
//  ProfileViewController.swift
//  SignUp
//
//  Created by 김윤수 on 2021/12/26.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // MARK: Properties
    
    lazy var imagePicker: UIImagePickerController = {
        let imagePicker: UIImagePickerController = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        
        return imagePicker
    }()
    
    lazy var subProfile: SubProfile = {
        let view: SubProfile = SubProfile()
        view.view.backgroundColor = .white
//        view.modalPresentationStyle = .fullScreen
        return view
    }()
    
    var id: UITextField!
    var pw: UITextField!
    var checkPw: UITextField!
    
    // MARK: Interface Builder Outlet
    
    @IBOutlet var inputIdPw: UIStackView!
    @IBOutlet var acceptButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var messageField: UITextView!
    @IBOutlet var selectImageButton: UIButton!
    
    
    
    // MARK: Method
    
    func addView() {
        self.addSelectImageButton()
        self.addCancelButton()
        self.addAcceptButton()
        self.addMessageField()
        self.addStackView()
        
    }
    
    func addSelectImageButton() {
        let button: UIButton = UIButton(type: .custom)
        
        self.view.addSubview(button)
        
        button.addTarget(self, action: #selector(touchImage(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        
        let top: NSLayoutConstraint
        top = button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20)
        
        let leading: NSLayoutConstraint
        leading = button.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        
        let width: NSLayoutConstraint
        width = button.widthAnchor.constraint(equalToConstant: 100)
        
        let height: NSLayoutConstraint
        height = button.heightAnchor.constraint(equalToConstant: 100)
        
        top.isActive = true
        leading.isActive = true
        width.isActive = true
        height.isActive = true
        
        self.selectImageButton = button
    }
    
    func addMessageField() {
        let text: UITextView = UITextView()
        
        self.view.addSubview(text)
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .systemYellow
        text.autocorrectionType = .no
        text.font = UIFont.systemFont(ofSize: 15)
        
        
        let top: NSLayoutConstraint
        top = text.topAnchor.constraint(equalTo: self.selectImageButton.bottomAnchor, constant: 10)
        
        let leading: NSLayoutConstraint
        leading = text.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        
        let trailing: NSLayoutConstraint
        trailing = text.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        
        let bottom: NSLayoutConstraint
        bottom = text.bottomAnchor.constraint(equalTo: self.acceptButton.topAnchor, constant: -10)
        
        top.isActive = true
        leading.isActive = true
        trailing.isActive = true
        bottom.isActive = true
        
        self.messageField = text
    }
    
    func addStackView() {
        
        let id: UITextField = self.textField("ID")
        let pw: UITextField = self.textField("Password")
        let checkPw: UITextField = self.textField("Check Password")
        
        pw.isSecureTextEntry = true
        checkPw.isSecureTextEntry = true
        
        self.id = id
        self.pw = pw
        self.checkPw = checkPw
        
        let stack: UIStackView = UIStackView(arrangedSubviews: [id, pw, checkPw])
        
        self.view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        
        let top: NSLayoutConstraint
        top = stack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20)
        
        let trailing: NSLayoutConstraint
        trailing = stack.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        
        let leading: NSLayoutConstraint
        leading = stack.leadingAnchor.constraint(equalTo: self.selectImageButton.trailingAnchor, constant: 5)
        
        let bottom: NSLayoutConstraint
        bottom = stack.bottomAnchor.constraint(equalTo: self.messageField.topAnchor, constant: -10)
        
        top.isActive = true
        bottom.isActive = true
        trailing.isActive = true
        leading.isActive = true
        
        self.inputIdPw = stack
        
    }
    
    func addAcceptButton() {
        
        let button: UIButton = UIButton(type: UIButton.ButtonType.system)
        
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(self.touchAcceptButton(_:)), for: .touchUpInside)
        
        button.isEnabled = false
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        let leading: NSLayoutConstraint
        leading = button.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 50)
        
        let bottom: NSLayoutConstraint
        bottom = button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        
        let height: NSLayoutConstraint
        height = button.heightAnchor.constraint(equalToConstant: 50)
        
        leading.isActive = true
        bottom.isActive = true
        height.isActive = true
        
        self.acceptButton = button
        
    }
    
    func addCancelButton() {
        
        let button: UIButton = UIButton(type: UIButton.ButtonType.system)
        
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.touchCancelButton(_:)), for: .touchUpInside)
        
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        let trailing: NSLayoutConstraint
        trailing = button.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: -50)
        
        let bottom: NSLayoutConstraint
        bottom = button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        
        let height: NSLayoutConstraint
        height = button.heightAnchor.constraint(equalToConstant: 50)
        
        trailing.isActive = true
        bottom.isActive = true
        height.isActive = true
        
        self.cancelButton = button
        
    }
    
    func textField(_ info: String) -> UITextField {
        let text: UITextField = UITextField()
        
        text.placeholder = info
        text.borderStyle = .roundedRect
        text.textContentType = .oneTimeCode
        text.autocorrectionType = .no
        
        text.delegate = self
        text.addTarget(self, action: #selector(self.textFieldChanged(_sender:)), for: .editingChanged)
        return text
    }
    
    func inputCheck() {
        if let _ = self.selectImageButton.currentImage, let id = self.id.text, let pw = self.pw.text, let checkPw = self.checkPw.text, let _ = self.messageField.text {
            
            if (id != "") && (pw != "") && (checkPw != "") && (pw == checkPw) {
                self.acceptButton.isEnabled = true
            } else { self.acceptButton.isEnabled = false }
            
        } else {self.acceptButton.isEnabled = false}
    }
    
    func deleteInfo() {
        let subviews: [UIView] = self.inputIdPw.arrangedSubviews
        for view in subviews {
            if let view = view as? UITextField {
                view.text = nil
            }
        }
        self.messageField.text = nil
        self.selectImageButton.setImage(nil, for: .normal)
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
    
    
    // MARK: IB Action
    
    @IBAction func touchCancelButton(_ sender: UIButton){
        self.deleteInfo()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchImage(_ sender: UIButton){
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func touchAcceptButton(_ sender: UIButton){
        self.present(self.subProfile, animated: true, completion: nil)
    }
    
    @IBAction func textFieldChanged(_sender: UITextField) {
        self.inputCheck()
    }
    
    
    // MARK: Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(false)
        self.inputCheck()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.inputCheck()
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {

            self.selectImageButton.contentMode = .scaleAspectFit
            self.selectImageButton.setImage(image, for: .normal)
        }
        self.dismiss(animated: true, completion: nil)
        self.inputCheck()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(false)
        self.inputCheck()
        
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
