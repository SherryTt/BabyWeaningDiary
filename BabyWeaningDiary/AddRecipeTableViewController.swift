//
//  AddRecipeTableViewController.swift
//  BabyWeaningDiary
//
//  Created by Shiori on 24/11/2022.
//

import UIKit
import FirebaseFirestore


class AddRecipeTableViewController: UITableViewController {
    
    let database = Firestore.firestore()
    var recipe = [Recipe]()
    
    
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeImageUploadButton: UIButton!
    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var prepTimeTextField: UITextField!
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var babyImage: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var babyImageUploadButton: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
    }
    
    // MARK: - Table view data source
     
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let addRecipeTableVC = segue.destination as? RecipeTableViewController{
            var recipe = Recipe(title: recipeNameTextField.text!
                                       , prepTime: self.prepTimeTextField.text!
                                       , ingredients: self.ingredientsTextField.text!
                                       , description: self.descriptionTextField.text!
                                       , recipePhoto: ""
                                       , babyPhoto: ""
                                       , comments:self.commentTextField.text!
                                       , favorite:self.isBeingDismissed)
                   
                   addRecipeTableVC.addNewRecipe = recipe
               }
    }
}
