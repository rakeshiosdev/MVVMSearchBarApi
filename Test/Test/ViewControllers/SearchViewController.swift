//
//  SearchViewController.swift
//  Test
//
//  Created by RakeshPC on 25/06/19.
//  Copyright © 2019 RakeshPC. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var testTableView: UITableView!
    let cellIdentifire = "TestCell"
    var arrayUsersModel = [UserModelView]()
    var filtered = [UserModelView]()
    
    var searchActive : Bool = false
    lazy var mySearchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 400, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserinfo()
        setupSearchBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.05882352941, green: 0.1960784314, blue: 0.2745098039, alpha: 1)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
}

//MARK: Call API for user data
extension SearchViewController {
    
    fileprivate func getUserinfo() {
        ServiceManager.shared.getUesrData { (users, error) in
            if error == nil {
                self.arrayUsersModel = users?.map({return UserModelView(uesrs: $0)}) ?? []
                DispatchQueue.main.async {
                    self.testTableView.delegate = self
                    self.testTableView.dataSource = self
                    self.testTableView.reloadData()
                    self.mySearchBar.delegate = self
                }
            }
        }
    }
}

//MARK: SearchBar Setup
extension SearchViewController: UISearchBarDelegate {
    
    fileprivate func setupSearchBar(){
        mySearchBar.placeholder = "Search here"
        mySearchBar.setShowsCancelButton(true, animated: true)
        mySearchBar.setImage(UIImage(named: "clear_icon"), for: .clear, state: .normal)
        mySearchBar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let textFieldInsideSearchBar = mySearchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textFieldInsideSearchBar?.backgroundColor = #colorLiteral(red: 0.1613149941, green: 0.2753259242, blue: 0.3372325301, alpha: 1)
        
        let leftNavBarButton = UIBarButtonItem(customView:mySearchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
    }
    
}


//MARK: SearchBar Delegate
extension SearchViewController {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = self.arrayUsersModel.filter({ (text: UserModelView) -> Bool in
            let tmp: NSString = text.title! as NSString
            let range = tmp.range(of: searchText, options: .caseInsensitive)
            return range.location != NSNotFound
        })
        
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.testTableView.reloadData()
    }
}


//MARK: UItableView Delegate and DataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return arrayUsersModel.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TestTableViewCell =  testTableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as! TestTableViewCell
        
        if(searchActive) {
            let userDict = filtered[indexPath.row]
            cell.titleLabel.text = userDict.title
            cell.bodyLabel.text = userDict.body
        }else{
            let userDict = arrayUsersModel[indexPath.row]
            cell.titleLabel.text = userDict.title
            cell.bodyLabel.text = userDict.body
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objeDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self.navigationController?.pushViewController(objeDetailVC, animated: true)
    }
}

