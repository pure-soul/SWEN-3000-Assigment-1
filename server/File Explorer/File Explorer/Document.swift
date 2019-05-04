//
//  Document.swift
//  File Explorer
//
//  Created by Shemar Henry on 29/04/2019.
//  Copyright © 2019 Shemar Henry. All rights reserved.
//

import UIKit

struct Location: Decodable{
    let folders: [String]
    let files: [String]
    let current: String
    let parent: String
    }

class Document: UIDocument {
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
    }
    
    func fetchFolder(urlString: String) -> Folder {
        var folder: Folder
        folder = Folder()
        guard let getURL = URL(string: urlString) else {return folder}
        URLSession.shared.dataTask(with: getURL) {(data, response, err) in
            //check error and response status
            var files: [File] = []
            var folders: [String] = []
            guard let data = data else {return}
//            let dataAsString = String(data: data, encoding: .utf8)
//            print (dataAsString!)
            do{
                let location = try JSONDecoder().decode(Location.self, from: data)
                for fil in location.files {
                    let file = File(name: fil, parent: location.current)
                    files.append(file)
                }
                for fold in location.folders {
                    folders.append(fold)
                }
                folder = Folder(name: location.current, parent: location.parent, folders: folders, files: files)
            }
            catch{print(error)}
        }.resume()
        return folder
    }// Load your documents from URL
    
    func postJSON(postURL: URL , jsonData: Data){
        var request = URLRequest(url: postURL)
        request.httpMethod = "POST"
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
    }
    
}

