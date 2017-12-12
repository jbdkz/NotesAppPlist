//
//  NewNoteViewController.swift
//  NotesApp
//
//  Created by John Diczhazy on 12/10/17.
//  Copyright © 2017 JohnDiczhazy. All rights reserved.
//

import UIKit

import UIKit

class NewNoteViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    
    @IBAction func saveNote(_ sender: AnyObject) {
        // Save note to plist
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let pathForThePlistFile = appDelegate.plistPathInDocument
        
        // Extract the content of the file as NSData
        let data:Data =  FileManager.default.contents(atPath: pathForThePlistFile)!
        // Convert the NSData to mutable array
        do{
            let notesArray = try PropertyListSerialization.propertyList(from: data, options: PropertyListSerialization.MutabilityOptions.mutableContainersAndLeaves, format: nil) as! NSMutableArray
            notesArray.add(self.textView.text)
            // Save to plist
            notesArray.write(toFile: pathForThePlistFile, atomically: true)
        }catch{
            print("An error occurred while writing to plist")
        }
        // Dismiss the modal controller
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.textView.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
