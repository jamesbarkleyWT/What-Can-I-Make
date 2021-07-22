//
//  SavedRecipesTableViewController.swift
//  What Can I Make
//  Saved Recipes View
//
//  Created by James Barkley on 7/6/21.
//

import UIKit


var savedRecipeListBookmark = [RecipeItem]()


// For testing purposes
func printRecipes(){
    
    if savedRecipeListBookmark.isEmpty {
        print("***EMPTY***")
    }
    for x in savedRecipeListBookmark {
        print(x.label)
        print("^^^^^^^^^^^^^^^^^^^^^^^")
    }
}

class SavedRecipeCell: UITableViewCell {
    
    
//    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var missingIngredients: UILabel!
    @IBOutlet weak var metricBackground: UIView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var nameOfRecipe: UILabel!
    @IBOutlet weak var goToRecipeData: UIButton!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var servingSize: UILabel!
    @IBOutlet weak var healthLabels: UILabel!
    
    
    // Takes user to original recipe page
    @IBAction func goToRecipe(_ sender: Any) {
        UIApplication.shared.open(URL(string:savedRecipeListBookmark[goToRecipeData.tag].url)!, options: [:], completionHandler: nil)
    }
}

class SavedRecipesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getSavedList()
        printRecipes()
    }
    
    func getSavedList(){
        // Read/Get Data
        if let data = UserDefaults.standard.data(forKey: "savedList") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                savedRecipeListBookmark = try decoder.decode([RecipeItem].self, from: data)
                
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
    }
    
    
    func saveRecipes(){
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(savedRecipeListBookmark)
            UserDefaults.standard.set(data, forKey: "savedList")
            getSavedList()
            
        } catch {
            print("Saved Recipes")
        }

    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedRecipeListBookmark.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            savedRecipeListBookmark.remove(at: indexPath.row)
            saveRecipes()
            tableView.reloadData()
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeInfoTableViewCell", for: indexPath) as! SavedRecipeCell
        cell.nameOfRecipe?.text = savedRecipeListBookmark[indexPath.row].label
        
        let urlImage = URL(string: savedRecipeListBookmark[indexPath.row].image)!
        let data = try? Data(contentsOf: urlImage)

        if let imageData = data {
            cell.recipeImage?.image = UIImage(data: imageData)
        }
        
        
        cell.calories?.text = String(format: "%.0f",savedRecipeListBookmark[indexPath.row].calories/Double(savedRecipeListBookmark[indexPath.row].yield)) + " Cal"
        cell.servingSize?.text = String(savedRecipeListBookmark[indexPath.row].yield)
        
        var dietLabl = ""
        
        let healthDietLabelsArray = savedRecipeListBookmark[indexPath.row].healthLabels + savedRecipeListBookmark[indexPath.row].dietLabels
        
        var healthLabelCount = 1
        
        for x in healthDietLabelsArray {
            if healthLabelCount == healthDietLabelsArray.count {
                dietLabl += "\(x)"
            } else {
                dietLabl += "\(x), "
            }
            healthLabelCount += 1
        }
        
        
        let missingIng = savedRecipeListBookmark[indexPath.row].ingredientLines.count - UserDefaults.standard.integer(forKey: "ingredientListCount")
        cell.missingIngredients.text = String(missingIng)
        
        
        cell.healthLabels?.text = dietLabl
        cell.goToRecipeData.tag = indexPath.row
        cell.goToRecipeData.layer.cornerRadius = 3.0
        cell.metricBackground.layer.cornerRadius = 3.0
        
        return cell
    }
    

}
