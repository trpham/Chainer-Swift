//
//  ContractsViewController.swift
//  Chainer
//
//  Created by nathan on 10/21/17.
//  Copyright © 2017 Chainer. All rights reserved.
//

import UIKit
import Alamofire

class ContractsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndexPath: IndexPath?
    
    var validated:Bool = false
    
    var contracts: [[String: Any]] = []
    var users: [[String: String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        getContracts()
        getUsers()
    }
    
    func getContracts() {
        Alamofire.request("http://localhost:3000/api/contracts").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: response.data!,
                                                               options: .allowFragments) as? NSDictionary {

                
                if let userData = jsonObj!.value(forKey: "data") as? NSArray {
                    self.contracts = userData as! [[String : Any]]
                }
                
//                print(self.contracts)
               self.tableView.reloadData()
            }
        }
    }
    
    func getUsers() {
        Alamofire.request("http://localhost:3000/api/users").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: response.data!,
                                                               options: .allowFragments) as? NSDictionary {
                
                
                if let userData = jsonObj!.value(forKey: "data") as? NSArray {
                    self.users = userData as! [[String : String]]
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contracts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContractTableViewCell") as! ContractTableViewCell
        
        if let datas = self.contracts[indexPath.row] as? NSDictionary {
            cell.contractLabel.text = datas.value(forKey: "name") as! String
            cell.contractDescription.text = datas.value(forKey: "description") as! String
            if datas.value(forKey: "validated") as! Bool == true {
                cell.isValidated.isHidden = true
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)! as! ContractTableViewCell
        selectedIndexPath = indexPath
//        globalContract = currentCell.contractLabel.text!
        
        if let datas = self.contracts[indexPath.row] as? NSDictionary {
            globalContract = datas.value(forKey: "id") as! String
            self.validated = datas.value(forKey: "validated") as! Bool
        }
        
        performSegue(withIdentifier: "toTransaction", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toTransaction" {
                if let dest = segue.destination as? TransactionViewController {
                    dest.users = self.users
                    dest.validated = self.validated
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
