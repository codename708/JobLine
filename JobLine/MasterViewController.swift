//
//  MasterViewController.swift
//  JobLine
//
//  Created by naoya-kanoh on 2015/09/01.
//  Copyright (c) 2015年 naoya.kanoh. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate ,UITextFieldDelegate{

    //var managedObjectContext: NSManagedObjectContext? = nil
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchedResultController = self.getFetchedResultController()
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)

        
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
    
    //Jobオブジェクトの作成メゾット
    func createJob(name:String) {
        let entity = NSEntityDescription.entityForName("Job", inManagedObjectContext: managedObjectContext!)
        let job = Job(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        
        job.content = name
        self.checkContentAndSave()
    }
    //入力内容のチェックと保存
    func checkContentAndSave() {
        var error: NSError?
        if !managedObjectContext!.save(&error) {
            checkAlert()
            managedObjectContext!.rollback()
        }
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
                //println(textField.text)
                //self.insertNewObject(textField.text)
                self.createJob(textField.text)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(defaultAction)
        //アラートビューの表示
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    

    func checkAlert() {
        let alertController = UIAlertController(title: "Error", message: "Content is empty!", preferredStyle: .Alert)
        let dafaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(dafaultAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }


/*
    //新規モデルオブジェクトの生成
    func insertNewObject(content:String){
        let context = self.fetchedResultsController.managedObjectContext
        let entity = self.fetchedResultsController.fetchRequest.entity!
        //Jobオブジェクトを生成
        let job = NSEntityDescription.insertNewObjectForEntityForName(entity.content!, inManagedObjectContext: context) as! NSManagedObject
        //Detailオブジェクトの生成
        let detail = NSEntityDescription.insertNewObjectForEntityForName("Detail", inManagedObjectContext: context) as! NSManagedObject
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        //Jobオブジェクトに名前とDetailオブジェクトをセットする
        job.setValue(String(), forKey:"content")
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
        let numberOfSections = fetchedResultController.sections?.count
        return numberOfSections!
    }
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
        //return self.fetchedResultsController.sections!.count
    }
*/
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInsection = fetchedResultController.sections?[section].numberOfObjects
        return numberOfRowsInsection!
    }
    /*
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        let sectionInfo = self.fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects

        //return 0
    }
*/

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        let job = fetchedResultController.objectAtIndexPath(indexPath) as! Job
        cell.textLabel?.text = job.content
        return cell
    }
/*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
*/
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let managedObject: NSManagedObject = fetchedResultController.objectAtIndexPath(indexPath) as! NSManagedObject
        managedObjectContext?.deleteObject(managedObject)
        managedObjectContext?.save(nil)
    }
/*
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
            
            var error: NSError? = nil
            if !context.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //println("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
    }
*/

/*
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        cell.textLabel!.text = object.valueForKey("content")!.description
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

    // MARK: - Fetched results controller
/*
    var fetchedResultsController: NSFetchedResultsController {
        // 既にオブジェクトが存在していればオブジェクトを返却して処理を終了
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        //このプロパティに初めてアクセスされた時の記述
        //fetchRequestオブジェクトの生成
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("Job",
            inManagedObjectContext: self.managedObjectContext!)
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "content", ascending: true)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        //データの読み込みを実行
        var error: NSError? = nil
        if !_fetchedResultsController!.performFetch(&error) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //println("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
        
        return _fetchedResultsController!
    }
*/
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: self.jobFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }

    
    func jobFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Job")
        let sortDescriptor = NSSortDescriptor(key: "content", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
//    var _fetchedResultsController: NSFetchedResultsController? = nil
    
/*    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
*/
    
    
/*
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        default:
            return
        }
    }
*/

/*
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, atIndexPath: indexPath!)
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        default:
            return
        }
    }
*/
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
/*
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
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
