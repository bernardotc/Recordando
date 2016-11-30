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
    
    let picker = UIImagePickerController()
    
    var currentPickerText: String = ""
    var bFotoSelected: Bool = false;
    
    var sCategoryTemporal: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        self.pickerCategory.delegate = self
        self.pickerCategory.dataSource = self
        
        // Set all categories' name to a temporal array
        for category in categorias {
            if category.nombre != "Todas" {
                sCategoryTemporal.append(category.nombre!)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    // Remove Keyboard
    @IBAction func removeKeyboard(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Alamofire Upload Functions
    
    @IBAction func uploadBtn(sender: AnyObject) {
        
        let iCategorySelected: Int = pickerCategory.selectedRow(inComponent: 0) + 1
        
        // Get image
        let imageSelected: UIImage = imageUserPhoto.image!
        // Compress image data
        let imageData = UIImageJPEGRepresentation(imageSelected, 0.9)
        let base64String = imageData!.base64EncodedString() // encode the image
        
        let sUserDescription = textDescription.text!
        
        // Alert when some data is missing
        if sUserDescription == "" || bFotoSelected == false {
            let alert = UIAlertController(title: "Atención", message: "Favor de cargar todos los datos.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Continuar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
        // All data is complete for upload
        else {
            // Set upload parametes for alamofire
            let parameters: Parameters = [
                "category": iCategorySelected,
                "action": "UPLOAD_IMAGE",
                "image": base64String,
                "description": sUserDescription
            ]
            
            // Start request
            Alamofire.request("http://35.160.114.150/recordando/model.php", method: .post, parameters: parameters).validate().responseJSON { response in
                switch response.result {
                // If the image was uploaded succesfully
                case .success(_):
                    let alert = UIAlertController(title: "Éxito", message: "Imagen cargada con exitosamente.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Continuar", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    break
                // If there was an error in the upload.
                case .failure(_):
                    let alert = UIAlertController(title: "Error", message: "La imagen no pudo ser cargada.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Continuar", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    break
                }
            }
        }
        
    }
    
    // Helper method to alert that there is no camera.
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    //MARK: - Camera and Gallery
    // Access photo library
    @IBAction func pickPhoto(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            showPhotoMenu(sender: sender)
        } else {
            photofromLibrary()
        }
    }
    
    // Take picture
    func shootPhoto(){
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerControllerSourceType.camera
        picker.cameraCaptureMode = .photo
        picker.modalPresentationStyle = .fullScreen
        present(picker,animated: true,completion: nil)
    }
    
    // When you select photo, this menu will appear with the following options
    func showPhotoMenu(sender: AnyObject) {
        
        let alertController = UIAlertController(title: nil, message: nil,preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        let takePhotoAction = UIAlertAction(title: "Take Photo",style: .default, handler: { _ in self.shootPhoto()})
        
        alertController.addAction(takePhotoAction)
        
        let chooseFromLibraryAction = UIAlertAction(title:"Choose From Library", style: .default, handler:{ _ in self.photofromLibrary()})
        
        alertController.addAction(chooseFromLibraryAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    // Shows the library of photos in the device
    func photofromLibrary() {
        
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
        bFotoSelected = true;
    }
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        imageUserPhoto.contentMode = .scaleAspectFit //3
        imageUserPhoto.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
        bFotoSelected = true;
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
