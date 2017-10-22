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

    @IBOutlet weak var authorizationID: UILabel!
    @IBOutlet weak var isVerified: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getPublications()
        
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
                
                if let datas = jsonObj!.value(forKey: "data") as? NSArray {
                    
                    print(datas)
                    
                    var AuthorizeArray = datas.value(forKey: "authorization") as! NSArray
                    self.authorizationID.text = AuthorizeArray[0] as! String
                }
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
