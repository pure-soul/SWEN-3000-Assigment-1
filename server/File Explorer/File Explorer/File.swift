//
//  File.swift
//  File Explorer
//
//  Created by Shemar Henry on 29/04/2019.
//  Copyright © 2019 Shemar Henry. All rights reserved.
//

import Foundation

class File{
    var parent: String
    var name: String
    
    init(name: String, parent: String){
        self.name = name
        self.parent = parent
    }
    
    func getName() -> String {
        return self.name
    }
}
