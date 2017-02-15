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

    static let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("myRecipes").appendingPathExtension("plist")
    
    var recipes: [Recipe]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipes = loadRecipes() ?? []
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        switch segue.identifier ?? "" {
        case "toRecipeDetailVCSID":
            let recipe = (sender as! RecipeViewCell).recipe
            segue.destination.title = recipe?.name
        default: break
        }
        
    }
    
    //MARK: - unwind segue implementation
    @IBAction func unwindToRecipeList(sender: UIStoryboardSegue) {
        guard let sourceVC = sender.source as? AddRecipeVC else {
            return
        }
        
        if let recipe = sourceVC.recipe {
            recipes.append(recipe)
            saveRecipes()
            let indexPath = IndexPath(row: recipes.count-1, section: 0)
            tableView.insertRows(at: [indexPath] , with: .automatic)
        }
    }
    
    @IBAction func unwindBack(sender: UIStoryboardSegue) {
    }
    
    
    //MARK: - saving/loading recipes
    func saveRecipes() {
        
        let result = NSKeyedArchiver.archiveRootObject(recipes, toFile: RecipesTVC.fileURL.path)
        if !result {
            print("Failed to save recipes to file \(RecipesTVC.fileURL.path)")
        }
    }
    
    func loadRecipes() -> [Recipe]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: RecipesTVC.fileURL.path) as? [Recipe]
    }
    
    //MARK: - UITableViewDelegate/UITableViewDataSource implementation
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: RecipesTVC.recipesSID)!
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! RecipeViewCell).recipe = recipes[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else {
            return
        }
        
        recipes.remove(at: indexPath.row)
        saveRecipes()
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}

extension Recipe {
    
    var image: UIImage {
        return UIImage(named: name) ?? #imageLiteral(resourceName: "meal")
    }
    
}
