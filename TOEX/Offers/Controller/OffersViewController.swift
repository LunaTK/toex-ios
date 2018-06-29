//
//  OffersViewController.swift
//  TOEX
//
//  Created by TaeGeun Moon on 2018. 6. 29..
//  Copyright © 2018년 TaeGeun Moon. All rights reserved.
//

import UIKit

class OffersViewController: UIViewController {

    @IBOutlet weak var sellingTabBarItem: UITabBarItem!
    @IBOutlet weak var buyingTabBarItem: UITabBarItem!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var offers = Offers()
    
    var isFetchingMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tabBar.delegate = self
        
        offers.updateDelegate = { [weak tableView] in
            tableView?.reloadData()
            self.isFetchingMore = false
        }
    }

    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        //bottom inset
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -15, right: 0)
        //remove last separator
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension OffersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section==0 ? offers.count : 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = [0:"offer cell", 1:"loading cell"]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier[indexPath.section]!, for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = offers[indexPath.item]?.title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == (offers.count - 1) {
            if !isFetchingMore {
                isFetchingMore = true
                offers.loadNextPage()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}


extension OffersViewController: UITabBarDelegate{
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == buyingTabBarItem {
            print("change to buyingTabBarItem")
        } else if item == sellingTabBarItem {
            print("change to sellingTabBarItem")
            
        }
    }
}
