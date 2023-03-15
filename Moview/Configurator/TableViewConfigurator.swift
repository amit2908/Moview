//
//  TableViewConfigurator.swift
//  Moview
//
//  Created by Shubham Ojha on 17/07/21.
//  Copyright © 2021 Shubham. All rights reserved.
//

import UIKit
import SwipeCellKit

protocol ITableConfiguration {
    var numberOfSections : Int { get set }
    var sectionConfigurations : [ISectionConfiguration] { get set }
}

protocol ITableViewConfigurator {
    var tableConfiguration: ITableConfiguration { get set }
}


protocol ISectionConfiguration {
    var numberOfRows      : Int { get }
    var headerViewConfig  : (UIView?, CGFloat)?        { get set }
    var footerViewConfig  : (UIView?, CGFloat)?        { get set }
    var cellConfigurations: [ITableCellConfiguration]  { get set }
}

protocol ITableCellConfiguration {
    var cellIdentifier          : String            { get set }
    var cellHeight              : CGFloat           { get set }
    var estimatedCellHeight     : CGFloat?           { get set }
    var headerHeight            : CGFloat?          { get set }
    var footerHeight            : CGFloat?          { get set }
    var data                    : Any?              { get set }
    var cellDidSelectCallback   : (IndexPath)->Void { get set }
}


protocol GenericTableCell: UITableViewCell {
    func configure(withData data: Any?)
}

protocol GenericTableCellWithCallback: UITableViewCell {
    func configure(withData data: Any?, callback: @escaping ()->Void)
}

protocol GenericCollectionCell: UICollectionViewCell {
    func configure(withData data: Any?)
}


class TableViewConfigurator: NSObject, ITableViewConfigurator, UITableViewDataSource, UITableViewDelegate {
    
    var tableConfiguration: ITableConfiguration
    var sectionConfigs : [ISectionConfiguration]
    
    init(tableConfiguration: ITableConfiguration) {
        self.tableConfiguration = tableConfiguration
        self.sectionConfigs = self.tableConfiguration.sectionConfigurations
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.sectionConfigs.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sectionConfigs[section].cellConfigurations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellConfig = self.sectionConfigs[indexPath.section].cellConfigurations[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellConfig.cellIdentifier, for: indexPath) as? GenericTableCell else {
            return UITableViewCell()
        }
        cell.configure(withData: cellConfig.data)
//        cell.updateConstraintsIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellConfig = self.sectionConfigs[indexPath.section].cellConfigurations[indexPath.row]
        cellConfig.cellDidSelectCallback(indexPath)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cellConfig = self.sectionConfigs[indexPath.section].cellConfigurations[indexPath.row]
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cellConfig = self.sectionConfigs[indexPath.section].cellConfigurations[indexPath.row]
//        return cellConfig.estimatedCellHeight ?? UITableView.automaticDimension
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionConfig = self.sectionConfigs[section]
        return sectionConfig.headerViewConfig?.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionConfig = self.sectionConfigs[section]
        return sectionConfig.footerViewConfig?.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionConfig = self.sectionConfigs[section]
        return sectionConfig.headerViewConfig?.1 ?? 0.0
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionConfig = self.sectionConfigs[section]
        return sectionConfig.footerViewConfig?.1 ?? 0.0
    }
}

class SwipableTableViewConfigurator: TableViewConfigurator {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellConfig = self.sectionConfigs[indexPath.section].cellConfigurations[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellConfig.cellIdentifier, for: indexPath) as? GenericTableCellWithCallback else {
            return UITableViewCell()
        }
        cell.configure(withData: cellConfig.data) {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
//        cell.updateConstraintsIfNeeded()
        return cell
    }
    
    func updateTable(withConfiguration configuration: ITableConfiguration){
        self.tableConfiguration = configuration
    }
}

extension SwipableTableViewConfigurator: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                // handle action by updating model with deletion
                if let config = self.tableConfiguration.sectionConfigurations[indexPath.section] as? GenericSwipeableTableSectionConfiguration<IMovie>{
                    let cellConfig = config.swipeableCellConfigurations[indexPath.row]
                    cellConfig.swipeLeftCallback(indexPath)
                    
                }
            }

            // customize the action appearance
        
        deleteAction.image = UIImage(named: "delete")

            return [deleteAction]
    }
}
