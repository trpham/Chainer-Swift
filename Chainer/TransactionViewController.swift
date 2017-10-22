//
//  TransactionViewController.swift
//  Chainer
//
//  Created by nathan on 10/21/17.
//  Copyright © 2017 Chainer. All rights reserved.
//

import UIKit
import Alamofire

class TransactionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sourceButton: UIButton!
    @IBOutlet weak var sourceTableView: UITableView!
    
    @IBOutlet weak var destinationButton: UIButton!
    @IBOutlet weak var destinationTableView: UITableView!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var veriffyButton: UIButton!
    
    var validated:Bool!
    
    var transactions: [Transaction] = []
    
    var users: [[String: String]] = []
    
    var sources: [[String: String]] = []
    var destinations: [[String: String]] = []
    
    var addedTransaction: Transaction!
    
//    sources = ["10", "20", "30"]
//    destinations = ["A", "B", "C"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sourceTableView.dataSource = self
        sourceTableView.delegate = self
        
        destinationTableView.dataSource = self
        destinationTableView.delegate = self
        
        self.sourceTableView.isHidden = true
        self.destinationTableView.isHidden = true
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        sources = users
        destinations = users
        
        if (self.validated == true) {
            self.veriffyButton.setTitle("Validated", for: .normal)
            self.veriffyButton.backgroundColor = UIColor.blue
        }
        else {
            self.veriffyButton.titleLabel?.text = "Validate"
        }
        
        
        
//        self.sourceTableView.estimatedRowHeight = 60
//        self.sourceTableView.rowHeight = UITableViewAutomaticDimension
//
//        self.destinationTableView.estimatedRowHeight = 60
//        self.destinationTableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        insertNewTransaction()
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        
        var transactionsArray:[[String]] = []
        
        var transactionsDictionary:[String:Any] = [:]
        transactionsDictionary["id"] = globalContract
        
        for _transaction in transactions {
            var transaction:[String] = [_transaction.source, _transaction.destination, _transaction.amount]
            transactionsArray.append(transaction)
        }
        
     
        
        transactionsDictionary["transactions"] = transactionsArray
        
        var transactionsDictionaryArray:[[String: Any]] = []
        transactionsDictionaryArray.append(transactionsDictionary)
        
        let submitedPublications = ["id": arc4random(),
                                    "contracts": transactionsDictionaryArray] as [String : Any]
    
        Alamofire.request("http://localhost:3000/api/publications",
                          method:.post,
                          parameters: submitedPublications,
                          encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success:
//                print("1111")
                print(response)
                break
            case .failure(let error):
                print(error)
            }
        }
        
         performSegue(withIdentifier: "toPublications", sender: nil)
    }
    
    func insertNewTransaction() {
        self.addedTransaction = Transaction(source: (sourceButton.titleLabel?.text)!, destination: (destinationButton.titleLabel?.text)!, amount: self.amountTextField.text!)
        self.transactions.append(addedTransaction)
        let indexPath = IndexPath(row: transactions.count - 1, section: 0)
        
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func sourceButtonPressed(_ sender: UIButton) {
        self.sourceTableView.isHidden = !self.sourceTableView.isHidden
    }
    
    @IBAction func destinationButtonPressed(_ sender: UIButton) {
        self.destinationTableView.isHidden = !self.destinationTableView.isHidden
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == sourceTableView {
            return (self.sources.count)
        } else if tableView == destinationTableView {
            return (self.destinations.count)
        }
        else {
            return self.transactions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == sourceTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sourceCell", for: indexPath)
            
            if let datas = self.sources[indexPath.row] as? NSDictionary {
                cell.textLabel?.text = datas.value(forKey: "name") as! String
                cell.textLabel?.textColor = UIColor.black
            }
            return cell
        } else if tableView == destinationTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "destinationCell", for: indexPath)
            if let datas = self.destinations[indexPath.row] as? NSDictionary {
                cell.textLabel?.text = datas.value(forKey: "name") as! String
                cell.textLabel?.textColor = UIColor.black
            }
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionTableViewCell
            if transactions.count > 0 {
       
                cell.transactionIndexLabel.text = "Transaction \(indexPath.row + 1)"
                
                if let sourceText = addedTransaction.source {
                cell.sourceLabel.text =  "Source: \(sourceText)"
                }
                if let destinationText = addedTransaction.destination {
                cell.destinationLabel.text = "Destination: \(destinationText)"
                }
                if let amountText = addedTransaction.amount {
                    cell.amountLabel.text = "Amount: \(amountText)"
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == sourceTableView {
            let cell = tableView.cellForRow(at: indexPath)
            sourceButton.setTitle(cell?.textLabel?.text, for: .normal)
            self.sourceTableView.isHidden = true
//            self.addedTransaction.source = cell?.textLabel?.text
        } else if tableView == destinationTableView {
            let cell = tableView.cellForRow(at: indexPath)
            destinationButton.setTitle(cell?.textLabel?.text, for: .normal)
            self.destinationTableView.isHidden = true
//            self.addedTransaction.destination = cell?.textLabel?.text
        }
        else {
            let cell = tableView.cellForRow(at: indexPath) as! TransactionTableViewCell
            
            if let title = cell.verifyButton.titleLabel?.text {
                if title == "Unverified" {
                    cell.verifyButton.titleLabel?.text = "Verified"
                    cell.verifyButton.backgroundColor = UIColor.blue
                    cell.isUserInteractionEnabled = false
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
