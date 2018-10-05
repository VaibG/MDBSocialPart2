//
//  Event.swift
//  MDBSocials
//
//  Created by Vaibhav Gattani on 4/10/18.
//  Copyright © 2018 Vaibhav Gattani. All rights reserved.
//

import Foundation
import UIKit

class Event: Comparable, Equatable {
    
    var id: String!
    var name: String!
    var description: String
    var date: String!
    var username: String!
    var numInterested: Int!
    var interestedMembers: [String]!
    
    var image: UIImage!
    var imagePath: String!
    
    init(_ uid: String!, _ dict: [String: Any]) {
        self.id = uid
        
        if let title = dict["title"] as? String {
            self.name = title
        } else {
            self.name = "Event"
        }
        if let description = dict["description"] as? String {
            self.description = description
        } else {
            self.description = "Details to come."
        }
        if let date = dict["date"] as? String {
            self.date = date
        } else {
            self.date = "Date TBC"
        }
        if let poster = dict["poster"] as? String {
            self.username = poster
        } else {
            self.username = "Unknown"
        }
        if let numInterested = dict["numInterested"] as? Int {
            self.numInterested = numInterested
        } else {
            self.numInterested = 0
        }
        if let interestedMembers = dict["interestedMembers"] as? [String] {
            self.interestedMembers = interestedMembers
        } else {
            self.interestedMembers = []
        }
        
        self.image = UIImage(named: "default")
        self.imagePath = id
    }
    
    static func < (lhs: Event, rhs: Event) -> Bool {
        return lhs.date < rhs.date
    }
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}
