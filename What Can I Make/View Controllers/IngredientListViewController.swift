//
//  IngredientListTableViewController.swift
//  What Can I Make
//
//
//  Created by James Barkley on 6/24/21.
//

import UIKit


// Add Ingredient View
class IngredientListViewController: UITableViewController {
    
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var errorMessageBG: UIView!
    @IBOutlet weak var errorMessageSideBorder: UIView!
    @IBOutlet weak var duplicateIngredientMessage: UILabel!
    
    var ingredientList = [String]()
    var newIngredient: String = ""
    var savedRecipeList = [RecipeItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styling()
    }
    
    // Handles Search/View Saved Recipe/Error Message styling
    func styling(){
        
        // Hides error message for adding duplicate ingredients
        duplicateIngredientMessage.alpha = 0
        
        searchButton.backgroundColor = UIColor.systemPink
        searchButton.layer.cornerRadius = 3.0
        savedRecipesButton.backgroundColor = .clear
        savedRecipesButton.layer.cornerRadius = 3.0
        savedRecipesButton.layer.borderWidth = 1
        savedRecipesButton.layer.borderColor = UIColor.systemPink.cgColor
        errorMessageBG.alpha = 0
        errorMessageSideBorder.alpha = 0
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        saveRecipes()
    }
    
    func saveRecipes(){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(ingredientList)
            UserDefaults.standard.set(data, forKey: "ingredientList")
            
            // Save count of ingredients
            UserDefaults.standard.set(ingredientList.count, forKey: "ingredientListCount")
            UserDefaults.standard.synchronize()
        } catch {
            print("Saved Recipes")
        }
    }

    
    @IBOutlet weak var savedRecipesButton: UIButton!
    
    @IBAction func savedRecipesButtonTapped(_ sender: Any) {
        // Empty Segue
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)

        cell.textLabel?.text = ingredientList[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)

        return cell
    }
    
    // For removing ingredients from list
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            ingredientList.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
    }
    
    // Creates the URL for the request to the API
    func createURL(list:[String]) -> String{
        var url = "https://edamam-recipe-search.p.rapidapi.com/search?q="
        for (n, ing) in list.enumerated(){
            if n == list.count - 1 {
                url += "\(ing.lowercased().replacingOccurrences(of: " ", with: ""))"
            } else {
                url += "\(ing.lowercased().replacingOccurrences(of: " ", with: ""))%2C"
            }
        }
        return url
    }
    
    
    
    @IBAction func searchButton(_ sender: Any) {
        
        // Saves URL so next view can get
        let url = createURL(list:ingredientList)
        let array = [url]
        UserDefaults.standard.set(array, forKey:"keyURL")
        
        newIngredient = ""
    }
    
    
    @objc func removeDuplicateIngredientMessage(){
        duplicateIngredientMessage.text = ""
        duplicateIngredientMessage.alpha = 0
        errorMessageBG.alpha = 0
        errorMessageSideBorder.alpha = 0
    }
    
    
    @IBAction func done(segue:UIStoryboardSegue) {
        
        let ingredientDetailVC = segue.source as! IngredientDetailViewController
        newIngredient = ingredientDetailVC.name
        
        if ingredientList.contains(newIngredient){
            duplicateIngredientMessage.text = "\(newIngredient) already in list."
            duplicateIngredientMessage.alpha = 1
            errorMessageBG.alpha = 0.35
            errorMessageSideBorder.alpha = 1
            
            // Timer for duplicate ingredient error message
            _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(removeDuplicateIngredientMessage), userInfo: nil, repeats: false)
        } else {
            ingredientList.append(newIngredient)
        }
        newIngredient = ""
        tableView.reloadData()
    }
    
    
    

}

