//
//  AddItemViewController.swift
//  WLog
//
//  Created by Izloop on 3/19/19.
//  Copyright © 2019 Peter Levi Hornig. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var UITextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITextField?.delegate = self

        // Do any additional setup after loading the view.
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveItem(_ sender: Any) {
        
        guard let enteredText = UITextField?.text else {
            return
        }
        
        if enteredText.isEmpty || UITextField?.text == "Type anything..." {
            
            let alert = UIAlertController(title: "Please Type Something", message: "Your entry was left blank.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default) { action in
                
            })
            
            self.present(alert, animated: true, completion: nil)
            
            
        } else {
            
            guard let entryText = UITextField?.text else {
                return
            }
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newEntry = Item(context: context)
            newEntry.entry = entryText
            
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/YY"
            let currentDate = formatter.string(from: date)
            
            let timeFormatter = DateFormatter()
            timeFormatter.timeStyle = .short
            let currentTime = timeFormatter.string(from: date)
            
            newEntry.entry = enteredText
            newEntry.date = currentDate
            newEntry.time = currentTime
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
