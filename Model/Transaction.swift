//
//  Transaction.swift
//  Chainer
//
//  Created by nathan on 10/21/17.
//  Copyright © 2017 Chainer. All rights reserved.
//

import Foundation

@objc class Transaction: NSObject {
    var source: String!
    var destination: String!
    var amount: String!

    init(source: String, destination: String, amount: String) {
        self.source = source
        self.destination = destination
        self.amount = amount
    }
}

