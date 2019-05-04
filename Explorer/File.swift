//
//  File.swift
//  Explorer
//
//  Created by Shemar Henry on 02/05/2019.
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
