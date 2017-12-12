//
//  ViewController.swift
//  NotesApp
//
//  Created by John Diczhazy on 12/10/17.
//  Copyright © 2017 JohnDiczhazy. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    
    var notesArray:NSMutableArray!
    var plistPath:String!
    
    
    @IBAction func editTable(_ sender: AnyObject) {
        if self.tableView.isEditing{
            let leftBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(ViewController.editTable(_:)))
            self.navigationItem.leftBarButtonItem = leftBarButtonItem
            self.tableView.setEditing(false, animated: true)
        }else{
            let leftBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(ViewController.editTable(_:)))
            self.navigationItem.leftBarButtonItem = leftBarButtonItem
            self.tableView.setEditing(true, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        plistPath = appDelegate.plistPathInDocument
        // Extract the content of the file as NSData
        let data:Data =  FileManager.default.contents(atPath: plistPath)!
        do{
            notesArray = try PropertyListSerialization.propertyList(from: data, options: PropertyListSerialization.MutabilityOptions.mutableContainersAndLeaves, format: nil) as! NSMutableArray
        }catch{
            print("Error occured while reading from the plist file")
        }
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: UITableView DataSource
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
        cell.textLabel!.text = notesArray.object(at: indexPath.row) as? String
        return cell
    }
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int{
        return notesArray.count
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath){
        // remove the row from the array
        notesArray.removeObject(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        notesArray.write(toFile: plistPath, atomically: true)
    }
    
}

