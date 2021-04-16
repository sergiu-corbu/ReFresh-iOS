//
//  Order.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/25/21.
//

import Foundation
import Firebase

class Order: Identifiable{
    
    var id: String!
    var customerFullName: String!
    var customerPhone: String!
    var items: [Drink] = []
    var total: Double{
        if items.count > 0{
            return items.reduce(0){$0 + $1.price}
        } else { return 0.0}
    }
    
    func add(_ item: Drink){
        items.append(item)
    }
    
    func remove(_ item: Drink){
        if let index = items.firstIndex(of: item){
            items.remove(at: index)
        }
    }
    
    func emptyBasket(){
        self.items = []
        saveBasketToFirestore()
    }
    
    func saveBasketToFirestore(){
        FirebaseReference(.Basket).document(self.id).setData(basketDictionaryFrom(self))
    }
}

func basketDictionaryFrom(_ basket: Order) -> [String : Any]{
    var allDrinks: [String] = []

    for drink in basket.items{
        allDrinks.append(drink.name)
    }
    return NSDictionary(objects: [basket.id, basket.customerFullName, basket.customerPhone, allDrinks], forKeys: [kID as NSCopying, kFULLNAME as NSCopying, kPHONENUMBER as NSCopying, kDRINKNAME as NSCopying]) as! [String : Any]
}
