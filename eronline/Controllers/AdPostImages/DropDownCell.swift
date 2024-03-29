//
//  DropDownCell.swift
//  AdForest
//
//  Created by apple on 5/9/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import DropDown

protocol textSelectDropDown {
    func textValSelecrDrop(value: String,indexPath: Int, fieldType:String, section: Int,fieldName:String)
}

class DropDownCell: UITableViewCell {

    //MARK:- Outlets
    
    @IBOutlet weak var containerView: UIView! {
        didSet{
            containerView.addShadowToView()
        }
    }
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var oltPopup: UIButton!
    
    //MARK:- Properties
    let defaults = UserDefaults.standard
    var btnPopUpAction : (()->())?
    var dropDownValuesArray = [String]()
    var dropDownKeysArray = [String]()
    var fieldTypeNameArray = [String]()
    
    var selectedKey = ""
    var selectedValue = ""
    var param = ""
    var index = 0
    var section = 0
    var delegate:textSelectDropDown?
    var fieldNam = ""
    var bidOnOfCell = 0
    
    var selectedIndex = 0
    var objSaved = AdPostField()
   // var delegate: AddDataDelegate?
    
    
    let valueDropDown = DropDown()
    lazy var dropDowns : [DropDown] = {
        return [
            self.valueDropDown
        ]
    }()
    
    //MARK:- View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK:- Custom
    
    //MARK:- SetUp Drop Down
    func accountDropDown() {
        valueDropDown.anchorView = oltPopup
        valueDropDown.dataSource = dropDownValuesArray
        valueDropDown.selectionAction = { [unowned self]
            (index, item) in
            self.oltPopup.setTitle(item, for: .normal)
            self.selectedValue = item
            self.selectedKey = self.dropDownKeysArray[index]
            self.param = self.fieldTypeNameArray[index]
            print(self.param, self.selectedKey)
            self.bidOnOfCell = index
            self.objSaved.fieldVal = item
            //self.delegate?.addToFieldsArray(obj: self.objSaved, index: self.selectedIndex, isFrom: "select", title: item)
            self.defaults.set(item, forKey: "value")
            self.delegate?.textValSelecrDrop(value: self.selectedKey, indexPath: index, fieldType: "select", section: self.section,fieldName : self.fieldNam)
            self.defaults.synchronize()
            print(self.fieldNam,self.bidOnOfCell)
            
        }
    }
    
    @IBAction func actionPopup(_ sender: Any) {
        self.btnPopUpAction?()
    }
}
