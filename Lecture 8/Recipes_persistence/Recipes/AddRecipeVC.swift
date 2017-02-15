//
//  RecipeEditingVC.swift
//  Recipes
//
//  Created by Anastasiia Soboleva on 15/02/2017.
//  Copyright © 2017 Artemiy Sobolev. All rights reserved.
//

import UIKit


class AddRecipeVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var recipe: Recipe?
    
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var nameTextFeld: UITextField!
    
    @IBAction func nameDidChange(_ sender: UITextField) {
        if let name = sender.text, let image = UIImage(named: name) {
            previewImage.image = image
        } else {
            previewImage.image = #imageLiteral(resourceName: "meal")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewImage.image = #imageLiteral(resourceName: "meal")
        
        typePicker.dataSource = self
        typePicker.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let name = nameTextFeld.text
        let type = Recipe.FoodType.type(with: typePicker.selectedRow(inComponent: 0))
        recipe = Recipe(name: name, type: type)
    }
    
    //MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Recipe.FoodType.allElements.count
    }
    
    //MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Recipe.FoodType.allElements[row].rawValue
    }
    
}

extension Recipe.FoodType {
    
    static func type(with index: Int) -> Recipe.FoodType? {
        switch index {
        case 0: return .main
        case 1: return .desert
        case 2: return .soup
        default: return nil
        }
    }
    
    static var allElements: [Recipe.FoodType] {
        return [.main, .desert, .soup]
    }

}

extension Recipe {
    
    convenience init?(name: String?, type: FoodType?) {
        guard let name = name, name != "", let type = type else {
            return nil
        }
        self.init(named: name, foodType: type)
    }
}
