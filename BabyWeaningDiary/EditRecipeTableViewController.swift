//
//  EditRecipeTableViewController.swift
//  BabyWeaningDiary
//
//  Created by Shiori on 24/11/2022.
//

import UIKit

class EditRecipeTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var recipe : Recipe!
    
    private var storageManager = StorageManager()
    private var downloadUrl : String = ""
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var recipeImageUpdateButton: UIButton!
    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var prepTimeTextField: UITextField!
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var babyImage: UIImageView!
    @IBOutlet weak var babyImageUpdateButton: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //favoriteButton.is = recipe.favorite
        recipeImage.image = UIImage(named: recipe.recipePhoto)
        recipeNameTextField.text = "\(recipe.title)"
        prepTimeTextField.text = "\(recipe.prepTime)"
        ingredientsTextField.text = "\(recipe.ingredients)"
        descriptionTextField.text = "\(recipe.description)"
        commentTextField.text = "\(recipe.comments)"
        babyImage.image = UIImage(named: recipe.babyPhoto)
        
        configurePicker()
    }
    
    func configurePicker() {
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        recipeImage.contentMode = .scaleAspectFit
        recipeImage.isUserInteractionEnabled = true
        recipeImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPictureImageView)))
        
    }
    
    @objc
    func handleSelectPictureImageView(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("picker canceled by the user")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        var selectedImageFromPicker : UIImage?
        if let editedImage = info[.editedImage] as? UIImage{
            selectedImageFromPicker = editedImage
        }else if let originalImage = info[.originalImage] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        
        recipeImage.image = selectedImageFromPicker
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func saveRecipeImage() -> String {
        guard let image = recipeImage.image,
                let data = image.jpegData(compressionQuality: 0.0) else {
            return ""
        }
        
        let fileName = "\(recipe.title)-profile.jpg"
        storageManager.uploadImage(with: data, fileName: fileName, completion: { result in
            switch result {
            case .success(let downloadUrl) :
                print("all good, url : \(downloadUrl) ")
                self.downloadUrl = downloadUrl
                
            case .failure(let error):
                print("StorageManager error \(error)")
            }
        })
            return self.downloadUrl
    }
    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let recipeTableVC = segue.destination as? RecipeTableViewController{
            recipe.title = recipeNameTextField.text!
            recipe.prepTime = prepTimeTextField.text!
            recipe.ingredients = ingredientsTextField.text!
            recipe.description = descriptionTextField.text!
            recipe.comments = commentTextField.text!
            recipe.lastUpdatedAt = nil
            
            //save photo in firebase storage & assign the pic url to the recipe object
            
            recipe.recipePhoto = saveRecipeImage()
            recipeTableVC.selectedRecipe = recipe
        }
    }
    

}
