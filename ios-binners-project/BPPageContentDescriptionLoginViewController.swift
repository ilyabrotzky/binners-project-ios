//
//  BPPageContentDescriptionLoginViewController.swift
//  ios-binners-project
//
//  Created by Matheus Ruschel on 2/2/16.
//  Copyright © 2016 Rodrigo de Souza Reis. All rights reserved.
//

import UIKit

class BPPageContentDescriptionLoginViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var pageIndex:Int?
    var imageFile:String? 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: imageFile!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
