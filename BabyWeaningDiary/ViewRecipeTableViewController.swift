//
//  ViewRecipeTableViewController.swift
//  BabyWeaningDiary
//
//  Created by Shiori on 24/11/2022.
//

import UIKit

class ViewRecipeTableViewController: UITableViewController {

    var recipe : Recipe!
    let service = FirestoreRepository()
    
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var prepTimeLable: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var babyImage: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!

    @IBOutlet weak var deleteRecipeButton: UIButton!
    
    
 
    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    
        recipeNameLabel.text = "\(recipe.title)"
        prepTimeLable.text = "\(recipe.prepTime)"
        ingredientsLabel.text = "\(recipe.ingredients)"
        descriptionLabel.text =  "\(recipe.description)"
        commentLabel.text =  "\(recipe.comments)"
        
    }
    
    @IBAction func deleteRecipe(_ sender: Any) {
        
        let recipeId = recipeNameLabel.text
        if recipeId!.isEmpty {
            print("Empty")
            return
        }
        
        let recipe = Recipe(documentId: recipeId!)
        if service.deleteRecipe(recipe: recipe){
            print("Recipe was deleted")
        }else{
            print("Recipe could not be deleted")
        }
            }
    

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let editRecipeTableVC = segue.destination as? EditRecipeTableViewController{
            editRecipeTableVC.recipe = self.recipe
        }
       /*
        if let deleteRecipeTableVC =  segue.destination as? RecipeTableViewController{
            deleteRecipeTableVC.selectedRecipe = self.recipe
        }*/
        
        
        
        
    }
    

}
