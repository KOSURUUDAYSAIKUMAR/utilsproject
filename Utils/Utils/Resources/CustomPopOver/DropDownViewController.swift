//
//  DropDownViewController.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 20/12/23.
//

import UIKit

class DropDownViewController: UIViewController {

    @IBOutlet weak var dropDownTableView: UITableView!
    
    var dropDownArray = [String]()
    
    override var preferredContentSize: CGSize {
        get {
            // Calculate the preferred content size based on your content
            let contentHeight = 44 * dropDownArray.count + 80
            return CGSize(width: 300.0, height: Double(contentHeight))
        }
        set {
            super.preferredContentSize = newValue
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDownTableView.dataSource = self
        dropDownTableView.delegate = self
        dropDownTableView.register(UINib(nibName: "CustomDropDownCell", bundle: nil), forCellReuseIdentifier: "CustomDropDownCell")
      //  dropDownTableView.separatorStyle = .none
        dropDownTableView.tableFooterView = UIView(frame: .zero)
        dropDownTableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func okHandler(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func heightForText(_ text: String) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: dropDownTableView.bounds.width - 16, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = text
        label.sizeToFit()
        
        // You may add some padding to the height if needed
        return label.frame.height * 2.0
    }
}

extension DropDownViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForText(dropDownArray[indexPath.row])
    }
}

extension DropDownViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomDropDownCell", for: indexPath) as? CustomDropDownCell else { return UITableViewCell() }
        cell.setupUI(text: dropDownArray[indexPath.row])
        return cell
    }
}
