//
//  MainViewController.swift
//  MDBSocials
//
//  Created by Vaibhav Gattani on 27/9/18.
//  Copyright © 2018 Vaibhav Gattani. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    var userID: String!
    var logoutButton: UIButton!
    var listView: UITableView!
    var allEvents: [Event]! = []
    var selectedEvents: Event!
    var first = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        downloadEvents()
        createTableView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if first == false {
            allEvents.removeAll()
            downloadEvents()
        }
        first = false
    }
    
    func createTableView() {
        listView = UITableView(frame: view.frame)
        listView.delegate = self
        listView.dataSource = self
        listView.rowHeight = view.frame.height/3
        listView.register(eventCell.self, forCellReuseIdentifier: "eventCell")
        view.addSubview(listView)
    }
    
    func setupNavigationBar(){
        self.navigationItem.title = "My Feed"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        logoutButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoutButton)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createEvent))
    }
    
    @objc func logOut(){
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            let alertController = UIAlertController(title: "Error Logging Out", message:
                signOutError.debugDescription, preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        performSegue(withIdentifier: "backToLogin", sender: nil)
    }
    
    @objc func createEvent(){
        performSegue(withIdentifier: "toCreate", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let VC = segue.destination as? DetailViewController {
            VC.event = selectedEvents
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

extension MainViewController {
    func downloadEvents() {
        let eventRef = Database.database().reference().child("events")
        let imageRef = Storage.storage().reference().child("image")
        
        eventRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let all = snapshot.value as? [String : AnyObject] ?? [:]
            let group = DispatchGroup()
            var recentPull:[Event] = []
            
            
            for (key, value) in all {
                group.enter()
                
                let e = Event(key, value as! [String : AnyObject])
                let imageFile = imageRef.child(key)
                
                    // Download in memory with a maximum allowed size of 5MB (1 * 1024 * 1024 bytes)
                    imageFile.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        if let error = error {
                            // Uh-oh, an error occurred!
                            debugPrint("Error with file retrieve", error)
                            e.imagePath = "DEFAULT"
                            e.image = UIImage(named: "mdb_logo_only_flat")
                        } else {
                            e.image = UIImage(data: data!)
                        }
                        recentPull.append(e)
                        group.leave()
                    }
                }
            
            group.notify(queue: DispatchQueue.main, execute: {
                self.allEvents = recentPull.sorted()
                self.listView.reloadData()
            })
        })
    }
}
