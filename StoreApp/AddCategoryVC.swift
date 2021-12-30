//
//  AddCategoryVC.swift
//  StoreApp
//
//  Created by Jemi on 25/11/2021.
//

import UIKit

class AddCategoryVC: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBAction func save(_ sender: Any) {
        let txt = textField.text
        if(txt != nil){
            textField.text = ""
            addCategory(name: txt!)
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func addCategory(name:String) {
        let category = Categories(context: context)
        category.name = name
        appDelegate.saveContext()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
