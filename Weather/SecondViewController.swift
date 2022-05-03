//
//  SecondViewController.swift
//  Weather
//
//  Created by 김윤수 on 2022/01/06.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct Wheather: Codable {
        let city_name: String
        let state: Int
        let celsius: Double
        let rainfall_probability: Int
        var fahrenheit: String {
            return String(format:".1f", celsius * 1.8 + 32)
        }
    }
    
    // MARK: Properties

    var countries_name: String!
    var countries: String!
    
    var wheather: [Wheather] = []
    var tableView: UITableView!
    let cellIdentifier: String = "cell"
    
    
    // MARK: Method
    
    func addTableView() {
        
        let table: UITableView = UITableView(frame: CGRect(), style: .insetGrouped)
        self.view.addSubview(table)
        
        table.register(WheatherCell.self, forCellReuseIdentifier: self.cellIdentifier)
        
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 100
        
        table.translatesAutoresizingMaskIntoConstraints = false
        
        let bottom: NSLayoutConstraint
        bottom = table.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        let top: NSLayoutConstraint
        top = table.topAnchor.constraint(equalTo: self.view.topAnchor)
        
        let leading: NSLayoutConstraint
        leading = table.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        
        let trailing: NSLayoutConstraint
        trailing = table.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        
        bottom.isActive = true
        top.isActive = true
        leading.isActive = true
        trailing.isActive = true
        
        self.tableView = table
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.wheather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WheatherCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! WheatherCell
        
        let info = self.wheather[indexPath.row]
        
        // WheatherCell Properties Configuration
        
        let image: UIImage?
        switch info.state {
        case 10:
            image = UIImage(named: "sunny")
        case 11:
            image = UIImage(named: "cloudy")
        case 12:
            image = UIImage(named: "rainy")
        case 13:
            image = UIImage(named: "snowy")
        default:
            image = nil
        }
        cell.image.image = image
        
        cell.city.text = info.city_name
        
        let c = info.celsius
        var color: UIColor
        cell.degree.text = "섭씨 \(c)도 / 화씨 " + info.fahrenheit + "도"
        
        if c < 5 {
            color = .blue
        }
        else if c > 28 {
            color = .red
        }
        else {
            color = .black
        }
        cell.degree.textColor = color
        
        let p = info.rainfall_probability
        cell.potential.text = "강수확률 \(p)%"
        if p > 60 {
            color = .orange
        }
        else {
            color = .black
        }
        cell.potential.textColor = color
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let nextViewController = ThirdViewController()
        
        let cell = tableView.cellForRow(at: indexPath) as! WheatherCell
        nextViewController.image = cell.image.image
        nextViewController.degree = cell.degree.text
        nextViewController.potential = cell.potential.text
        
        let state: String?
        switch wheather[indexPath.row].state {
        case 10:
            state = "맑음"
        case 11:
            state = "구름"
        case 12:
            state = "비"
        case 13:
            state = "눈"
        default:
            state = nil
        }
        
        nextViewController.state = state
        
        cell.isSelected = false
        
        nextViewController.navigationItem.title = wheather[indexPath.row].city_name
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = countries_name
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let data = NSDataAsset(name: self.countries) else {
            return
        }
        
        do {
            self.wheather = try jsonDecoder.decode([Wheather].self, from: data.data)
        } catch {
            print(error.localizedDescription)
        }
        
        self.addTableView()
        
        // Do any additional setup after loading the view.
    }
    
}
