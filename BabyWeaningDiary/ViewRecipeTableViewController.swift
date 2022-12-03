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
        
        
        recipeImage.image = UIImage(named: recipe.recipePhoto)
        recipeNameLabel.text = "\(recipe.title)"
        prepTimeLable.text = "\(recipe.prepTime)"
        ingredientsLabel.text = "\(recipe.ingredients)"
        descriptionLabel.text =  "\(recipe.description)"
        commentLabel.text =  "\(recipe.comments)"
        babyImage.image = UIImage(named: recipe.babyPhoto)
    }
    
    @IBAction func deleteRecipe(_ sender: Any) {
        
        let recipe = Recipe(documentId: recipe.id!)
        if service.deleteRecipe(recipe: recipe){
            print("Recipe was deleted")
        }else{
            print("Recipe could not be deleted")
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let editRecipeTableVC = segue.destination as? EditRecipeTableViewController{
            editRecipeTableVC.recipe = self.recipe
        }
    }
}
