//
//  FirestoreRepository.swift
//  BabyWeaningDiary
//
//  Created by shiori on 23/10/2022.
//

import Foundation
import FirebaseFirestore

class FirestoreRepository {
    
    var db = Firestore.firestore()
    var recipes = [Recipe]()

    
    func fetchData(){
        /*Snapshot listener has 2 parameters : querySnapshot and error
          querySnapshot holds the documents from our collection
         */
        db.collection("recipes").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No recipes")
                return
            }
            //at this point we now we've got documents
            self.recipes = documents.map { queryDocumentSnapshot -> Recipe in
                return try! queryDocumentSnapshot.data(as: Recipe.self)
            }
        }
    }
    
    
    func findRecipeById(id : String, onCompletion : @escaping (Recipe?) -> Void) {
        let docRef = db.collection("recipes").document(id)
        var recipeResult : Recipe!
        
        docRef.getDocument(as: Recipe.self) { result in
            switch result {
            case .success(let recipe):
                print("\(recipe.title)")
                recipeResult = recipe
                onCompletion(recipeResult)
            case .failure(let error):
                print("Error decoding document: \(error)")
                onCompletion(nil)
            }
        }
    }
    
    


    
    /**
            
     */
    func addRecipe(recipe: Recipe) -> Bool{
        var result = true
        do{
            let _ = try db.collection("recipes").addDocument(from: recipe)
            
        }catch{
            print(error)
            result = false
        }
        return result
    }
    
    func deleteRecipe(recipe: Recipe) -> Bool{
        var result = true
        db.collection("recipes").document(recipe.id!).delete(){ err in
            if let err = err {
                print("Error removing document: \(err)")
                result = false
            }else{
                print("Document successfully deleted")
            }
        }
        return result;
    }
    
    func updateRecipe(recipe: Recipe) -> Bool{
        var result = true
        do{
            recipe.lastUpdatedAt = nil
            try db.collection("recipes").document(recipe.id!).setData(from: recipe)
        }catch{
            print("Error updating document: \(error)")
            result = false
        }
        return result;
    }
    

    
    
     
}

