//
//  FirebaseReference.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/24/21.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String{
    case User
    case Menu
    case Order
    case Basket
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference{
    return Firestore.firestore().collection(collectionReference.rawValue)
}
