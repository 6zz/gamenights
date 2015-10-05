//
//  GroupsViewController.swift
//  Gamenights
//
//  Created by Shawn Zhu on 10/3/15.
//  Copyright © 2015 T-West. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addGroupButton: UIButton!
    @IBOutlet weak var newGroupTextField: UITextField!
    
    var groups: [GroupModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        addGroupButton.layer.cornerRadius = 5;
        
        // flex row height
        tableView.rowHeight = UITableViewAutomaticDimension
        
        GroupModel.loadAll({ (groupResults, groupLoadError) -> Void in
            if let groupLoadError = groupLoadError {
                NSLog("Failed to load groups \(groupLoadError)")
            } else {
                self.groups = groupResults
                self.tableView.reloadData()
            }
        });

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "groupDetailsSegue" {
            let destinationNavigationController = segue.destinationViewController as! UINavigationController
            let destinationViewController = destinationNavigationController.topViewController as! GamesViewController
            let cell = sender as! GroupCell
            let indexPath = tableView.indexPathForCell(cell)
            
            destinationViewController.group = groups?[indexPath!.row]
        }
    }
    
    @IBAction func onAddGroup(sender: AnyObject) {
        let group = GroupModel(nil)
        group.name = newGroupTextField.text
        group.save({ (error) -> Void in
            if error != nil {
                print("Error creating group")
                return
            } else {
                self.navigationController?.popViewControllerAnimated(true)
            }
        })
    }
}

extension GroupsViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groups?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GroupCell", forIndexPath: indexPath) as! GroupCell
        cell.group = groups?[indexPath.row]
        
        return cell
    }
}

extension GroupsViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
