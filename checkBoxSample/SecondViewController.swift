//
//  SecondViewController.swift
//  checkBoxSample
//
//  Created by 齋藤律哉 on 2020/05/31.
//  Copyright © 2020 ritsuya. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource {
    
    
    
    var receivedDatas = [Data]()
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        print(receivedDatas)
        
        tableView.dataSource = self

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        receivedDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = receivedDatas[indexPath.row].title
        return cell!
    }
    


}
