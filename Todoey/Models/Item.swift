//
//  Item.swift
//  Todoey
//
//  Created by Patricio Soto on 3/4/19.
//  Copyright © 2019 Patricio Soto. All rights reserved.
//

import Foundation

class Item: Encodable , Decodable{
    var title : String = ""
    var done  : Bool   = false
}
