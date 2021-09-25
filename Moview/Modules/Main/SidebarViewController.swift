//
//  SidebarViewController.swift
//  Moview
//
//  Created by Shubham Ojha on 15/05/20.
//  Copyright © 2020 Shubham. All rights reserved.
//

import UIKit

class SidebarViewController: UIViewController {
    
    @IBOutlet var imgViewProfilePic: UIImageView!
    
    @IBOutlet var tvMenus: UITableView!
    
    var cellViewModels = [SideBarTableCell.ViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor(named: <#T##String#>)
        
        tvMenus.register(SideBarTableCell.nib, forCellReuseIdentifier: SideBarTableCell.reuseID)
        
        cellViewModels = [
            SideBarTableCell.ViewModel(title: "Home", icon: UIImage(named: "favourite-selected")!),
            SideBarTableCell.ViewModel(title: "My Profile", icon: UIImage(named: "favourite-selected")!),
            SideBarTableCell.ViewModel(title: "Book Tickets", icon: UIImage(named: "favourite-selected")!),
            SideBarTableCell.ViewModel(title: "Theatres near me", icon: UIImage(named: "favourite-selected")!)
        ]

        tvMenus.reloadData()
        
    }
    
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        Navigation.shared.navigateToSignIn(navigationController: self.navigationController!)
    }
}


//MARK: UITableView data source
extension SidebarViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideBarTableCell.reuseID , for: indexPath) as? SideBarTableCell else { return UITableViewCell() }
        
        cell.configure(withViewModel: cellViewModels[indexPath.row])
        
        return cell
    }
}
