//
//  ViewController.swift
//  Weather
//
//  Created by 김윤수 on 2022/01/05.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    struct Countries: Codable {

        let korean_name: String
        let asset_name: String
//        let group: String
        
    }
    
    // MARK: Properties
    
    var tableView: UITableView!
    var countries: [Countries] = []
    let cellIdentifier: String = "cell"
    
    var asia: [Countries] = []
    var euro: [Countries] = []
    var other: [Countries] = []
    
    // MARK: Method
    
    func addTableView() {
        
        let table: UITableView = UITableView(frame: CGRect(), style: .insetGrouped)
        self.view.addSubview(table)
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        
        table.delegate = self
        table.dataSource = self
        
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
    
    func groupCountries() {
        self.asia = [self.countries[0], self.countries[5]]
        self.euro = [self.countries[1],self.countries[2],self.countries[4]]
        self.other = [self.countries[3]]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return self.asia.count
        case 1: return self.euro.count
        case 2: return self.other.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "아시아"
        case 1:
            return "유럽"
        case 2:
            return "기타"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0:
            return "두유 노 김치? 두유 노 유나킴? 두유 노 지성팍? 두유 노 싸이? 두유 노 BTS? 두유 노 스퀴드 게임?"
        case 1:
            return "독일, 이탈리아, 프랑스 외에도 여러 국가가 있습니다."
        case 2:
            return "오 미쿡! 오 USA! 오 필승코리아!"
        default:
            return ""
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        if indexPath.section == 0 {
            content.text = self.asia[indexPath.row].korean_name
            content.image = UIImage(named: "flag_" + self.asia[indexPath.row].asset_name)
        }
        else if indexPath.section == 1 {
            content.text = self.euro[indexPath.row].korean_name
            content.image = UIImage(named: "flag_" + self.euro[indexPath.row].asset_name)
        }
        
        else {
            content.text = self.other[indexPath.row].korean_name
            content.image = UIImage(named: "flag_" + self.other[indexPath.row].asset_name)
        }
        
        cell.contentConfiguration = content
        cell.backgroundColor = .white
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextViewController = SecondViewController()
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.isSelected = false
        
        let asset_name: String
        let korean_name: String
        
        if indexPath.section == 0 {
            asset_name = self.asia[indexPath.row].asset_name
            korean_name = self.asia[indexPath.row].korean_name
        }
        else if indexPath.section == 1 {
            asset_name = self.euro[indexPath.row].asset_name
            korean_name = self.euro[indexPath.row].korean_name
        }
        
        else {
            asset_name = self.other[indexPath.row].asset_name
            korean_name = self.other[indexPath.row].korean_name
        }
        
        
        nextViewController.countries = asset_name
        nextViewController.countries_name = korean_name
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "세계 날씨"
        
        // JsonDecoder로 Asset에 있는 데이터 불러오기
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "countries") else {
            return
        }
        
        do {
            self.countries = try jsonDecoder.decode([Countries].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        
        self.groupCountries()
        
        self.addTableView()
        
        // Do any additional setup after loading the view.
    }


}

