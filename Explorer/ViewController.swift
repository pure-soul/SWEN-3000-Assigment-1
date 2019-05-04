//
//  ViewController.swift
//  Explorer
//
//  Created by Shemar Henry on 02/05/2019.
//  Copyright © 2019 Shemar Henry. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let rootUrl: String = "http://127.0.0.1:8000/?folder="
    var contain: [String] = ["container"]
    var AllFolders: [String] = ["~"]
    
    struct Location: Decodable{
        let folders: [String]
        let files: [String]
        let current: String
        let parent: String
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contain.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "content")
        let content = self.contain[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "content", for: indexPath as IndexPath)
        cell.textLabel?.text = self.contain[indexPath.row]
        print(cell)// for test (not printed)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")//for test
//        self.tableView.setEditing(true, animated: true)
        self.contain = fetchFolder(urlString: rootUrl).getContent()
        print(self.contain)//for test (not printed)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func fetchFolderURL(str: String) -> String {
        return self.rootUrl + "/" + str
    }
    
    func goBack() -> String{
        return fetchFolderURL(str: "..")
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
            let dataAsString = String(data: data, encoding: .utf8)
            print (dataAsString!)//for test
            do{
                let location = try JSONDecoder().decode(Location.self, from: data)
                print(location)//for test
                for fil in location.files {
                    let file = File(name: fil, parent: location.current)
                    files.append(file)
                }
                print(files.count)//for test
                for fold in location.folders {
                    self.AllFolders.append(fold)
                    folders.append(fold)
                }
                print(folders.count)//for test
                folder.setName(name: location.current)
                folder.setParent(parent: location.parent)
                folder.setFolders(folders: folders)
                folder.setFiles(files: files)
                print(folder.getParent())//for test
                self.AllFolders.append(location.current)
                print(self.AllFolders)//for test
                self.contain = folder.setContent()
                print(self.contain.count)//for test
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

