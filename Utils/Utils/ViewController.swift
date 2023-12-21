//
//  ViewController.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 19/12/23.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var utilTBView: UITableView!
    
    @IBOutlet weak var networkMsg: UILabel!
    var currentList = [DataItem]()
    var selectedItem: DataItem?
    
    var vm: ViewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.network = self
        // Do any additional setup after loading the view.
        setupTableview()
        vm.isCheckNetworkHandler()
    }

    func setupTableview() {
        utilTBView.delegate = self
        utilTBView.dataSource = self
        utilTBView.register(UINib(nibName: "Header", bundle: nil), forHeaderFooterViewReuseIdentifier: "Header")
        utilTBView.register(UINib(nibName: "ValidationTableViewCell", bundle: nil), forCellReuseIdentifier: "ValidationTableViewCell")
        utilTBView.register(UINib(nibName: "AlertDialogTableViewCell", bundle: nil), forCellReuseIdentifier: "AlertDialogTableViewCell")
        
        Provider.shared.addDataItem(withTitle: "Mandatory Field Validations", list: [])
        Provider.shared.addDataItem(withTitle: "View All Alert Dialog", list: ["Ok Alert Dialog", "Yes/No Alert Dialog", "Custom Icon Alert Dialog", "Custom Icon Yes/No Alert Dialog", "Custom Layout Alert Dialog", "Custom ListView in Alert Dialog"])
        currentList = Provider.shared.ideaListItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.notifyViewWillAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        vm.notifyViewDidAppear()
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
        let item = self.currentList[section] as DataItem
        switch section {
        case 0:
            return 1
        default:
            return item.dataList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ValidationTableViewCell", for: indexPath) as?  ValidationTableViewCell
             else { return UITableViewCell() }
             cell.delegate = self
     //        cell.textLabel?.text = self.currentList[indexPath.section].dataList[indexPath.row]
             cell.setUI(with: indexPath.row)
             return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlertDialogTableViewCell", for: indexPath) as?  AlertDialogTableViewCell
             else { return UITableViewCell() }
            cell.alertOutlet.tag = indexPath.row
            cell.delegate = self
             cell.setupUI(data: currentList[indexPath.section].dataList[indexPath.row])
             return cell
        }
    }
}

extension ViewController: BaseVCProtocol {
    func showAlert(msg: String) {
        AlertHelperModel.showAlert(title: "Utils", message: msg, viewController: self)
        // self.showAlert(title: "Utils", message: msg)
    }
}

extension ViewController: AlertDialogDelegate {
    func alertButtonTag(tag: Int) {
        switch tag {
        case 0:
            AlertHelperModel.showAlert(title: "Utils", message: currentList[1].dataList[tag], viewController: self)
            // showAlert(title: "Utilis", message: currentList[1].dataList[tag])
        case 1:
            AlertHelperModel.showAlertWithYesNo(title: "Confirmation", message: "Do you want to proceed?", viewController: self) {
                print("User tapped Yes")
            } noAction: {
                print("User tapped No")
            }
        case 2:
            let popupViewController = CustomAlertViewController()
            popupViewController.buttonsCount = 1
            popupViewController.delegate = self
            popupViewController.modalPresentationStyle = .custom
            popupViewController.transitioningDelegate = self
            present(popupViewController, animated: true, completion: nil)
        case 3:
            let popupViewController = CustomAlertViewController()
            popupViewController.buttonsCount = 2
            popupViewController.delegate = self
            popupViewController.modalPresentationStyle = .custom
            popupViewController.transitioningDelegate = self
            present(popupViewController, animated: true, completion: nil)
           // showAlertWithImage(title: "Utilis", message: currentList[1].dataList[tag])
        case 4:
            let popupViewController = GenderViewController()
            popupViewController.delegate = self
            popupViewController.modalPresentationStyle = .custom
            popupViewController.transitioningDelegate = self
            present(popupViewController, animated: true, completion: nil)
        case 5:
            let popupViewController = DropDownViewController()
            popupViewController.dropDownArray = ["Cheese patty burger no.1", "Regular chicken burger no.1", "Medium size panner pizza no.1", "Spicy French Fries no.1", "Classic Veggie Crunch no.1", "Mojito Lemon no.1"]
            popupViewController.modalPresentationStyle = .custom
            popupViewController.transitioningDelegate = self
            present(popupViewController, animated: true, completion: nil)
        default:
            AlertHelperModel.showAlert(title: "Utils", message: currentList[1].dataList[tag], viewController: self)
            // showAlert(title: "Utilis", message: currentList[1].dataList[tag])
        }
    }
    func alertButtonTagYN(tag: String) {
        print(tag)
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PopUpPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension ViewController: ViewModelDelegate {
    func networkConnectionMsg(text: String, status: Bool) {
        if status {
            networkMsg.text = text
        } else {
            networkMsg.text = text
        }
    }
}

extension ViewController: GenderDelegate {
    func radioButtonSelect(text: String) {
        print(text)
    }
}
