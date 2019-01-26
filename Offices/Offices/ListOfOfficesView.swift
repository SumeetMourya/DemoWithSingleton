//
//  ListOfOfficesView.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit
import ESPullToRefresh


class ListOfOfficesViewController: UIViewController {
    
    var listOfOffice: [ListOfOfficesItem] = [ListOfOfficesItem]()
    var selectedOfficeData: ListOfOfficesItem? = nil
    
    @IBOutlet var tblvOfficeList: UITableView!
    @IBOutlet var statusText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Overview"
        
        tblvOfficeList.tableFooterView = UIView(frame: .zero)
        tblvOfficeList.rowHeight = UITableViewAutomaticDimension
        tblvOfficeList.estimatedRowHeight = 50
        
        tblvOfficeList.es.addPullToRefresh {
            SingletonManager.sharedInstance.updateData()
        }

        self.updateListOfOffices(data: SingletonManager.sharedInstance.getOfficeList())

        NotificationCenter.default.addObserver(self, selector: #selector(onOnloadingComplete), name: Notification.Name("LISTUPDATE"), object: nil)
        
    }
    
    // MARK: Private Methods
    
    func showAlertView(msg: String, title: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: { (action:UIAlertAction) in
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: ListOfOfficesViewProtocol methods
    func updateListOfOffices(data: [ListOfOfficesItem]) {
        
        DispatchQueue.main.async() {
            
            let officesListIsEmpty: Bool = data.count <= 0
            self.statusText.isHidden = !officesListIsEmpty
            self.tblvOfficeList.isHidden = officesListIsEmpty
            
            if !officesListIsEmpty {
                self.listOfOffice.removeAll()
                self.tblvOfficeList.es.stopPullToRefresh()
                self.listOfOffice = data
                self.tblvOfficeList.reloadData()
            }
        }
        
    }
    
    func errorInLoadingDataWith( statusCode: ApiStatusType) {
        
        switch statusCode {
        case .apiSucceed:
            break
            
        case .netWorkIssue:
            showAlertView(msg: "Error", title: "Please check your network connectivity.")
            return
            
        case .apiIssue:
            showAlertView(msg: "Error", title: "Server issue")
            return
            
        case .apiParsingIssue:
            showAlertView(msg: "Error", title: "Server data parsing issue")
            return

        case .apiEncodingIssue:
            showAlertView(msg: "Error", title: "Server decoding issue")
            return

        case .none:
            break
        }
        
    }
    
    @objc private func onOnloadingComplete(notification: Notification) {
        
        if let codeValue = notification.userInfo?["code"] as? ApiStatusType {
            
            self.errorInLoadingDataWith(statusCode: codeValue)
            self.updateListOfOffices(data: SingletonManager.sharedInstance.getOfficeList())
            
        }
        
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if selectedOfficeData != nil {
            if segue.identifier == "DetailViewID", let vc = segue.destination as? OfficeDetailViewController {
                vc.dataOfScreen = selectedOfficeData
                
            }
        }
        
    }

}

extension ListOfOfficesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedOfficeData = listOfOffice[indexPath.row]
        performSegue(withIdentifier: "DetailViewID", sender: self)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableViewAutomaticDimension
    }
    
}

extension ListOfOfficesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfOffice.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:OfficeCell? = tableView.dequeueReusableCell(withIdentifier: OfficeCell.identifier) as? OfficeCell
        
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: OfficeCell.identifier) as? OfficeCell
        }
        
        cell?.selectionStyle = .none
        cell?.contentView.backgroundColor = UIColor.clear
        cell?.backgroundColor = UIColor.clear
        cell?.bindDataToUI(data: listOfOffice[indexPath.row])
        
        return cell!
        
    }
    
    
}

