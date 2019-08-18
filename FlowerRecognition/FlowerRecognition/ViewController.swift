//
//  ViewController.swift
//  FlowerRecognition
//
//  Created by cex on 19/08/19.
//  Copyright © 2019 cex. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    let imagePickerInstance = UIImagePickerController();
    @IBAction func CameraButtonTapped(_ sender: Any) {
        
        imagePickerInstance.sourceType = .photoLibrary;
        imagePickerInstance.allowsEditing = false;
        present(imagePickerInstance,animated:true,completion:nil);
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if  let imageData = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
      {
        imageView.image = imageData;
        }
        imagePickerInstance.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePickerInstance.delegate = self;
        
    }


}

