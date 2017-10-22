//
//  InitializeUserViewController.swift
//  Chainer
//
//  Created by nathan on 10/21/17.
//  Copyright © 2017 Chainer. All rights reserved.
//

import UIKit
import FlatUIKit

class InitializeUserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onNextStep(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toContractsView", sender: nil)
    }
//    @IBOutlet weak var onNextStep: FUIButton!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
