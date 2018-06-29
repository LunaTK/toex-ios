//
//  OffersViewController.swift
//  TOEX
//
//  Created by TaeGeun Moon on 2018. 6. 29..
//  Copyright © 2018년 TaeGeun Moon. All rights reserved.
//

import UIKit
import AMScrollingNavbar

class OffersViewController: UIViewController {

    enum TabType{
        case provide
        case recieve
    }
    
    @IBOutlet weak var provideTab: UIView!
    @IBOutlet weak var provideTabImage: UIImageView!
    @IBOutlet weak var recieveTab: UIView!
    @IBOutlet weak var recieveTabImage: UIImageView!
    
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var distanceFilter: UIButton!
    @IBOutlet weak var priceFilter: UIButton!
    @IBOutlet weak var popupReferenceView: UIView!
    
    private var offers = Offers()
    
    private var isFetchingMore = false
    private var filterPopup: FilterPopup?
    private var currentTab: TabType = .provide{
        didSet{
            syncTabViewState()
        }
    }
    
    private func syncTabViewState(){
        guard provideTab != nil else {return}
        
        let provideTabColor: [TabType:UIColor] = [.provide:#colorLiteral(red: 0.3960784314, green: 0.8117647059, blue: 0.4862745098, alpha: 1), .recieve: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        let recieveTabColor: [TabType:UIColor] = [.recieve:#colorLiteral(red: 0.3960784314, green: 0.8117647059, blue: 0.4862745098, alpha: 1), .provide: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        
        provideTab.backgroundColor = provideTabColor[currentTab]
        provideTabImage.isHighlighted = currentTab == .provide
        
        recieveTab.backgroundColor = recieveTabColor[currentTab]
        recieveTabImage.isHighlighted = currentTab == .recieve
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        offers.updateDelegate = { [weak tableView] in
            tableView?.reloadData()
            self.isFetchingMore = false
        }
        currentTab = .provide
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("\(provideTab.frame)")
    }
    
    private func setupNavigationBar(){
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(tableView, delay: 0, scrollSpeedFactor: 1.0, collapseDirection: .scrollUp, followers: [])
            navigationController.scrollingNavbarDelegate = self
            navigationController.followers.append(NavigationBarFollower(view: headerView, direction: .scrollUp))
        }
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "TOEX"))
    }

    @IBAction func handleNewOffer(_ sender: Any) {
        
    }
    
    @IBAction func handleDistanceFilter(_ sender: Any) {
        let center = CGPoint(x: view.frame.midX, y: popupReferenceView.frame.height + 40)
        showFilterPopup(at: center, from: CGPoint(x: 0.5, y: 0.0))
    }
    
    @IBAction func handlePriceFilter(_ sender: Any) {
        let center = CGPoint(x: view.frame.maxX * 0.9, y: popupReferenceView.frame.height + 40)
        showFilterPopup(at: center, from: CGPoint(x: 0.9, y: 0.0))
    }
    
    @IBAction func handleTabChange(_ sender: UITapGestureRecognizer) {
        let tabTypeForView: [UIView: TabType] = [provideTab:.provide, recieveTab:.recieve]
        currentTab = tabTypeForView[sender.view!]!
    }
    
    private func showFilterPopup(at center: CGPoint, from anchor: CGPoint){
        guard filterPopup == nil else { return }
        let popup = FilterPopup.instanceFromNib()
        popup.handleCancel = dismissFilterPopup
        filterPopup = popup
        view.addSubview(popup)
        popup.center = center
        popup.rangeSlider.delegate = self
        popup.animateAppearing(from: anchor)
    }
    
    private func dismissFilterPopup(){
        if let filterPopup = filterPopup {
            filterPopup.dismissWithAnimation()
            self.filterPopup = nil
        }
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInset = UIEdgeInsets(top: headerView.frame.height, left: 0, bottom: -15, right: 0)
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

extension OffersViewController: RangeSliderDelegate{
    func rangeSlider(_ rangeSlider: RangeSlider, didChangeLowerValue lowerValue: Double) {
        filterPopup?.minLabel.text = "\(Int(lowerValue))"
    }
    func rangeSlider(_ rangeSlider: RangeSlider, didChangeUpperValue upperValue: Double) {
        filterPopup?.minLabel.text = "\(Int(upperValue))"
    }
}

extension OffersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section==0 ? offers.count : 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = [0:"offer cell", 1:"loading cell"]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier[indexPath.section]!, for: indexPath)
        
        if let offerCell = cell as? OfferTableViewCell{
//            offerCell.usernameLabel.text = "hhhh"
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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dismissFilterPopup()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension OffersViewController: ScrollingNavigationControllerDelegate {
    func scrollingNavigationController(_ controller: ScrollingNavigationController, willChangeState state: NavigationBarState) {
        view.needsUpdateConstraints()
    }
}

