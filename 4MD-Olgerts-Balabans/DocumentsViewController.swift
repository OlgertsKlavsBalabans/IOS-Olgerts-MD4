//
//  DocumentsViewController.swift
//  4MD-Olgerts-Balabans
//
//  Created by students on 25/05/2020.
//  Copyright © 2020 students. All rights reserved.
//

import UIKit


class DocumentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    


    @IBOutlet weak var ItemList: UITableView!
    var itemCount = 0
    var itemList: Array<URL> = []
    let allowedExtensions = ["pdf","docx","exls","ppt"]
    var selectedItem: URL = URL(fileURLWithPath: "")
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        checkForDocuments()
        
        ItemList.delegate = self
        ItemList.dataSource = self
        
        
      
        
        
    }
    
    func checkForDocuments() {
        let fileManager = FileManager.default
               let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
               do {
                   let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
                   // process files
                   for file in fileURLs {
                    if allowedExtensions.contains(file.pathExtension)  {

                        addUrlToList(with: file)
                           //print(file.lastPathComponent)
                       }
                       
                   }
                   
               } catch {
                   print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
               }
    }
    
    func addUrlToList(with url:URL) {
        itemList.append(url)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let label = UILabel(frame: CGRect(x:0, y:0, width:500, height:50))
        label.text = itemList[indexPath.row].lastPathComponent
        cell.addSubview(label)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = itemList[indexPath.row]
        performSegue(withIdentifier: "DocumentsDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DocumentsDetailSegue" {
            let detailsViewControler = segue.destination as! DocumentsDetailsViewController
            detailsViewControler.fileUrl = selectedItem
        }
    }
    
    

}
