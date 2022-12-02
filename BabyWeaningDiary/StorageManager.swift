//
//  StorageManager.swift
//  BabyWeaningDiary
//
//  Created by Shiori on 1/12/2022.
//

import Foundation
import FirebaseStorage

final class StorageManager{
    
    private let storage = Storage.storage().reference()
    
    public typealias uploadImageCompletion = (Result<String, Error>) -> Void
    
    public func uploadImage(with data: Data, fileName: String , completion: @escaping uploadImageCompletion){
       
        storage.child("images/\(fileName)").putData(data, metadata: nil, completion: {
            metadata, error in guard error == nil else{
                print("Failed to upload the image")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            //get the URL from Firestorage
            self.storage.child("images/\(fileName)").downloadURL(completion: { url, error in
                guard let url = url else{
                    print("Failed to get download URL")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                // all went fine
                let urlString = url.absoluteString
                print("download url returned: \(urlString)")
                completion(.success(urlString))
            })
        })
    }
    public enum StorageErrors: Error{
        case failedToUpload
        case failedToGetDownloadUrl
    }
}
