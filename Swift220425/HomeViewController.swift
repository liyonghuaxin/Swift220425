//
//  HomeViewController.swift
//  Swift220425
//
//  Created by issuser on 2022/4/25.
//

import Foundation
import UIKit
import Masonry

class HomeViewController: UIViewController {
    
    var tab: UITableView!
    
    override func viewDidLoad() {
        setupUI()
    }
    
    func setupUI() {
        self.view.backgroundColor = .orange
        
        tab = UITableView.init()
        self.view.addSubview(tab)
        tab.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.view)
        }
        tab.delegate = self
        tab.dataSource = self
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init()
        cell.textLabel?.text = "123"
        return cell
    }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gcd = GCDTest()
        gcd.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(gcd, animated: true)
    }
}





