//
//  MasterViewController.swift
//  JobLine
//
//  Created by naoya-kanoh on 2015/09/01.
//  Copyright (c) 2015年 naoya.kanoh. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //NavigationBarの右に編集ボタンを追加する
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //Toolbarの左に表示設定ボタン、右に新規作成ボタンを追加
        var settingButton = UIBarButtonItem(barButtonSystemItem: .Organize, target: self, action: "showSort")//表示設定ボタン
        var flexibleSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)//スペースを追加
        var composeButton = UIBarButtonItem(barButtonSystemItem: .Compose, target: self, action: "showAlert")//新規作成ボタン
        //ToolBarに配置
        self.toolbarItems = [settingButton,flexibleSpace,composeButton]
        //ToolBarの非表示を無効化
        self.navigationController?.setToolbarHidden(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //showAlertメゾットの実装
    func showAlert(){
        let alertController = UIAlertController(title: "Update Job", message: "Please Enter Job.", preferredStyle: .Alert)
        //アラートビューにテキストフィールドを追加
        alertController.addTextFieldWithConfigurationHandler({(text:UITextField!) -> Void in
            //対象UITextFieldが引数として取得できる
            text.placeholder = "Enter the Job"
        })
//        alertController.addTextFieldWithConfigurationHandler({(text:UITextField!) -> Void in
            //対象UITextFieldが引数として取得できる
//            text.placeholder = "Tag"})
        //キャンセルボタン
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        //作成ボタン
        let defaultAction = UIAlertAction(title: "Create", style: .Default){
            [unowned self]action in
            if let textFields = alertController.textFields{
                let textField = textFields[0] as! UITextField
                println(textField.text)
/*                self.insertNewObject(textField.text)
*/
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(defaultAction)
        //アラートビューの表示
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    




    //新規モデルオブジェクトの生成
/*    func insertNewObject(context:String){
        let context = self.fetchedResultsController.managedObjectContext
        let entity = self.fetchedResultsController.fetchRequest.entity!
        //Jobオブジェクトを生成
        let job = NSEntityDescription.insertNewObjectForEntityForName(entity.context!, inManagedObjectContext: context) as! NSManagedObject
        //Detailオブジェクトの生成
        let detail = NSEntityDescription.insertNewObjectForEntityForName("Detail", inManagedObjectContext: context) as! NSManagedObject
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        //Jobオブジェクトに名前とDetailオブジェクトをセットする
        job.setValue(String(), forKey:"context")
        job.setValue(Detail(), forKey:"detail")
        //データの保存
        var error: NSError? = nil
        if !context.save(&error){
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //println("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
    }
*/
    //showSortメゾットの実装
    func showSort() {
        let alertController = UIAlertController(title: "How to sort", message: "Please choice how to sort", preferredStyle: .ActionSheet)
        let firstAction = UIAlertAction(title: "Update", style: .Default) {
            action in println("Pushed First")
        }
        let secondAction = UIAlertAction(title: "Limit", style: .Default) {
            action in println("Pushed Second")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) {
            action in println("Pushed CANCEL")
        }
        
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        alertController.addAction(cancelAction)
        
/*        //For ipad And Univarsal Device
        alertController.popoverPresentationController?.sourceView = sender as UIView;
        alertController.popoverPresentationController?.sourceRect = CGRect(x: (sender.frame.width/2), y: sender.frame.height, width: 0, height: 0)
        alertController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.Up
*/
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
