import Foundation
import SwiftUI

enum Category: String, CaseIterable, Codable, Hashable{
    case Suc
    //case Shake
    case Smoothie
    case MultiSmoothie
}

struct Drink: Identifiable, Hashable, Equatable {
    var id: String
    var name: String
    var priceInfo: String
    var imageName: String
    var category: Category
    var description: String
    var ingredients: [String]
    var price: Double
}

func drinkDictionaryFrom(drink: Drink) -> [String: Any]{
    
    return NSDictionary(objects: [ drink.id, drink.name, drink.priceInfo, drink.imageName, drink.category.rawValue, drink.description,drink.ingredients, drink.price], forKeys: [ kID as NSCopying, kNAME as NSCopying,kPRICEINFO as NSCopying, kIMAGENAME as NSCopying, kCATEGORY as NSCopying, kDESCRIPTION as NSCopying, kINGREDIENTS as NSCopying, kPRICE as NSCopying]) as! [String : Any]
}

//run only once
func createMenu(){
    for drink in DrinkMenu{
        FirebaseReference(.Menu).addDocument(data: drinkDictionaryFrom(drink: drink))
    }
}

let DrinkMenu = [
    
    Drink(id: UUID().uuidString, name: "Suc de mere",priceInfo: "10 lei/L" ,imageName: "oj",category: Category.Suc, description: "Suc proaspat obtinut din mere, portocale, caise. Foarte bun pentru digestie si un stil de viata sanatos. Recomandam cu incredere!",ingredients: ["90%", "Mere","10%", "Apa"], price: 4),
    Drink(id: UUID().uuidString, name: "Suc de mere & portocale & morcovi", priceInfo: "10 lei/L" ,imageName: "oj",category: Category.Suc, description: "Suc proaspat obtinut din mere, portocale, caise. Foarte bun pentru digestie si un stil de viata sanatos. Recomandam cu incredere!",ingredients: ["70%"," Mere","20%", "Portocale", "10%","Morcovi"], price: 6),
    
    //simple juice
    Drink(id: UUID().uuidString, name: "Fresh de portocale", priceInfo: "8 lei/L"
          , imageName: "oj",category: Category.Suc, description: "Suc proaspat obtinut din mere, portocale, caise. Foarte bun pentru digestie si un stil de viata sanatos. Recomandam cu incredere!",ingredients: ["100%", "Portocale"],price: 5),
    
    
    //combined juice
    Drink(id: UUID().uuidString, name: "Suc de mere & portocale", priceInfo: "10 lei/L" ,imageName: "oj",category: Category.Suc, description: "Suc proaspat obtinut din mere, portocale, caise. Foarte bun pentru digestie si un stil de viata sanatos. Recomandam cu incredere!",ingredients: ["35%", "Mere","65%","Portocale"], price: 6),
    
    
    //simple_smoothie
    
    Drink(id: UUID().uuidString, name: "Smoothie de zmeura",priceInfo: "12 lei/L" , imageName: "oj",category: Category.Smoothie, description: "Suc proaspat obtinut din mere, portocale, caise. Foarte bun pentru digestie si un stil de viata sanatos. Recomandam cu incredere!",ingredients: ["90%", "Zmeura","10%","apa"],price: 7),
    
    //combined_smoothie
    
    Drink(id: UUID().uuidString, name: "Smoothie de zmeura & mango", priceInfo: "10 lei/L" ,imageName: "oj",category: Category.MultiSmoothie, description: "Suc proaspat obtinut din mere, portocale, caise. Foarte bun pentru digestie si un stil de viata sanatos. Recomandam cu incredere!",ingredients: ["50%", "Zmeura","40%","Mango", "10%","apa"],price: 8)
    
]
