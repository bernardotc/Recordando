//
//  AppDelegate.swift
//  Recordando
//
//  Created by Bernardo Trevino on 10/12/16.
//  Copyright © 2016 bernardo. All rights reserved.
//

import UIKit
import Alamofire

var categorias: [Categoria] = [Categoria(id: -1, nombre: "Todas")]

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private let alamofireManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 60
        
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let parameters: Parameters = [
            "action": "DOWNLOAD_IMAGES"
        ]
        
        alamofireManager.request("http://35.160.114.150/recordando/model.php", method: .post, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .success(let JSON):
                self.loadData(JSON as! NSDictionary)
                break
            case .failure(let error):
                print(error)
            }
        }
        
        setStoryboard()
        return true
    }
    
    func loadData(_ response: NSDictionary) {
        if (response["status"] as? String == "SUCCESS") {
            if let categories = response["categories"] as? [AnyObject] {
                for object in categories {
                    let category = object as! NSDictionary
                    let newCategory = Categoria(id: category["id"] as! Int, nombre: category["categoryName"] as! String)
                    
                    var images: [Imagen] = []
                    
                    for object2 in category["images"] as! [AnyObject] {
                        let image = object2 as! NSDictionary
                        let newImage = Imagen(id: image["id"] as! Int, fileName: image["imageName"] as! String, descripcion: image["description"] as! String)
                        images.append(newImage)
                    }
                    
                    newCategory.imagenes = images
                    categorias.append(newCategory)
                }
            }
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Métodos para cargar varios storyboards
    
    // Elegir el storyboard a desplegar
    func setStoryboard() {
        let storyboard : UIStoryboard = self.grabStoryboard()
        self.setInitialScreen(storyboard)
    }
    
    // Decide el storyboard a usar en base al tamaño de la pantalla
    func grabStoryboard() -> UIStoryboard {
        
        // Obtiene el tamaño
        let screenHeight : Int = Int(UIScreen.main.bounds.size.height)
        
        var storyboard : UIStoryboard
        print(screenHeight)
        
        switch (screenHeight) {
        case 568:
            storyboard = UIStoryboard(name: "Main", bundle: nil)
            break;
            
        case 667:
            storyboard = UIStoryboard(name: "Main", bundle: nil)
            break;
            
        case 736:
            storyboard = UIStoryboard(name: "Main", bundle: nil)
            break;
            
        case 1024:
            storyboard = UIStoryboard(name: "MainiPad", bundle: nil)
            break;
            
        case 1366:
            storyboard = UIStoryboard(name: "MainiPad", bundle: nil)
            break;
            
        default:
            storyboard = UIStoryboard(name: "Main", bundle: nil)
            break
        }
        
        return storyboard
    }
    
    // Decide la pantalla principal de la aplicación.
    // Por ejemplo si el usuario ya había hecho login empieza en cierta pantalla,
    // y si no entonces presenta la pantalla de login
    func setInitialScreen( _ storyboard : UIStoryboard) {
        var initViewController : UIViewController
        
        initViewController = storyboard.instantiateViewController(withIdentifier: "First")
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = initViewController
        self.window?.makeKeyAndVisible()
    }
    
}

