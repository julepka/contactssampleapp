//
//  MultilineTableViewCell.swift
//  SampleApplication
//
//  Created by Julia Potapenko on 5.07.2017.
//  Copyright © 2017 Julia Potapenko. All rights reserved.
//

import Foundation
import UIKit

class MultilineTableViewCell: UITableViewCell {
    
    let leftMargin: CGFloat = 0.0
    let rightMargin: CGFloat = 0.0
    let topMargin: CGFloat = 0.0
    let bottomMargin: CGFloat = 0.0
    
    var multilineTextLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        multilineTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        multilineTextLabel.numberOfLines = 0
        
        self.contentView.addSubview(multilineTextLabel)
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setConstraints() {
        
        let leftConstraint = NSLayoutConstraint(item: multilineTextLabel,
                                                attribute: NSLayoutAttribute.left,
                                                relatedBy: NSLayoutRelation.equal,
                                                toItem: self.contentView,
                                                attribute: NSLayoutAttribute.leftMargin,
                                                multiplier: 1, constant: self.leftMargin)
        
        let rightConstraint = NSLayoutConstraint(item: multilineTextLabel,
                                                 attribute: NSLayoutAttribute.right,
                                                 relatedBy: NSLayoutRelation.equal,
                                                 toItem: self.contentView,
                                                 attribute: NSLayoutAttribute.rightMargin,
                                                 multiplier: 1, constant: self.rightMargin)
        
        let topConstraint = NSLayoutConstraint(item: multilineTextLabel,
                                               attribute: NSLayoutAttribute.top,
                                               relatedBy: NSLayoutRelation.equal,
                                               toItem: self.contentView,
                                               attribute: NSLayoutAttribute.topMargin,
                                               multiplier: 1, constant: self.topMargin)
        
        let bottomConstraint = NSLayoutConstraint(item: multilineTextLabel,
                                                  attribute: NSLayoutAttribute.bottom,
                                                  relatedBy: NSLayoutRelation.equal,
                                                  toItem: self.contentView,
                                                  attribute: NSLayoutAttribute.bottomMargin,
                                                  multiplier: 1, constant: self.bottomMargin)
        
        self.contentView.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }

}
