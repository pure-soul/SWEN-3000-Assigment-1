//
//  Folder.swift
//  Explorer
//
//  Created by Shemar Henry on 02/05/2019.
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
        self.parent = "-"
        self.files = []
        self.folders = []
        self.content = []
    }
    
    func getContent() -> [String]{
        return self.content
    }
    
    func setContent() -> [String]{
        self.content = folders
        for file in files{
            self.content.append(file.getName())
        }
        return self.content
    }
    
    func getParent() -> String {
        return self.parent
    }
    
    func setName(name: String){
        self.name = name
    }
    
    func setParent(parent: String){
        self.parent = parent
    }
    
    func setFiles(files: [File]){
        self.files = files
    }
    func setFolders(folders: [String]){
        self.folders = folders
    }
}
