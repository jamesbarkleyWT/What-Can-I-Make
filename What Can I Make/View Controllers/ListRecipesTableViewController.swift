//
//  ListRecipesTableViewController.swift
//  What Can I Make
//
//  Created by James Barkley on 6/25/21.
//

import UIKit
import FirebaseDatabase


// Save Recipe images
let notLikedImage = UIImage(named: "save")!
let likedImage = UIImage(named: "saveColored")!


// User Defaults
let defaults = UserDefaults.standard


// List of saved recipes
var savedRecipes = [RecipeItem]()


// All recipes found using the search criteria
var listOfRecipes = [RecipeSingle]()



// MARK: - Models for Recipe Information
struct Hits: Codable {
    var q:String?
    var hits:[RecipeSingle]
}

struct RecipeItem: Codable {
    var label:String
    var image:String
    var url:String
    var yield:Int
    var calories:Double
    var dietLabels:[String]
    var healthLabels:[String]
    var ingredientLines:[String]
}

struct RecipeSingle: Codable {
    var recipe: RecipeItem
}

// Saves Recipes to User Defaults
func saveRecipes(){
    
    do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(savedRecipes)
        UserDefaults.standard.set(data, forKey: "savedList")
    } catch {
        print("Saved Recipes")
    }
}

// Finds the index of a saved recipe from the given recipe name
func findIndex(recipeName: String) -> Int{
    for (n, recipe) in savedRecipes.enumerated(){
        if recipe.label == recipeName {
            return n
        }
    }
    return -1
}







// MARK: - Recipe Cell Class

// Class for Recipe information Cell
class RecipeCell: UITableViewCell {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var missingIngredients: UILabel!
    @IBOutlet weak var metricBackground: UIView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var nameOfRecipe: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var servingSize: UILabel!
    @IBOutlet weak var healthLabels: UILabel!
    @IBOutlet weak var viewRecipeButton: UIButton!
    
    @IBOutlet weak var imageOverlay: UIView!
    // Button to go to original recipe page
    @IBAction func viewRecipeButton(_ sender: Any) {
        if let url = URL(string: listOfRecipes[viewRecipeButton.tag].recipe.url) {
            UIApplication.shared.open(url)
        }
    }
    
    // When a user taps the save recipe button
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if saveButton.currentImage!.isEqual(notLikedImage){
            if !checkIfSavedItemExists(recipeName: listOfRecipes[saveButton.tag].recipe.label){
                saveButton.setImage(likedImage, for: .normal)
                savedRecipes.append(listOfRecipes[saveButton.tag].recipe)
                saveRecipes()
            }


        } else {
            
            if  checkIfSavedItemExists(recipeName: listOfRecipes[saveButton.tag].recipe.label){
                saveButton.setImage(notLikedImage, for: .normal)
                let index = findIndex(recipeName: listOfRecipes[saveButton.tag].recipe.label)
                savedRecipes.remove(at: index)
                saveRecipes()
            }
        }
    }
    
    
    // Ensures when a user is saving a recipe it is not already saved
    func checkIfSavedItemExists(recipeName: String) -> Bool{
        
        for x in savedRecipes{
            if x.label == recipeName{
                return true
            }
        }
        return false
    }
}









// MARK: - ListRecipesTableViewController Class
class ListRecipesTableViewController: UITableViewController {
    
    @IBOutlet weak var resultsLable: UILabel!
    var responseRecipes = [RecipeSingle]()
    var newIngredient: String = ""
    var ingredientList = [String]()
    var apiURL = [String]()
    var responseRecipesCount = 0
    
