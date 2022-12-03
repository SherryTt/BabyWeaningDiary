//
//  recipeLists.swift
//  BabyWeaningDiary
//
//  Created by Shiori on 23/10/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

public class Recipe : Codable{
    
    @DocumentID var id : String?
    var title : String
    var prepTime : String
    var ingredients : String
    var description : String
    var recipePhoto : String
    var babyPhoto : String
    var comments : String

    @ServerTimestamp var created : Timestamp?   //If an object being written contains null, it will be replaced with a server-generated timestamp
    @ServerTimestamp var lastUpdatedAt : Timestamp?

    init(title: String, prepTime: String, ingredients: String, description: String, recipePhoto: String, babyPhoto: String, comments: String, created: Timestamp? = nil, lastUpdatedAt: Timestamp? = nil)
    {
        self.title = title
        self.prepTime = prepTime
        self.ingredients = ingredients
        self.description = description
        self.recipePhoto = recipePhoto
        self.babyPhoto = babyPhoto
        self.comments = comments
        self.created = created
        self.lastUpdatedAt = lastUpdatedAt
    }
    
    convenience init(documentId : String) {
        self.init(title: "", prepTime: "", ingredients: "", description: "", recipePhoto: "", babyPhoto: "", comments: "")
        self.id = documentId
    }
    
}
