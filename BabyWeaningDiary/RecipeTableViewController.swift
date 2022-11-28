//
//  RecipeTableViewController.swift
//  BabyWeaningDiary
//
//  Created by Shiori on 10/11/2022.
//

import UIKit

class RecipeTableViewController: UITableViewController {
    
    let service = FirestoreRepository()
    var recipes = [Recipe]()
    
    var selectedRecipe : Recipe!
    var addNewRecipe : Recipe!
    
    
    @IBOutlet var recipeTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let docRef = service.db.collection("recipes").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents \(error!)")
                return
            }
            
            self.recipes = documents.compactMap({ queryDocumentSnapshot -> Recipe? in
                return try? queryDocumentSnapshot.data(as: Recipe.self)
            })
            
            for res in self.recipes {
                print(res.title)
            }
            //  print("=======")
            self.recipeTableView.reloadData()
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseidentifier", for: indexPath) as! RecipeCell
        
        // Configure the cell...
        let recipe = recipes[indexPath.row]
        
        //     cell.photoImageView.image = UIImage(named: recipe.photo)
        cell.prepTimeLabel.text = recipe.prepTime
        cell.recipeNameLabel.text = recipe.title
       
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.selectedRecipe = recipes[indexPath.row]
        return indexPath
    }
    
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let viewRecipeTableVC = segue.destination as? ViewRecipeTableViewController {
            viewRecipeTableVC.recipe = selectedRecipe
        }
    }
    
    @IBAction func unwindToRecipeTableViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        
        if let editRecipeTableVC = sourceViewController as? EditRecipeTableViewController{
            
            if service.updateRecipe(recipe: self.selectedRecipe){
                print("Recipe Saved")
            }
        }
      
        if let addRecipeTableVC = sourceViewController as? AddRecipeTableViewController{

            if service.addRecipe(recipe: self.addNewRecipe){
                print("Recipe Added")
            }
        }
    }
    
    class RecipeCell: UITableViewCell{
        
//        @IBOutlet weak var recipeImage: UIImageView!
        
        @IBOutlet weak var recipeImage: UIImageView!

        @IBOutlet weak var recipeNameLabel: UILabel!
        
        @IBOutlet weak var prepTimeLabel: UILabel!
        
        
        
//        @IBOutlet weak var recipeNameLabel: UILabel!
  //      @IBOutlet weak var prepTimeLabel: UILabel!
            
//        @IBOutlet weak var recipeNameLabel: UILabel!
//        @IBOutlet weak var prepTimeLabel: UILabel!
        
    }
}
