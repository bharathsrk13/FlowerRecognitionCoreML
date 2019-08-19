//
//  ViewController.swift
//  FlowerRecognition
//
//  Created by cex on 19/08/19.
//  Copyright © 2019 cex. All rights reserved.
//

import UIKit
import Vision
import CoreML

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    let imagePickerInstance = UIImagePickerController();
    @IBAction func CameraButtonTapped(_ sender: Any) {
        
        imagePickerInstance.sourceType = .camera;
        imagePickerInstance.allowsEditing = false;
        present(imagePickerInstance,animated:true,completion:nil);
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if  let imageData = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
      {
        guard let ciImageData = CIImage(image: imageData)
            else{
                fatalError("cannot convert image to ci image");
        }
        
        imageView.image = imageData;
        processImage(ciimageParam: ciImageData);
        }
    
        imagePickerInstance.dismiss(animated: true, completion: nil)
    }
    func processImage(ciimageParam : CIImage)
    {
    
       guard let model = try? VNCoreMLModel(for: FlowerClassifier().model)
        else{
            fatalError("failed to import model");
        }
        let request = VNCoreMLRequest(model: model) { (success, error) in
          
            
            print ("gomma \(success.results?.first as! VNClassificationObservation )");
            let t = success.results?.first as! VNClassificationObservation ;
            self.navigationItem.title = t.identifier;//success.results?.first. as! String;
            
        }
    
    
        let handler = VNImageRequestHandler(ciImage: ciimageParam)//, options: [VNImageOptio])
    do
      {
        try handler.perform([request]);
        }
    catch{
        fatalError("failed to send vision request");
        }
        
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePickerInstance.delegate = self;
        
    }


}

