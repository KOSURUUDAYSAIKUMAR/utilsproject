//
//  ViewController.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 19/12/23.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var utilTBView: UITableView!
    
    var currentList = [DataItem]()
    var selectedItem: DataItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableview()
    }

    func setupTableview() {
        utilTBView.delegate = self
        utilTBView.dataSource = self
        utilTBView.register(UINib(nibName: "Header", bundle: nil), forHeaderFooterViewReuseIdentifier: "Header")
        utilTBView.register(UINib(nibName: "ValidationTableViewCell", bundle: nil), forCellReuseIdentifier: "ValidationTableViewCell")
        Provider.shared.addDataItem(withTitle: "Mandatory Field Validations", list: [])
        currentList = Provider.shared.ideaListItems()
    }
}


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = self.currentList[indexPath.section].isExpand
        if item == true {
            return UITableView.automaticDimension
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = self.currentList[indexPath.section].isExpand
        if item == true {
            return UITableView.automaticDimension
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as! CustomHeaderView
        headerView.headerTitle.text = self.currentList[section].title
        headerView.sectionNumber = section
        headerView.delegate = self
        if currentList[section].isExpand {
            headerView.arrowOutlet.setImage(UIImage(named: "Disclosure_Arrow_1"), for: .normal)
        } else {
            headerView.arrowOutlet.setImage(UIImage(named: "Closure_Arrow_1"), for: .normal)
        }
        return headerView
    }
}

extension ViewController: CustomeHeaderViewDelegate {
    func headerViewTap(_ section: Int) {
        self.selectedItem = self.currentList[section]
        let output = self.currentList.map({ (item:DataItem) -> DataItem in
            var result:DataItem
            result = item
            if result.title == self.selectedItem?.title && result.isExpand == false {
                result.isExpand = true
            } else {
                result.isExpand = false
            }
            return result
        })
        self.currentList = output
        utilTBView.beginUpdates()
        utilTBView.reloadSections(IndexSet(integer: section), with: UITableView.RowAnimation.automatic)
        utilTBView.endUpdates()
    }
}


extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.currentList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let item = self.currentList[section] as DataItem
//        return item.dataList.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "ValidationTableViewCell", for: indexPath) as?  ValidationTableViewCell
        else { return UITableViewCell() }
        cell.delegate = self
//        cell.textLabel?.text = self.currentList[indexPath.section].dataList[indexPath.row]
        cell.setUI(with: indexPath.row)
        return cell
    }
}

extension ViewController: BaseVCProtocol {
    func showAlert(msg: String) {
        self.showAlert(title: "Utils", message: msg)
    }
}
