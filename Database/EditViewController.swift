//
//  EditViewController.swift
//  Database
//
//  Created by 五十嵐諒 on 2022/05/17.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController{
    var myRealm: MyRealm!
    var memo:Memo?
    
    @IBOutlet var titleTextField:UITextField!
    @IBOutlet var contentTextField:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if memo != nil {
            titleTextField.text = memo?.title
            contentTextField.text = memo?.content
        }
    }
    
    @IBAction func save() {
        let title: String = titleTextField.text!
        let content: String = contentTextField.text!

        if memo != nil {
            myRealm.update(memo: memo!, title: title, content: content)
        }else{
            myRealm.add(title: title,content: content)
        }
        self.navigationController?.popViewController(animated: true)
    }

}
