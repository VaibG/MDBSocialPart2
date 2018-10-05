//
//  DetailViewController.swift
//  MDBSocials
//
//  Created by Vaibhav Gattani on 4/10/18.
//  Copyright © 2018 Vaibhav Gattani. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var event: Event!
    var eventImageView: UIImageView!
    var eventName: UILabel!
    var eventDesc: UILabel!
    var eventDate: UILabel!
    var eventHost: UILabel!
    var numInterested: UILabel!
    var interestedButton: UIButton!
    var event_id: String!
    var userInterested = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 88, g: 186, b: 247)
        setupUI()
    }
    
    func setupUI() {
        
        eventName = UILabel(frame: CGRect(x: 10, y: 80, width: view.frame.width - 20, height: 30))
        eventName.textAlignment = .center
        eventName.textColor = UIColor(r: 255, g: 223, b: 86)
        eventName.font = UIFont(name: "AvenirNext-Bold", size: 26)
        eventName.adjustsFontSizeToFitWidth = true
        eventName.text = event.name
        view.addSubview(eventName)
        
        eventImageView = UIImageView(frame: CGRect(x: 10, y: eventName.frame.maxY + 20, width: view.frame.width - 20, height: view.frame.height/4))
        eventImageView.contentMode = .scaleAspectFill
        eventImageView.clipsToBounds = true
        eventImageView.image = event.image
        view.addSubview(eventImageView)
        
        eventHost = UILabel(frame: CGRect(x: 10, y: eventImageView.frame.maxY + 20, width: view.frame.width - 20, height: 30))
        eventHost.textAlignment = .center
        eventHost.textColor = UIColor(r: 255, g: 223, b: 86)
        eventHost.font = UIFont(name: "AvenirNext-Bold", size: 22)
        eventHost.text = "Host: " + event.username
        view.addSubview(eventHost)
        
        eventDate = UILabel(frame: CGRect(x: 10, y: eventHost.frame.maxY + 20, width: view.frame.width - 20, height: 30))
        eventDate.textAlignment = .center
        eventDate.textColor = UIColor(r: 255, g: 223, b: 86)
        eventDate.font = UIFont(name: "AvenirNext-Bold", size: 22)
        eventDate.text = "Date: " + event.date
        view.addSubview(eventDate)
        
        eventDesc = UILabel(frame: CGRect(x: 10, y: eventDate.frame.maxY + 20, width: view.frame.width - 20, height: 80))
        eventDesc.numberOfLines = 0
        eventDesc.lineBreakMode = NSLineBreakMode.byWordWrapping
        eventDesc.textAlignment = .center
        eventDesc.textColor = UIColor(r: 255, g: 223, b: 86)
        eventDesc.font = UIFont(name: "AvenirNext-Bold", size: 18)
        eventDesc.text = event.description
        view.addSubview(eventDesc)
        
        numInterested = UILabel(frame: CGRect(x: view.frame.width/2, y: eventDesc.frame.maxY + 20, width: view.frame.width/2, height: 60))
        numInterested.textAlignment = .center
        numInterested.textColor = UIColor(r: 255, g: 223, b: 86)
        numInterested.font = UIFont(name: "AvenirNext-Bold", size: 22.0)
        numInterested.text = "\(event.numInterested ?? 0) Interested"
        view.addSubview(numInterested)
        
        interestedButton = UIButton(frame: CGRect(x: 10, y: eventDesc.frame.maxY + 20, width: view.frame.width/2 - 10, height: 60))
        interestedButton.backgroundColor = UIColor(r: 255, g: 223, b: 86)
        interestedButton.setTitleColor(UIColor.white, for: .normal)
        interestedButton.setTitle("Interested", for: .normal)
        interestedButton.layer.cornerRadius = 10
        interestedButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 22.0)
        interestedButton.addTarget(self, action: #selector(interestedIncremented), for: .touchUpInside)
        view.addSubview(interestedButton)
    }
    
    
    @objc func interestedIncremented() {
        if userInterested == false {
            event.numInterested += 1
            numInterested.text = "\(event.numInterested ?? 0) Interested"
            userInterested = true
        } else {
            event.numInterested -= 1
            numInterested.text = "\(event.numInterested ?? 0) Interested"
            userInterested = false
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
