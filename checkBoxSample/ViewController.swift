//
//  ViewController.swift
//  checkBoxSample
//
//  Created by 齋藤律哉 on 2020/05/31.
//  Copyright © 2020 ritsuya. All rights reserved.
//

import UIKit
import BEMCheckBox

class ViewController: UIViewController,UITableViewDataSource {
    
    
   
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var textField: UITextField!
    

    //一つひとつがData型の配列を用意
    var datas = [Data]()
    
    // 値渡し用の定義
    var selectedDatas = [Data]()
    
    var number: Int = 0
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        
        //カスタムセルの定義
        let nib = UINib(nibName: "CustomTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        
        tableView.rowHeight = 100
        
        // tableViewに表示するためのdatasを生成
        createData()
    }
    
    
    
    func createData() {
        // インスタンスを生成、Dataの引数はイニシャライザといわれるもの
        let data1 = Data(title: "りんご", selected: false, number:0)
        let data2 = Data(title: "ごりら", selected: false, number:0)
        let data3 = Data(title: "ラッパ", selected: false, number:0)
        
        //これをtableViewに表示したい
        datas = [data1,data2,data3]
        // tableViewDatasourceをもう一度読み込む
        tableView.reloadData()
    }
    
    // 画面遷移のときの関数
    @IBAction func selectedButton() {
        
        // 受け渡し用の配列を一度初期化
        selectedDatas = [Data]()
        
        // datasの中でselectedがtrueのものすなわち選ばれたものだけをselectedDataに格納
        for i in datas {
            if i.selected == true {
                selectedDatas.append(i)
            } else {
                //選択されてない
            }
        }
        
        // selectedDataは順番がバラバラなので、sortedを使って選ばれた順番にかえる
        //参考記事→https://program-life.com/692
        
        selectedDatas = selectedDatas.sorted(by: { (a, b) -> Bool in
            return a.number < b.number
        })
        
        //値渡しのためのコード
        performSegue(withIdentifier: "toSecond", sender: nil)
    }
    
    //　値渡しのためのコード
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecond" {
            let nextVC = segue.destination as! SecondViewController
            nextVC.receivedDatas = selectedDatas
        }
    }

    //DataSourceメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datas.count
    }
    
     //DataSourceメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
        cell.sampleLabel.text = datas[indexPath.row].title
        
        // checkBox
        cell.checkBox.tag = indexPath.row
        cell.checkBox.delegate = self
        //初期状態含めcheckされている時はcheck表示、checkされていないときはfalseを表示
        if datas[indexPath.row].selected == true {
            cell.checkBox.on = true
        } else {
            cell.checkBox.on = false
        }
        
        // cellに選ばれた順番の数を表示
        if datas[indexPath.row].number != 0 {
            cell.countLabel.text = String(datas[indexPath.row].number)
        } else {
            cell.countLabel.text = "0"
        }
        
      
        
        return cell
    }

}


extension ViewController: BEMCheckBoxDelegate {
    // checkBoxがタップされたら呼ばれるコード、おされたらselectedを切り替える
    func didTap(_ checkBox: BEMCheckBox) {
        
        if checkBox.on == true {
            number += 1
            datas[checkBox.tag].selected = true
            datas[checkBox.tag].number = number
            print("-----")
            print(datas[0].number)
            print(datas[1].number)
            print(datas[2].number)
        } else {
            datas[checkBox.tag].selected = false
            // 消すnumberより大きい数字のものは1低くなる
            for i in datas {
                if i.number > datas[checkBox.tag].number {
                    i.number -= 1
                } else {
                    
                }
            }
            
            // 選択解除されたらnumberは0
            datas[checkBox.tag].number = 0
            number -= 1
            print("-----")
            print(datas[0].number)
            print(datas[1].number)
            print(datas[2].number)
        }
        
        tableView.reloadData()
    }
}

