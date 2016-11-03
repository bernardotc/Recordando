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
        
        //let image = UIImage(named: "ios9.jpg")
        let image : NSData = UIImageJPEGRepresentation(imageUserPhoto.image!, 32)! as NSData
        
        let parameters = [
            "pic" : NetData(data: image, mimeType: .ImageJpeg, filename: "customName.jpg"),
            "otherParm": "Value"
        ] as [String : Any]
        
        let urlRequest = self.urlRequestWithComponents(urlString: "http://35.160.114.150/recordando/model.php", parameters: parameters as NSDictionary)
        
        Alamofire.upload(urlRequest.0, data: urlRequest.1)
            .progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                print("\(totalBytesWritten) / \(totalBytesExpectedToWrite)")
            }
            .responseJSON { response in
                debugPrint(response)
        }
    }
    
    
    func urlRequestWithComponents(urlString:String, parameters:NSDictionary) -> (URLRequestConvertible, NSData) {
        
        // create url request to send
        let mutableURLRequest = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
        mutableURLRequest.HTTPMethod = Alamofire.Method.POST.rawValue
        //let boundaryConstant = "myRandomBoundary12345"
        let boundaryConstant = "NET-POST-boundary-\(arc4random())-\(arc4random())"
        let contentType = "multipart/form-data;boundary="+boundaryConstant
        mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        
        // create upload data to send
        let uploadData = NSMutableData()
        
        // add parameters
        for (key, value) in parameters {
            
            uploadData.append("\r\n--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
            
            if value is NetData {
                // add image
                let postData = value as! NetData
            
                let filenameClause = " filename=\"\(postData.filename)\""
                let contentDispositionString = "Content-Disposition: form-data; name=\"\(key)\";\(filenameClause)\r\n"
                let contentDispositionData = contentDispositionString.data(using: String.Encoding.utf8)
                uploadData.append(contentDispositionData!)
                
                let contentTypeString = "Content-Type: \(postData.mimeType.getString())\r\n\r\n"
                let contentTypeData = contentTypeString.data(using: String.Encoding.utf8)
                uploadData.append(contentTypeData!)
                uploadData.append(postData.data as Data)
                
            }else{
                uploadData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".data(using: String.Encoding.utf8)!)
            }
        }
        uploadData.append("\r\n--\(boundaryConstant)--\r\n".data(using: String.Encoding.utf8)!)
        
        
        // return URLRequestConvertible and NSData
        return (Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0, uploadData)
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
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sCategoryTemporal[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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
