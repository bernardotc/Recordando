//
//  SettingsViewController.swift
//  Recordando
//
//  Created by Bernardo Trevino on 11/2/16.
//  Copyright © 2016 bernardo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*DispatchQueue.main.async(execute: { tableView.reloadData() })*/
        return categorias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategorySettingsTableViewCell
        
        cell.category = categorias[indexPath.row]
        cell.lblCategoryName.text = categorias[indexPath.row].nombre
        if cell.category.usar {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if categorias[0].usar {
                print ("hola")
                for index in 0..<categorias.count {
                    categorias[index].usar = false
                }
            } else {
                print ("false")
                for index in 0..<categorias.count {
                    categorias[index].usar = true
                }
            }
        } else if !categorias[0].usar {
            print ("adios")
            categorias[indexPath.row].usar = !categorias[indexPath.row].usar
            var all = true
            for index in 1..<categorias.count {
                if (!categorias[index].usar) {
                    all = false
                    break
                }
            }
            if (all) {
                categorias[0].usar = true
            }
        }
        
        tableView.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    }
    */
}
