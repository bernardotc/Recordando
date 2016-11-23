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
        return categorias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Get reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategorySettingsTableViewCell
        
        // Set cell category and name
        cell.category = categorias[indexPath.row]
        cell.lblCategoryName.text = categorias[indexPath.row].nombre
        
        // If the category of cell is set to be used, show it here.
        if cell.category.usar {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Take into account that is the state before a touch.
        // Special case, because it involves all categories.
        if indexPath.row == 0 {
            // If it is true, change all categories to false
            if categorias[0].usar {
                for index in 0..<categorias.count {
                    categorias[index].usar = false
                }
            // If it is false, change all categories to true
            } else {
                for index in 0..<categorias.count {
                    categorias[index].usar = true
                }
            }
        } else if !categorias[0].usar {
            // Change the boolean value of the category
            categorias[indexPath.row].usar = !categorias[indexPath.row].usar
            
            // Validation to know if all the categories are selected, then the category 0 that is "all" needs to be selected
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
