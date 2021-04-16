//
//  BasketListener.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/25/21.
//

import Foundation
import Firebase

class BasketListener: ObservableObject{
    
    @Published var orderBasket: Order!
    
    init(){
        downloadBasket()
    }
    
    func downloadBasket(){
        if User.currentUser() != nil{
            FirebaseReference(.Basket).whereField(kFULLNAME, isEqualTo: User.currentUser()?.fullName).addSnapshotListener { (snapshot, error) in
                guard let snapshot = snapshot else { return }
                if !snapshot.isEmpty{
                    let basketData = snapshot.documents.first!.data()
                    getDrinksFromFirestore(withIds: basketData[kDRINKNAME] as? [String] ?? []) { (allDrinks) in
                        let basket = Order()
                        basket.customerFullName = basketData[kFULLNAME] as? String
                        basket.id = basketData[kID] as? String
                        basket.items = allDrinks
                        basket.customerPhone = basketData[kPHONENUMBER] as? String
                        self.orderBasket = basket
                    }
                }
            }
        }
    }
}

func getDrinksFromFirestore(withIds: [String], completion: @escaping (_ drinkArray: [Drink])->Void){
    
    var count = 0
    var drinkArray: [Drink] = []
    
    if withIds.count == 0{
        completion(drinkArray)
        return
    }
    for drinkId in withIds{
        FirebaseReference(.Menu).whereField(kNAME, isEqualTo: drinkId).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {return}
            if !snapshot.isEmpty{
                let drinkData = snapshot.documents.first!
                drinkArray.append(Drink(id: drinkData[kID] as? String ?? UUID().uuidString, name: drinkData[kNAME] as? String ?? "unknown", priceInfo: drinkData[kPRICEINFO] as? String ?? "0 lei / l", imageName: drinkData[kIMAGENAME] as? String ?? "unknown", category: Category(rawValue: drinkData[kCATEGORY] as? String ?? "sucuri") ?? .Suc, description: drinkData[kDESCRIPTION] as? String ?? "Fara descriere", ingredients: drinkData[kINGREDIENTS] as? [String] ?? [""], price: drinkData[kPRICE] as? Double ?? 0.0))
                count += 1
            } else{
                print("have no drink")
                completion(drinkArray)
            }
            if count == withIds.count{
                completion(drinkArray)
            }
        }
    }
}
