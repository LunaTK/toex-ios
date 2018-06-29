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

        tabBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        offers.updateDelegate = {
            [weak tableView] in
            tableView?.reloadData()
//            tableView?.reloadSections(IndexSet(integer: 0), with: .none)
            self.isFetchingMore = false
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default cell", for: indexPath)
        cell.textLabel?.text = offers[indexPath.item]?.title
//        cell.detailTextLabel?.text = offers[indexPath.item]?.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == (offers.count - 1) {
//            offers.loadNextPage()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !isFetchingMore {
                isFetchingMore = true
//                tableView.reloadSections(IndexSet(integer: 0), with: .none)
                offers.loadNextPage()
            }
        }
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
