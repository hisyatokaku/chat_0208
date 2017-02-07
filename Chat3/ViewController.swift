//
//  ViewController.swift
//  Chat3
//
//  Created by とん航 on 2/6/17.
//  Copyright © 2017 とん航. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var TextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    //@IBOutlet weak var sendbutton:UIButton!
    
    @IBAction func ButtonTouchDown(_ sender: Any) {
        handlesend()
    }
    
    var databaseref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observemessage()
            }
    
    func observemessage(){
        
        databaseref = FIRDatabase.database().reference().child("messages")
        databaseref.observe(.childAdded, with: { (snapshot) in
        //databaseref.observeSingleEvent(of: .childAdded, with: { snapshot in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let message = Message()
                message.setValuesForKeys(dictionary)
                
                self.TextView.text = "\(message.name!):\(message.text!)"

            }}
        )}

    func handlesend(){
        let ref = FIRDatabase.database().reference().child("messages")
        let childref = ref.childByAutoId()
        let values = ["text": messageTextField.text!,"name": nameTextField.text!]
        childref.updateChildValues(values)
        messageTextField.text = ""
    }


//    func textReturn(textField: UITextField) -> Bool{
    func textReturn() -> Bool{
        let message = ["name": nameTextField, "message": messageTextField.text!] as [String : Any]
        print(message)
        databaseref.childByAutoId().setValue(message)
        //textField.resignFirstResponder()
        messageTextField.text = ""
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

