//
//  ImageCollectionViewController.swift
//  4MD-Olgerts-Balabans
//
//  Created by students on 01/06/2020.
//  Copyright © 2020 students. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ImageCollectionViewController: UICollectionViewController {

    @IBOutlet weak var ItemList: UITableView!
    var itemCount = 0
    var itemList: Array<URL> = []
    let allowedExtensions = ["jpg","png","gif"]
    var selectedItem: URL = URL(fileURLWithPath: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForDocuments();
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return itemList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        
         let imageView = UIImageView()
         imageView.frame = CGRect(x:0, y:0, width:200, height:200)
         do {
             let imageData = try Data(contentsOf: itemList[indexPath.row])
             imageView.image =  UIImage(data: imageData)
         } catch {
             print("Error loading image : \(error)")
         }
        cell.addSubview(imageView);
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = itemList[indexPath.row]
        performSegue(withIdentifier: "imageDetailSegue", sender: self)
    }
//    func collectionView(collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
//    {
//
//        return CGSize(width: 500, height: 500)
//    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageDetailSegue" {
            let detailsViewControler = segue.destination as! PhotoDetailViewController
            detailsViewControler.fileUrl = selectedItem
        }
    }
}
