//
//  OfficeDetailView.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit

class OfficeDetailViewController: UIViewController {
    
    var dataOfScreen: ListOfOfficesItem?
    
    @IBOutlet var nameOfOffice: UILabel!
    @IBOutlet var officeImage: UIImageView!
    @IBOutlet var addressText: UILabel!
    @IBOutlet var addressValue: UILabel!
    @IBOutlet var timingText: UILabel!
    @IBOutlet var openingTiming: UILabel!
    @IBOutlet var telephoneNumberText: UILabel!
    @IBOutlet var telephoneNumber: UILabel!
    @IBOutlet var faxNumberText: UILabel!
    @IBOutlet var faxNumber: UILabel!
    @IBOutlet var mapBTN: UIButton!
    @IBOutlet var contentView: UIScrollView!
    @IBOutlet var noDataText: UILabel!
    
    @IBAction func actionOnCallBTN(_ sender: UIButton) {
        guard let number = telephoneNumber.text else { return }
        number.makeAColl()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Details"
        
        setTextToUIElements()
        getOfficeData()
    }
    
    // MARK: private Methods
    func setTextToUIElements() {
        
        mapBTN.setTitle("Show on map", for: .normal)
        mapBTN.layer.cornerRadius = 5.0
        mapBTN.backgroundColor = Theme.ColorOfBasic
        mapBTN.setTitleColor(Theme.ColorOfSecondary, for: .normal)
        
        addressText.text = "Address :"
        timingText.text = "Open Timings :"
        telephoneNumberText.text = "Telephone Number :"
        faxNumberText.text = "Fax Number :"
        
        noDataText.text = "No data is available"
    }
    
    func showEmptyView(show: Bool) {
        noDataText.isHidden = !show
        contentView.isHidden = show
    }
    
    func getOfficeData() {
        
        if let data = dataOfScreen {
            nameOfOffice.text = data.nameOfOffice
            addressValue.text = data.nameOfOffice
            telephoneNumber.text = data.telephoneNumberOfOffice
            faxNumber.text = data.faxNumberOfOffice
            if let openingTimingValue = data.openingTimeOfOffice {
                openingTiming.text = openingTimingValue.replacingOccurrences(of: ", ", with: "\n")
            }
            
            if let imageURL = data.imageURLOfOffice {
                officeImage.imageFromServerURL(urlString: imageURL, placeHolder: UIImage(named: "imageplaceholder")!)
            }
            showEmptyView(show: false)
        } else {
            showEmptyView(show: false)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowMapDetailViewID", let vc = segue.destination as? OfficeOnMapViewController {
            vc.dataOfScreen = dataOfScreen
            
        }
        
    }

}


