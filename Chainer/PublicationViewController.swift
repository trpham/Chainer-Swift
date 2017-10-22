//
//  PublicationViewController.swift
//  Chainer
//
//  Created by nathan on 10/22/17.
//  Copyright © 2017 Chainer. All rights reserved.
//

import UIKit
import Alamofire

class PublicationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getPublications()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getPublications() {
        Alamofire.request("http://localhost:3000/api/publications").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: response.data!,
                                                               options: .allowFragments) as? NSDictionary {
                
                
//                if let userData = jsonObj!.value(forKey: "data") as? NSArray {
//                    self.contracts = userData as! [[String : Any]]
//                }
//
//                //                print(self.contracts)
//                self.tableView.reloadData()
            }
        }
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
