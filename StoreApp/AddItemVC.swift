//
//  AddItemVC.swift
//  StoreApp
//
//  Created by Jemi on 25/11/2021.
//

import UIKit
import CoreData

class AddItemVC: UIViewController {
    
    var selectedCategory:String?
    var imagePicker = UIImagePickerController()
    var categories = [Categories]()
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func onImageTap(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        addItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        imagePicker.delegate = self
        getCategories()
    }

    private func getCategories() {
        let fetchRequest:NSFetchRequest<Categories> = Categories.fetchRequest()
        do {
            self.categories = try context.fetch(fetchRequest)
        } catch {
            print("Error Fetching Categories!")
        }
    }
    
    private func addItem() {
        let title = self.textField.text
        if(title != nil) {
            let newItem = Items(context: context)
            newItem.name = title
            newItem.date_add = NSDate() as Date
            newItem.image = image.image
            newItem.toCategory = categories[pickerView.selectedRow(inComponent: 0)]
            appDelegate.saveContext()
            dismiss(animated: true, completion: nil)
        }
    }
    
}

extension AddItemVC : UIPickerViewDelegate , UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].name
    }
    
    
}

extension AddItemVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
                    fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
                }
        self.image.image = image
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
