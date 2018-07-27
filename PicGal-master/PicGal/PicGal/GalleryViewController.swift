//
//  GalleryViewController.swift
//  PicGal
//
//  Created by Izabella Lizarazo on 7/27/18.
//  Copyright © 2018 Izabella Lizarazo. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var SecondImage: UIImageView!
    
    func getImage(imagename:String) {
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,true)[0] as NSString).appendingPathComponent(imagename)
        if fileManager.fileExists(atPath: imagePath) {
            // SecondImage.image = UIImage(contentsOfFile: imagePath)
            let image = UIImage(contentsOfFile: imagePath)
            let newImage = UIImage(cgImage: (image?.cgImage!)!, scale: (image?.scale)!, orientation: .right)
            SecondImage.image = newImage
        } else {
            print("Oh no! No Image!")
        }
    }

override func viewDidLoad() {
    super.viewDidLoad()
    getImage(imagename: "test.png")
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}
}
