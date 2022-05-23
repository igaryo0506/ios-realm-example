//
//  TableViewController.swift
//  Database
//
//  Created by 五十嵐諒 on 2022/05/22.
//

import UIKit
import RealmSwift

class TableViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {
    let myRealm = MyRealm()
    
    var passMemo:Memo!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRealm.memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = myRealm.memos[indexPath.row].title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [self] (action, view, completionHandler) in
            self.myRealm.delete(memo: self.myRealm.memos[indexPath.row])
            self.table.reloadData()
          completionHandler(true)
        }
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [self] (action, view, completionHandler) in
            passMemo =  myRealm.memos![indexPath.row]
            performSegue(withIdentifier: "segue", sender: nil)
          completionHandler(true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction,editAction])
      }
    
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        table.dataSource = self
        
        table.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myRealm.read()
        table.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let editViewController = segue.destination as! EditViewController
            if passMemo != nil {
                editViewController.memo = passMemo
            }
            editViewController.myRealm = myRealm
        }
    }
    
    @IBAction func addMemo(){
        passMemo = nil
        performSegue(withIdentifier: "segue", sender: nil)
    }
}
