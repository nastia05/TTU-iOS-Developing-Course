//
//  RecipesTVC.swift
//  Recipes
//
//  Created by Artemiy Sobolev on 08/02/2017.
//  Copyright © 2017 Artemiy Sobolev. All rights reserved.
//

import UIKit

final
class RecipeViewCell: UITableViewCell {
    
    @IBOutlet weak var preview: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var starredButton: UIButton!
    
    var recipe: Recipe! {
        didSet {
            nameLabel.text = recipe.name
            preview.image = recipe.image
            descriptionLabel.text = recipe.description
            updateStarButton()
        }
    }
    
    func updateStarButton() {
        let image = recipe.starred ? #imageLiteral(resourceName: "star") : #imageLiteral(resourceName: "star_disabled")
        starredButton.setImage(image, for: .normal)
    }
    
    @IBAction func starButtonPressed(_ sender: UIButton) {
        
        recipe.starred = !recipe.starred
        updateStarButton()

    }
}

final
class RecipesTVC: UITableViewController {
    static private let recipesSID = "RecipeSID"

    var recipes = [Recipe(named: "omelette"), Recipe(named:"pelmeni"), Recipe(named: "borsh", foodType: .soup)]
    
    var types: [Recipe.FoodType] {
        return Array(Set(recipes.map({ $0.type })))
    }
    
    func recipes(for type: Recipe.FoodType) -> [Recipe] {
        return recipes.filter { $0.type == type }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return types.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes(for: types[section]).count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return types[section].rawValue
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: RecipesTVC.recipesSID)!
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let recipesForGivenSection = recipes(for: types[indexPath.section])
        (cell as! RecipeViewCell).recipe = recipesForGivenSection[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else {
            return
        }
        
        recipes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let recipe = (sender as! RecipeViewCell).recipe
        
        segue.destination.title = recipe?.name
        
    }
    
}

extension Recipe {
    
    var image: UIImage {
        return UIImage(named: name) ?? #imageLiteral(resourceName: "meal")
    }
}
