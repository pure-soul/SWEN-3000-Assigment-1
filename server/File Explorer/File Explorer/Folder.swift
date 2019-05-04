//
//  Folder.swift
//  File Explorer
//
//  Created by Shemar Henry on 01/05/2019.
//  Copyright © 2019 Shemar Henry. All rights reserved.
//

import Foundation

class Folder{
    var folders: [String]
    var files: [File]
    var parent: String
    var name: String
    
    var content: [String]
    
    init(name: String, parent: String, folders: [String], files: [File]){
        self.name = name
        self.parent = parent
        self.files = files
        self.folders = folders
        self.content = folders
        for file in files{
            self.content.append(file.getName())
        }
    }
    
    init(){
        self.name = "-"
        self.parent = "none"
        self.files = []
        self.folders = []
        self.content = []
    }
    
    func getContent() -> [String]{
        return self.content
    }
    
    func getParent(name: String) -> String {
        if name == self.name{
            return self.parent
        }
        return "null"
    }
}
