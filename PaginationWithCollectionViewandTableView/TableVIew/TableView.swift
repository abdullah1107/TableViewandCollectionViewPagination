//
//  TableView.swift
//  PaginationWithCollectionViewandTableView
//
//  Created by Muhammad Abdullah Al Mamun on 11/10/20.
//

import UIKit

class TableView: UIViewController, UITableViewDelegate,UITableViewDataSource{
 
    @IBOutlet weak var tableView: UITableView!

    var itemsArray = [String]()

    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        //Register Item Cell
        let itemCellNib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableView.register(itemCellNib, forCellReuseIdentifier: "tableviewcellid")

        //Register Loading Cell
        let loadingCellNib = UINib(nibName: "LoadingCell", bundle: nil)
        self.tableView.register(loadingCellNib, forCellReuseIdentifier: "loadingcellid")
        
        loadingDataFromServer()
        
        
    }
    
    func loadingDataFromServer(){
        self.isLoading = false
        for i in 0...30 {
            itemsArray.append("Item \(i)")
        }
        self.tableView.reloadData()
    }

   
}

extension TableView{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return itemsArray.count
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcellid", for: indexPath) as! TableViewCell
            cell.itemLabel.text = itemsArray[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingcellid", for: indexPath) as! LoadingCell
            cell.activetyIndecator.startAnimating()
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 44 //Item Cell height
        } else {
            return 55 //Loading Cell height
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
            loadMoreData()
        }
    }
}

extension TableView{
    func loadMoreData() {
        if  self.isLoading == false {
            self.isLoading = true
            let start = itemsArray.count
            let end = start + 10
            DispatchQueue.global().async {
                // fake background loading task
                sleep(2)
                for i in start...end {
                    self.itemsArray.append("Item \(i)")
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
}
