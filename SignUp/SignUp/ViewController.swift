//
//  ViewController.swift
//  SignUp
//
//  Created by 김윤수 on 2022/05/03.
//

import UIKit

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    
    lazy var profile: ProfileViewController = {
        let view = ProfileViewController()
        view.view.backgroundColor = .white
//        self.modalPresentationStyle = .formSheet
//        view.modalPresentationStyle = .pageSheet
        return view
    }()
    
    // MARK: Interface Builder Outlet
    
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    
    
    // MARK: Method
    
    func addView() {
        self.addIdTextField()
        self.addPwTextField()
        self.addSignInButton()
        self.addSignUpButton()
    }
    
    
    func addIdTextField() {
        let textfield: UITextField = UITextField()
        
        self.view.addSubview(textfield)
        
        textfield.placeholder = "ID"
        textfield.borderStyle = .roundedRect
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX: NSLayoutConstraint
        centerX = textfield.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let leading: NSLayoutConstraint
        leading = textfield.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 50)
        
        let trailing: NSLayoutConstraint
        trailing = textfield.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -50)
        
        let top: NSLayoutConstraint
        top = textfield.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100)
        
        centerX.isActive = true
        leading.isActive = true
        trailing.isActive = true
        top.isActive = true
        
        self.idTextField = textfield
    }
    
    func addPwTextField() {
        let textfield: UITextField = UITextField()
        
        self.view.addSubview(textfield)
        
        textfield.placeholder = "Password"
        textfield.borderStyle = .roundedRect
        textfield.isSecureTextEntry = true
        textfield.textContentType = .oneTimeCode
        
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX: NSLayoutConstraint
        centerX = textfield.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let leading: NSLayoutConstraint
        leading = textfield.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 50)
        
        let trailing: NSLayoutConstraint
        trailing = textfield.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -50)
        
        let top: NSLayoutConstraint
        top = textfield.topAnchor.constraint(equalTo: self.idTextField.bottomAnchor, constant: 10)
        
        centerX.isActive = true
        leading.isActive = true
        trailing.isActive = true
        top.isActive = true
        
        self.pwTextField = textfield
    }
    
    func addSignInButton() {
        let button: UIButton = UIButton(type: UIButton.ButtonType.system)
        
        self.view.addSubview(button)
        
        button.setTitle("Sing In", for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        let leading: NSLayoutConstraint
        leading = button.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 70)
        
        let top: NSLayoutConstraint
        top = button.topAnchor.constraint(equalTo: self.pwTextField.bottomAnchor, constant:10)
        
        leading.isActive = true
        top.isActive = true
        
        self.signInButton = button
    }
    
    func addSignUpButton() {
        let button: UIButton = UIButton(type: UIButton.ButtonType.system)
        
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(self.touchSignUpButton(_sender:)), for: UIControl.Event.touchUpInside)
        
        button.setTitle("Sing Up", for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor.red, for: UIControl.State.normal)
        
        let traling: NSLayoutConstraint
        traling = button.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -70)
        
        let top: NSLayoutConstraint
        top = button.topAnchor.constraint(equalTo: self.pwTextField.bottomAnchor, constant:10)
        
        traling.isActive = true
        top.isActive = true
        
        self.signInButton = button
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addView()
    }
    
    // MARK: IB Action
    
    @IBAction func touchSignUpButton(_sender: UIButton){
        
//        self.profile.view.alpha = 1.0
//        self.profile.modalPresentationStyle = .automatic
        
        
        self.present(profile, animated: true, completion: nil)
    }


}


