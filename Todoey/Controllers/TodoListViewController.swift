//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let defaults = UserDefaults.standard//localにdataを保存するためのuserdefaultを定義
    
    var itemArray = [
        "buy apple", "play teniss", "study math"
    ]
    
    //UITableViewControllerでは，TableViewとは異なり，tableView.dataSource=selfやtableView.delegate=selfが必要ない（protocolにはdefaultで従っている）
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //localのuserdefaultに保存されているdataを取得
        //userdefaultにdataがない場合，clashする可能性があるのでoptionalを利用
        if let items = defaults.array(forKey: K.todoArrayName) as? [String] {
            itemArray = items
        }
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //UITableViewControllerではIBOutletを定義しなくてもdefaultでtableViewが定義されている
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    //cellをtapしたときに発火するmethod
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        //print(itemArray[indexPath.row])
        
        //tapしたcellにcheckmarkをつける（accessory），すでにcheckmarkがついていたら外す
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //cellをtapして選択した後，選択されてない状態にする＝tapしたら灰色になり，すぐ元に戻る
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Item
    //nav barのaddbuttonをtapしたときに，itemを追加するpopupを表示
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks the Add Item button on our UIAlert
            //このブロックはcompletion handlerなので，"Add Item"が押された後に発火する
            self.itemArray.append(textField.text!)//今の状態だとtextが空の時に""が追加される（textが空の時にvalidationを後でつける)
            
            self.defaults.set(self.itemArray, forKey: K.todoArrayName)
            
            self.tableView.reloadData()
            print("Success!")
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new items"
            textField = alertTextField//alertTextFieldはこのblock内でしか扱えないので，扱える範囲を広げるためにtextFieldに代入
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}
