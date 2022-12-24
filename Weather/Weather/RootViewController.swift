//
//  RootViewController.swift
//  Weather
//
//  Created by 김윤수 on 2022/01/05.
//

import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    func addTableView() {
        let table = UITableView()
        
        self.view.addSubview(table)
        table.backgroundColor = .red
        
        tableView = table
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTableView()
        
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
