//
//  EventViewController.swift
//  MDBSocials
//
//  Created by Vaibhav Gattani on 28/9/18.
//  Copyright © 2018 Vaibhav Gattani. All rights reserved.
//

import UIKit
import Firebase


class EventViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var nameLabel: UILabel!
    var nameTextField: UITextField!
    
    var descriptionLabel: UILabel!
    var descriptionTextView: UITextView!
    
    var selectLibraryImageButton: UIButton!
    var selectCameraImageButton: UIButton!
    var selectedImageView: UIImageView!
    var selectedImage: UIImage!

    var dateLabel: UILabel!
    var datePicker: UIDatePicker!

    var submitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 88, g: 186, b: 247)
        setupNavigationBar()
        setupUI()
        
        // Do any additional setup after loading the view.
    }
    
    func setupNavigationBar(){
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "New Post"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelNewPost))
        
        submitButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.addTarget(self, action: #selector(newPost), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: submitButton)
    }
    
    func setupUI(){
        nameLabel = UILabel(frame: CGRect(x: 20, y: 50, width: view.frame.width/3 - 10, height: 80))
        nameLabel.text = "Event Name: "
        nameLabel.font = UIFont(name: "AvenirNext-Bold", size: 18.0)
        nameLabel.textColor = UIColor(r: 255, g: 223, b: 86)
        view.addSubview(nameLabel)
        
        nameTextField = UITextField(frame: CGRect(x: nameLabel.frame.maxX, y: 50, width: 2*view.frame.width/3 - 10, height: 80))
        nameTextField.placeholder = "Enter Event Name"
        nameTextField.font = UIFont(name: "AvenirNext-Bold", size: 18.0)
        nameTextField.textColor = UIColor.white
        view.addSubview(nameTextField)

        selectCameraImageButton = UIButton(frame: CGRect(x: view.frame.width/2 + 20, y: nameLabel.frame.maxY + 20, width: view.frame.width/2 - 40, height: 50))
        selectCameraImageButton.setTitle("Take Picture", for: .normal)
        selectCameraImageButton.backgroundColor = UIColor(r: 255, g: 223, b: 86)
        selectCameraImageButton.layer.cornerRadius = 10
        selectCameraImageButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        selectCameraImageButton.addTarget(self, action: #selector(selectPictureFromCamera), for: .touchUpInside)
        view.addSubview(selectCameraImageButton)
        
        selectLibraryImageButton = UIButton(frame: CGRect(x: view.frame.width/2 + 20, y: selectCameraImageButton.frame.maxY + 20, width: view.frame.width/2 - 40, height: 50))
        selectLibraryImageButton.setTitle("Select Picture", for: .normal)
        selectLibraryImageButton.layer.cornerRadius = 10
        selectLibraryImageButton.backgroundColor = UIColor(r: 255, g: 223, b: 86)
        selectLibraryImageButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        selectLibraryImageButton.addTarget(self, action: #selector(selectPictureFromLibrary), for: .touchUpInside)
        view.addSubview(selectLibraryImageButton)
        
        selectedImageView = UIImageView(frame: CGRect(x: 10, y: nameLabel.frame.maxY, width: view.frame.width/2, height: view.frame.width/2))
        selectedImageView.contentMode = .scaleAspectFit
        selectedImageView.layer.cornerRadius = 10
        selectedImageView.image = #imageLiteral(resourceName: "mdb_logoonly_flat_whiteoutline")
        view.addSubview(selectedImageView)
        
        
        dateLabel = UILabel(frame: CGRect(x: 0, y: selectedImageView.frame.maxY + 20, width: view.frame.width, height: 20))
        dateLabel.textAlignment = .center
        dateLabel.text = "Event Start Date:"
        dateLabel.font = UIFont(name: "AvenirNext-Bold", size: 18.0)
        dateLabel.textColor = UIColor(r: 255, g: 223, b: 86)
        view.addSubview(dateLabel)
            
            
        datePicker = UIDatePicker(frame: CGRect(x: 10, y: dateLabel.frame.maxY - 5, width: view.frame.width - 20, height: 150))
        view.addSubview(datePicker)
        
        descriptionLabel = UILabel(frame: CGRect(x: 0, y: 50, width: view.frame.width/2, height: 40))
        descriptionLabel.center = CGPoint(x: view.frame.width/2, y: datePicker.frame.maxY + 20)
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = "Event Description:"
        descriptionLabel.font = UIFont(name: "AvenirNext-Bold", size: 18.0)
        descriptionLabel.textColor = UIColor(r: 255, g: 223, b: 86)
        view.addSubview(descriptionLabel)
        
        descriptionTextView = UITextView(frame: CGRect(x: 0, y: descriptionLabel.frame.maxY, width: view.frame.width, height: view.frame.height/8))
        descriptionTextView.text = "Enter Event Description"
        descriptionTextView.textColor = UIColor.lightGray
        descriptionTextView.delegate = self
        descriptionTextView.font = UIFont(name: "AvenirNext-Bold", size: 18.0)
        view.addSubview(descriptionTextView)
    }
    
    
    @objc func cancelNewPost() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func selectPictureFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func selectPictureFromCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func newPost() {
        if nameTextField.hasText && descriptionTextView.hasText && selectedImage != nil {
            let uid = randomString()
            uploadPhoto(uid, selectedImage)
            } else {
            let alertController = UIAlertController(title: "Fields Blank", message:
                "Make sure you enter all required information.", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTextView.textColor == UIColor.lightGray {
            descriptionTextView.text = nil
            descriptionTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextView.text.isEmpty {
            descriptionTextView.text = "Enter Event Description"
            descriptionTextView.textColor = UIColor.lightGray
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = image
        }
        selectedImageView.image = selectedImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func createPost(_ uid: String, _ eventName: String, _ eventDescription: String, _ eventImage: UIImage, _ eventDate: String) {
        let values = ["title": eventName, "description": eventDescription, "date": eventDate, "interestedMembers": [], "numInterested": 0, "poster": (UIApplication.shared.delegate as! AppDelegate).currentUserFullName] as [String : Any]
        let ref = Database.database().reference()
        let eventRef = ref.child("events").child(uid)
        
        eventRef.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                print(error)
                return
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    func uploadPhoto(_ uid: String, _ image: UIImage) {
        let storageRef = Storage.storage().reference().child("image").child(uid)
        guard let data = image.jpegData(compressionQuality: 0.2) else {return}
        storageRef.putData(data, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                // Uh-oh, an error occurred!
                debugPrint("error1")
                return
            }
            // Metadata contains file metadata such as size, content-type.
            // let size = metadata.size
            // You can also access to download URL after upload.
            self.createPost(uid, self.nameTextField.text!, self.descriptionTextView.text!, self.selectedImage, self.datePicker.date.description)
        }
        
    }
    
    func randomString() -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: 16)
        
        for _ in 0..<16 {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        
        return randomString as String
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
