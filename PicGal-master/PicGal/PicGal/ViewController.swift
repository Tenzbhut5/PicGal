//
//  ViewController.swift
//  PicGal
//
//  Created by Izabella Lizarazo on 7/27/18.
//  Copyright © 2018 Izabella Lizarazo. All rights reserved.
//

import UIKit

import CoreImage

class ViewController: UIViewController, UINavigationControllerDelegate,
UIImagePickerControllerDelegate{
    
    
    func saveImage(imagename: String) {
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,true)[0] as NSString).appendingPathComponent(imagename)
        
        let image = FirstImage.image!
        let imageData = UIImagePNGRepresentation(image)
        fileManager.createFile(atPath: imagePath as String, contents: imageData, attributes: nil)
    }

    var imagePickerController: UIImagePickerController!
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePickerController.dismiss(animated: true, completion: nil)
        FirstImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
}
    @IBAction func Filter(_ sender: Any) {
        let context = CIContext()
        let filter = CIFilter(name: "CISepiaTone")!
        filter.setValue(0.8, forKey: kCIInputIntensityKey)
        let image = CIImage(image: FirstImage.image!)
        filter.setValue(image, forKey: kCIInputImageKey)
        let result = filter.outputImage!
        let cgImage = context.createCGImage(result, from: result.extent)
        
        let filteredImage = UIImage(cgImage: cgImage!)
        let newImage = UIImage(cgImage: (filteredImage.cgImage!), scale: (filteredImage.scale),
                               orientation: .right)
        FirstImage.image = newImage
        
        let filter2 = CIFilter(name: "CICMYKHalftone")!
        filter2.setValue(image, forKey: kCIInputImageKey)
        filter2.setValue(25, forKey: kCIInputWidthKey)
        
    }
    
    @IBOutlet weak var FirstImage: UIImageView!
    
    @IBAction func TakePhoto(_ sender: Any) {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func SavePhoto(_ sender: Any) {
        saveImage(imagename:"test.png")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
}
