//
//  UploadViewController.swift
//  Recordando
//
//  Created by Bernardo Trevino on 11/2/16.
//  Copyright © 2016 bernardo. All rights reserved.
//

import UIKit
import Alamofire

class UploadViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var imageUserPhoto: UIImageView!
    @IBOutlet weak var pickerCategory: UIPickerView!
    @IBOutlet weak var textDescription: UITextView!
    
    var currentPickerText: String = ""
    
    var sCategoryTemporal: [String] = ["Música de Época", "Objetos de Época", "Juguetes", "Comerciales", "Hechos Históricos", "Monumentos Mexicanos", "Arte", "Cinematografía", "Comida Mexicana", "Paisaje"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pickerCategory.delegate = self
        self.pickerCategory.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Alamofire Upload Functions
    @IBAction func choosePhoto(sender: AnyObject) {
        
        pickPhoto(sender: sender)
    }
    
    @IBAction func uploadBtn(sender: AnyObject) {
        
        let sCategorySelected: String = sCategoryTemporal[pickerCategory.selectedRow(inComponent: 0)]
        
        let imageSelected: UIImage = imageUserPhoto.image!
        let imageData = UIImageJPEGRepresentation(imageSelected, 0.9)
        let base64String = imageData?.base64EncodedString() // encode the image

        let sUserDescription = textDescription.text
        
        let parameters: Parameters = [
            "category": sCategorySelected,
            "action": "UPLOAD_IMAGE",
            "image": base64String,
            "description": sUserDescription
        ]
        
        Alamofire.request("35.160.114.150/recordando/controller.php", method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            
        }

    }
    
    
    
    //MARK: - Camera and Gallery
    
    func pickPhoto(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            showPhotoMenu(sender: sender)
        } else {
            choosePhotoFromLibrary()
        }
    }
    
    func takePhotoWithCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func choosePhotoFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func showPhotoMenu(sender: AnyObject) {
    
        let alertController = UIAlertController(title: nil, message: nil,preferredStyle: .actionSheet)
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
        alertController.addAction(cancelAction)
    
        let takePhotoAction = UIAlertAction(title: "Take Photo",style: .default, handler: { _ in self.takePhotoWithCamera()})
    
        alertController.addAction(takePhotoAction)
    
        let chooseFromLibraryAction = UIAlertAction(title:"Choose From Library", style: .default, handler:{ _ in self.choosePhotoFromLibrary()})
    
        alertController.addAction(chooseFromLibraryAction)
    
        present(alertController, animated: true, completion: nil)
    }

    
    
    // MARK: - Picker Control Functions
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sCategoryTemporal.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sCategoryTemporal[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
