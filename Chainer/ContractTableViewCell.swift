//
//  ContractTableViewCell.swift
//  Chainer
//
//  Created by nathan on 10/21/17.
//  Copyright © 2017 Chainer. All rights reserved.
//

import UIKit

class ContractTableViewCell: UITableViewCell {

    @IBOutlet weak var contractLabel: UILabel!
    @IBOutlet weak var contractDescription: UILabel!
    @IBOutlet weak var isValidated: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