    @IBOutlet weak var noResultsIcon: UIImageView!
    @IBOutlet weak var noResultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSavedList()
        noResultsIcon.alpha = 0
        noResultsLabel.alpha = 0

    }
    

    
    // Grabs the list of saved recipes from User Defaults
    func getSavedList(){
        // Read/Get Data
        if let data = UserDefaults.standard.data(forKey: "savedList") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                savedRecipes = try decoder.decode([RecipeItem].self, from: data)
                
            } catch {
                print("Unable to Decode Saved Recipes (\(error))")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Grabs the created url from previous page from user defaults
        apiURL = defaults.object(forKey: "keyURL") as? [String] ?? [String]()
        UserDefaults.standard.removeObject(forKey: "keyURL")
        getSavedList()
        fetchPostData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfRecipes.count
    }
    
    func displayNoResults(){
        noResultsIcon.alpha = 1
        noResultsLabel.alpha = 1
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeInfoTableViewCell", for: indexPath) as! RecipeCell
        
        
        do {
            // Assign Name of Recipe
            cell.nameOfRecipe?.text = listOfRecipes[indexPath.row].recipe.label
            
            
            tableView.separatorColor = .clear
            
            // Create and Assign Recipe Image
            let urlImage = URL(string: listOfRecipes[indexPath.row].recipe.image)!
            let data = try? Data(contentsOf: urlImage)

            if let imageData = data {
                cell.recipeImage?.image = UIImage(data: imageData)
                cell.recipeImage?.layer.cornerRadius = (cell.recipeImage?.frame.width)!/2.0
                cell.recipeImage?.clipsToBounds = true
                cell.recipeImage?.layer.masksToBounds = true
                cell.imageOverlay.layer.cornerRadius = (cell.imageOverlay.frame.width)/2.0
                cell.imageOverlay.clipsToBounds = true
                cell.imageOverlay.layer.masksToBounds = true
            }
            
            
            
            
            // Assign Calories
            cell.calories?.text = String(format: "%.0f",listOfRecipes[indexPath.row].recipe.calories/Double(listOfRecipes[indexPath.row].recipe.yield)) + " Cal"
            cell.servingSize?.text = String(listOfRecipes[indexPath.row].recipe.yield)
            
            
            
            // Add Health Labels
            var dietLabl = ""

            let healthDietLabelsArray = listOfRecipes[indexPath.row].recipe.healthLabels + listOfRecipes[indexPath.row].recipe.dietLabels
            
            var healthLabelCount = 1
            
            for x in healthDietLabelsArray {
                if healthLabelCount == healthDietLabelsArray.count {
                    dietLabl += "\(x)"
                } else {
                    dietLabl += "\(x), "
                }
                healthLabelCount += 1
            }
            cell.healthLabels?.text = dietLabl
            
            
            
            // Set Saved Image Icon
            if findIndex(recipeName: listOfRecipes[indexPath.row].recipe.label) < 0 {
                cell.saveButton.setImage(notLikedImage, for: .normal)
            } else {
                cell.saveButton.setImage(likedImage, for: .normal)
            }
            
            
            
            // Assign missing ingredient amount
            let missingIng = listOfRecipes[indexPath.row].recipe.ingredientLines.count - ingredientList.count
            cell.missingIngredients.text = String(missingIng)
            
            
            
            // Styling for Go to Recipe/Save Button
            cell.saveButton.backgroundColor = .clear
            cell.saveButton.tag = indexPath.row
            cell.saveButton.imageView?.contentMode = .scaleAspectFit
            cell.saveButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cell.viewRecipeButton.tag = indexPath.row
            cell.viewRecipeButton.layer.cornerRadius = 3.0
            cell.metricBackground.layer.cornerRadius = 3.0
        
        } 
        
        return cell
    }



    func fetchPostData(){
        
            let headers = [
                "x-rapidapi-key": "f88b291911msh89c624b5a8770b3p13170cjsnd9bf7e9ca5b8",
                "x-rapidapi-host": "edamam-recipe-search.p.rapidapi.com"
            ]

            var request = URLRequest(url: URL(string: apiURL[0])!)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            URLSession.shared.dataTask(with: request, completionHandler: { data, resp, error in
                
                guard let data = data, error == nil else {
                    print("Something went wrong")
                    return
                }
                
                var result: Hits?
                do {
                    result = try JSONDecoder().decode(Hits.self, from: data)
                }
                catch {
                    print("failed to convert \(error)")
                }
                
                guard let json = result else {
                    return
                }
                
                self.responseRecipesCount = json.hits.count
                
                
                
                listOfRecipes = json.hits
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                    if self.responseRecipesCount == 0 {
                        self.displayNoResults()
                    }
                }
                
            }).resume()

    }

}


extension Decodable {
  init(from: Any) throws {
    let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
    let decoder = JSONDecoder()
    self = try decoder.decode(Self.self, from: data)
  }
}
