//
//  SidebarViewController.swift
//  Moview
//
//  Created by Shubham Ojha on 15/05/20.
//  Copyright © 2020 Shubham. All rights reserved.
//

import UIKit
import SwiftUI

class SidebarViewController: UIViewController {
    
    @IBOutlet var imgViewProfilePic: UIImageView!
    
    @IBOutlet var tvMenus: UITableView!
    
    var cellViewModels = [SideBarTableCell.ViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "AppColor")?.withAlphaComponent(0.5)
        self.tvMenus.backgroundColor = .clear
        
        tvMenus.register(SideBarTableCell.nib, forCellReuseIdentifier: SideBarTableCell.reuseID)
        let homeIcon = UIImage(named: "home")?.withTintColor(.white, renderingMode: .alwaysTemplate)
        
        
        cellViewModels = [
            SideBarTableCell.ViewModel(title: "Home", icon: homeIcon),
            SideBarTableCell.ViewModel(title: "My Profile", icon: UIImage(named: "profile")!),
            SideBarTableCell.ViewModel(title: "Book Tickets", icon: UIImage(named: "bookTicket")!),
            SideBarTableCell.ViewModel(title: "Invite Friends", icon: UIImage(named: "invite")!),
            SideBarTableCell.ViewModel(title: "My Coupons", icon: UIImage(named: "coupon")!),
            SideBarTableCell.ViewModel(title: "Scheduled Events", icon: UIImage(named: "events")!),
            SideBarTableCell.ViewModel(title: "Theatres near me", icon: UIImage(named: "film")!)
        ]

        tvMenus.reloadData()
        
    }
    
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        Navigation.shared.navigateToSignIn(navigationController: self.navigationController!)
    }
}


//MARK: UITableView data source
extension SidebarViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideBarTableCell.reuseID , for: indexPath) as? SideBarTableCell else { return UITableViewCell() }
        
        cell.configure(withViewModel: cellViewModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 5:
            let events = [Event(title: "Pathaan", time: "04:50 pm", movieId: ""),
                          Event(title: "Pathaan", time: "04:50 pm", movieId: ""),
                          Event(title: "Pathaan", time: "04:50 pm", movieId: "")]
            
            let hostingController = UIHostingController(rootView: ScheduledEventsView(events: events))
            self.navigationController?.pushViewController(hostingController, animated: true)
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        default:
            return
        }
    }
}
