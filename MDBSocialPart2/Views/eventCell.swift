//
//  eventCell.swift
//  MDBSocials
//
//  Created by Vaibhav Gattani on 4/10/18.
//  Copyright © 2018 Vaibhav Gattani. All rights reserved.
//

import Foundation
import UIKit

class eventCell: UITableViewCell {
    
    var eventImageView: UIImageView!
    var eventName: UILabel!
    var eventDesc: UILabel!
    var eventHost: UILabel!
    var numInterested: UILabel!
    var interestedButton: UIButton!
    var event_id: String!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor(r: 88, g: 186, b: 247)
        eventImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: contentView.frame.height/2, height: contentView.frame.height - 20))
        eventImageView.contentMode = .scaleAspectFill
        eventImageView.clipsToBounds = true
        contentView.addSubview(eventImageView)
        
        eventName = UILabel(frame: CGRect(x: eventImageView.frame.width + 15, y: 10, width: contentView.frame.width - eventImageView.frame.width - 20, height: 25))
        eventName.textAlignment = .center
        eventName.textColor = UIColor(r: 255, g: 223, b: 86)
        eventName.font = UIFont(name: "AvenirNext-Bold", size: 26)
        eventName.adjustsFontSizeToFitWidth = true
        contentView.addSubview(eventName)
        
        eventHost = UILabel(frame: CGRect(x: eventImageView.frame.width + 10, y: 50, width: contentView.frame.width - eventImageView.frame.width - 10, height: 20))
        eventHost.textAlignment = .center
        eventHost.textColor = UIColor(r: 255, g: 223, b: 86)
        eventHost.font = UIFont(name: "AvenirNext-Bold", size: 18)
        contentView.addSubview(eventHost)
        
        eventDesc = UILabel(frame: CGRect(x: eventImageView.frame.width + 10, y: 70, width: contentView.frame.width - eventImageView.frame.width - 10, height: 80))
        eventDesc.numberOfLines = 3
        eventDesc.lineBreakMode = NSLineBreakMode.byWordWrapping
        eventDesc.textAlignment = .center
        eventDesc.textColor = UIColor(r: 255, g: 223, b: 86)
        eventDesc.font = UIFont(name: "AvenirNext-Bold", size: 16)
        contentView.addSubview(eventDesc)
        
        numInterested = UILabel(frame: CGRect(x: eventImageView.frame.width + 10, y: 160, width: contentView.frame.width - eventImageView.frame.width - 10, height: 20))
        numInterested.textAlignment = .center
        numInterested.textColor = UIColor(r: 255, g: 223, b: 86)
        numInterested.font = UIFont(name: "AvenirNext-Bold", size: 18)
        contentView.addSubview(numInterested)
        
    }
    
    func initialCellFrom(event: Event) {
        eventImageView.image = event.image
        eventName.text = event.name
        eventDesc.text = event.description
        eventHost.text = "Host: " + event.username
        numInterested.text = "\(event.numInterested ?? 0) Interested"
        event_id = event.id
        
    }
    
}
