//
//  ViewController.swift
//  JobLine
//
//  Created by naoya-kanoh on 2015/09/01.
//  Copyright (c) 2015年 naoya.kanoh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Toolbarの右に新規作成ボタンを追加
        var flexibleSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)//スペースを追加
        var composeButton = UIBarButtonItem(barButtonSystemItem: .Compose, target: self, action: "showAlert")//新規作成ボタン
        //ToolBarに配置
        self.toolbarItems = [flexibleSpace,composeButton]
        //ToolBarの非表示を無効化
        self.navigationController?.setToolbarHidden(false, animated: false)

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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

