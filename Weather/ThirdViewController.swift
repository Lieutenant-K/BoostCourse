//
//  ThirdViewController.swift
//  Weather
//
//  Created by 김윤수 on 2022/01/07.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var imageView: UIImageView!
    var stateLabel: UILabel!
    var degreeLabel: UILabel!
    var potentialLabel: UILabel!
    
    var image: UIImage!
    var degree: String!
    var state: String!
    var potential: String!
    
    func addImage() {
        
        let image = UIImageView()
        
        self.view.addSubview(image)
        image.image = self.image
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        let top: NSLayoutConstraint
        top = image.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120)
        
        let centerX: NSLayoutConstraint
        centerX = image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let width: NSLayoutConstraint
        width = image.widthAnchor.constraint(equalToConstant: 150)
        
        let height: NSLayoutConstraint
        height = image.heightAnchor.constraint(equalToConstant: 150)
        
        top.isActive = true
        centerX.isActive = true
        width.isActive = true
        height.isActive = true
        
        self.imageView = image
        
    }
    
    func addStateLabel() {
        
        let label = UILabel()
        
        self.view.addSubview(label)
        label.text = self.state
        label.font = UIFont.boldSystemFont(ofSize: 25)

        label.translatesAutoresizingMaskIntoConstraints = false
        
        let top: NSLayoutConstraint
        top = label.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 10)
        
        let centerX: NSLayoutConstraint
        centerX = label.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor)
        
        centerX.isActive = true
        top.isActive = true
        
        self.stateLabel = label
        
    }
    
    func addDegreeLabel() {
        
        let label = UILabel()
        
        self.view.addSubview(label)
        label.text = self.degree

        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)

        label.translatesAutoresizingMaskIntoConstraints = false
        
        let top: NSLayoutConstraint
        top = label.topAnchor.constraint(equalTo: self.stateLabel.bottomAnchor, constant: 15)
        
        let centerX: NSLayoutConstraint
        centerX = label.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor)
        
        centerX.isActive = true
        top.isActive = true
        
        self.degreeLabel = label
        
    }
    
    func addPotentialLabel() {
        
        let label = UILabel()
        
        self.view.addSubview(label)
        label.text = self.potential

        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)

        label.translatesAutoresizingMaskIntoConstraints = false
        
        let top: NSLayoutConstraint
        top = label.topAnchor.constraint(equalTo: self.degreeLabel.bottomAnchor, constant: 15)
        
        let centerX: NSLayoutConstraint
        centerX = label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        centerX.isActive = true
        top.isActive = true
        
        self.potentialLabel = label
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.scrollEdgeAppearance = {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .systemGray6
            return appearance
        }()
        
        self.addImage()
        self.addStateLabel()
        self.addDegreeLabel()
        self.addPotentialLabel()

        // Do any additional setup after loading the view.
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
