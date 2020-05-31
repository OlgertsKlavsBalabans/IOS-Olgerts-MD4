//
//  DocumentsDetailsViewController.swift
//  4MD-Olgerts-Balabans
//
//  Created by students on 27/05/2020.
//  Copyright © 2020 students. All rights reserved.
//

import UIKit
import WebKit

class DocumentsDetailsViewController: UIViewController {

    @IBOutlet weak var documentViewer: WKWebView!
    
    var fileUrl: URL = URL(fileURLWithPath: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        documentViewer.loadFileURL(fileUrl, allowingReadAccessTo: fileUrl)
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
