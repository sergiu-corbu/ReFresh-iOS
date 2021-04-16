//
//  DrinkListener.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/25/21.
//

import Foundation
import Firebase

class DrinkListener: ObservableObject{
    @Published var drinks: [Drink] = []
    
    init(){
        downloadDrinks()
    }
    
    func downloadDrinks(){
        FirebaseReference(.Menu).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            if !snapshot.isEmpty{
                self.drinks = DrinkListener.drinkFromDictionary(snapshot)
            }
        }
    }
    
    static func drinkFromDictionary(_ snapshot: QuerySnapshot) -> [Drink]{
        
        var allDrinks: [Drink] = []
        
        for snapshot in snapshot.documents{
            let drinkData = snapshot.data()
            
            allDrinks.append(Drink(id: drinkData[kID] as? String ?? UUID().uuidString, name: drinkData[kNAME] as? String ?? "unknown",priceInfo: drinkData[kPRICEINFO] as? String ?? "0 lei / l", imageName: drinkData[kIMAGENAME] as? String ?? "unknown", category: Category(rawValue: drinkData[kCATEGORY] as? String ?? "Sucuri") ?? .Suc, description: drinkData[kDESCRIPTION] as? String ?? "Fara descriere", ingredients: drinkData[kINGREDIENTS] as? [String] ?? [""], price: drinkData[kPRICE] as? Double ?? 0.0))
        }
        return allDrinks
    }
}
