////
////  ViewController.swift
////  Todoey
////
////  Created by Philipp Muellauer on 02/12/2019.
////  Copyright © 2019 App Brewery. All rights reserved.
////
//
////UserDefaultを利用してlocal dataを保存したもの．ただし，自作のItem型のcustom objectをデフォルトの.plistファイルには保存することができない（このファイルだとaddButtonで追加して保存できない）
////自作のcustom objectをNSCoderを利用して,自作の.plistファイルに保存したものは別ファイル
//
//import UIKit
//
//class TodoListViewController: UITableViewController {
//
//    let defaults = UserDefaults.standard//localにdataを保存するためのuserdefaultを定義
//
//    var itemArray = [Item]()
//
//    //UITableViewControllerでは，TableViewとは異なり，tableView.dataSource=selfやtableView.delegate=selfが必要ない（protocolにはdefaultで従っている）
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        var newItem = Item()
//        newItem.title = "buy apples"
//        itemArray.append(newItem)
//
//        var newItem2 = Item()
//        newItem2.title = "do homework"
//        itemArray.append(newItem2)
//
//        var newItem3 = Item()
//        newItem3.title = "play tennis"
//        itemArray.append(newItem3)
//
//
//        //localのuserdefaultに保存されているdataを取得
//        //userdefaultにdataがない場合，clashする可能性があるのでoptionalを利用
//        if let items = defaults.array(forKey: K.todoArrayName) as? [Item] {
//            itemArray = items
//        }
//    }
//
//    //MARK: - Tableview Datasource Methods
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return itemArray.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("cellForRowAtIndexPath Called")//iterateするのでitemArrayの要素数分だけ呼び出される
//
//        //UITableViewCellと結びつけた場合，仮にcellにcheckmarkをつけて画面を下にscrollしてcheckしたcellが見えなくなり，またそのcheckしたcellを見ようとするとcheckが取れているのでダメ（cellが見えなくなると破棄されるため）
//        //let cell = UITableViewCell(style: .default, reuseIdentifier: K.cellIdentifier)
//
//        //UITableViewControllerではIBOutletを定義しなくてもdefaultでtableViewが定義されている
//        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
//        let item = itemArray[indexPath.row]
//        cell.textLabel?.text = item.title
//
//        //Ternary opratorを用いてシンプルに記述
//        cell.accessoryType = item.isChecked ? .checkmark : .none
//        //冗長1
//        //cell.accessoryType = item.isChecked == true ? .checkmark : .none
//        //冗長2
////        if item.isChecked == true {
////            cell.accessoryType = .checkmark
////        } else {
////            cell.accessoryType = .none
////        }
//
//        return cell
//    }
//
//
//    //MARK: - TableView Delegate Methods
//    //cellをtapしたときに発火するmethod
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //print(indexPath.row)
//        //print(itemArray[indexPath.row])
//
//        //tapしたcellにcheckmarkをつける，すでにcheckmarkがついていたら外す
//        itemArray[indexPath.row].isChecked = !itemArray[indexPath.row].isChecked//trueだったらfalseに反転
//        //冗長
////        if itemArray[indexPath.row].isChecked == true {
////            itemArray[indexPath.row].isChecked = false
////        } else {
////            itemArray[indexPath.row].isChecked = true
////        }
//
////        //tapしたcellにcheckmarkをつける，すでにcheckmarkがついていたら外す
////        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
////            tableView.cellForRow(at: indexPath)?.accessoryType = .none
////        } else {
////            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
////        }
//
//        tableView.reloadData()//切り替えたcheckmarkを表示するために再描画
//
//        //cellをtapして選択した後，選択されてない状態にする＝tapしたら灰色になり，すぐ元に戻る
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    //MARK: - Add New Item
//    //nav barのaddbuttonをtapしたときに，itemを追加するpopupを表示
//    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
//        var textField = UITextField()
//
//        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
//
//        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
//            //What will happen once the user clicks the Add Item button on our UIAlert
//
//            var newItem = Item()
//            newItem.title = textField.text!
//
//            //このブロックはcompletion handlerなので，"Add Item"が押された後に発火する
//            self.itemArray.append(newItem)//今の状態だとtextが空の時に""が追加される（textが空の時にvalidationを後でつける)
//
//            self.defaults.set(self.itemArray, forKey: K.todoArrayName)
//
//            self.tableView.reloadData()
//            print("Success!")
//        }
//
//        alert.addTextField { (alertTextField) in
//            alertTextField.placeholder = "Create new items"
//            textField = alertTextField//alertTextFieldはこのblock内でしか扱えないので，扱える範囲を広げるためにtextFieldに代入
//        }
//
//        alert.addAction(action)
//
//        present(alert, animated: true, completion: nil)
//    }
//
//}
//
