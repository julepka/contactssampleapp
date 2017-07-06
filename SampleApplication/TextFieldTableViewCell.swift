//
//  TextFieldTableViewCell.swift
//  SampleApplication
//
//  Created by Julia Potapenko on 5.07.2017.
//  Copyright © 2017 Julia Potapenko. All rights reserved.
//

import Foundation
import UIKit

class TextFieldTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    let leftMargin: CGFloat = 0.0
    let rightMargin: CGFloat = 0.0
    let topMargin: CGFloat = 0.0
    let bottomMargin: CGFloat = 0.0
    
    var textField = UITextField()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textField.delegate = self
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(textField)
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
    
    func setConstraints() {
        
        let leftConstraint = NSLayoutConstraint(item: textField,
                                                attribute: NSLayoutAttribute.left,
                                                relatedBy: NSLayoutRelation.equal,
                                                toItem: self.contentView,
                                                attribute: NSLayoutAttribute.leftMargin,
                                                multiplier: 1, constant: self.leftMargin)
        
        let rightConstraint = NSLayoutConstraint(item: textField,
                                                 attribute: NSLayoutAttribute.right,
                                                 relatedBy: NSLayoutRelation.equal,
                                                 toItem: self.contentView,
                                                 attribute: NSLayoutAttribute.rightMargin,
                                                 multiplier: 1, constant: self.rightMargin)
        
        let topConstraint = NSLayoutConstraint(item: textField,
                                               attribute: NSLayoutAttribute.top,
                                               relatedBy: NSLayoutRelation.equal,
                                               toItem: self.contentView,
                                               attribute: NSLayoutAttribute.topMargin,
                                               multiplier: 1, constant: self.topMargin)
        
        let bottomConstraint = NSLayoutConstraint(item: textField,
                                                  attribute: NSLayoutAttribute.bottom,
                                                  relatedBy: NSLayoutRelation.equal,
                                                  toItem: self.contentView,
                                                  attribute: NSLayoutAttribute.bottomMargin,
                                                  multiplier: 1, constant: self.bottomMargin)
        
        self.contentView.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }
}
