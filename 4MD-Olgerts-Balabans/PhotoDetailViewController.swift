//
//  PhotoDetailViewController.swift
//  4MD-Olgerts-Balabans
//
//  Created by students on 27/05/2020.
//  Copyright © 2020 students. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var fileUrl: URL = URL(fileURLWithPath: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let imageData = try Data(contentsOf: fileUrl)
            imageView.image =  UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        
            
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
