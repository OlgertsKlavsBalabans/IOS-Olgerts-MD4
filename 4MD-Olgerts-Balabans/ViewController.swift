//
//  ViewController.swift
//  4MD-Olgerts-Balabans
//
//  Created by students on 23/05/2020.
//  Copyright © 2020 students. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var ProfilePicture: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var CompanyLabel: UILabel!
    
    @IBOutlet weak var BioLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
        fetchCommitJson()
        //let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        //let documentsDir = paths.firstObject as! String
        //print("Path to the Documents directory\n\(documentsDir)")

        //let url = URL(string: "https://www.apple.com")!


    }
    
    func downloadFile (with url:URL, fileName: String) {
        let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
            
            let destinationFileUrl = documentsUrl.appendingPathComponent(fileName)
            

            //Create URL to the source file you want to download
            let fileURL = url
            
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig)
         
            let request = URLRequest(url:fileURL)
            
            let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
                if let tempLocalUrl = tempLocalUrl, error == nil {
                    // Success
                     
                    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                        print("Successfully downloaded. Status code: \(statusCode)")
                      
                    }
                    
                    do {
                        try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    } catch (let writeError) {
                        print("Error creating a file \(destinationFileUrl) : \(writeError)")
                    }
                    
                } else {
                    print("Error took place while downloading a file. Error description: %@", error?.localizedDescription ?? "");
                }
            }
            task.resume()
    }
    
    func fetchCommitJson() {
        let url = URL(string: "https://api.github.com/repos/ioslekcijas/faili/contents")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
       
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data,response,error) in
            if let data = data {
            let decoder = JSONDecoder()
                 
                if let content = try? decoder.decode(GitContent.self, from: data){
                    DispatchQueue.main.async {

                        self.downloadFilesFromCommitJson(with: content)

                    }
                    
                }
                else {
                    print(error?.localizedDescription ?? "")
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    
    func downloadFilesFromCommitJson(with content: GitContent) {
        for file in content {
            let url = URL(string: file.downloadURL ?? "")!
            downloadFile(with: url, fileName: file.name!)
        }

    }
    
    
    
    func fetchData() {
        let url = URL(string: "https://api.github.com/users/ioslekcijas")
        var urlRequest = URLRequest(url:url!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data,response,error) in
            if let data = data {
            let decoder = JSONDecoder()
                if let gitHubUser = try? decoder.decode(GitHubUser.self, from: data){
                    DispatchQueue.main.async {
                        self.UpdateUserInterface(with: gitHubUser)
                    }
                    
                }
                else {
                    print(error?.localizedDescription ?? "")
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
        
    }
    
    
    
    func UpdateUserInterface(with user: GitHubUser) {
        self.NameLabel.text = user.name
        self.BioLabel.text = user.bio
        self.CompanyLabel.text = user.company
        self.ProfilePicture.downloaded(from: user.avatarURL ?? "https://dummyimage.com/600x400/000/fff&text=Profila+bilde")
        
    }
    

}

