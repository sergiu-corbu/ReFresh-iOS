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
    Drink(id: UUID().uuidString, name: "Smoothie de zmeura",priceInfo: "16 lei/L" , imageName: "zmeura",category: Category.Smoothie, description: "Smoothie proaspat obtinut din zmeura si apa. Foarte bun pentru digestie si un stil de viata sanatos. Recomandam cu incredere!",ingredients: ["90%", "Zmeura","10%","Apa"], price: 7),
    
    Drink(id: UUID().uuidString, name: "Suc de mere",priceInfo: "6 lei/L" ,imageName: "mere",category: Category.Suc, description: "Suc proaspat obtinut din mere, portocale, caise. Foarte bun pentru digestie si un stil de viata sanatos. Recomandam cu incredere!",ingredients: ["90%", "Mere","10%", "Apa"], price: 4),
    
    Drink(id: UUID().uuidString, name: "Suc de mere & portocale & morcovi", priceInfo: "11 lei/L" ,imageName: "applecarrot",category: Category.Suc, description: "Suc proaspat obtinut din mere, portocale, caise. Foarte bun pentru digestie si un stil de viata sanatos. Recomandam cu incredere!",ingredients: ["70%"," Mere","20%", "Portocale", "10%","Morcovi"], price: 6),
    
    //simple juice
    Drink(id: UUID().uuidString, name: "Fresh de portocale", priceInfo: "8 lei/L"
          , imageName: "portocale",category: Category.Suc, description: "Suc proaspat obtinut din mere, portocale, caise. Foarte bun pentru digestie si un stil de viata sanatos. Recomandam cu incredere!",ingredients: ["100%", "Portocale"],price: 5),

    //combined juice
    Drink(id: UUID().uuidString, name: "Pineapple & Coconut", priceInfo: "13 lei/L" ,imageName: "pinap",category: Category.Suc, description: "Smoothie obtinut din ananas si mango, racorit cu gheata",ingredients: ["40%", "Ananas","45%","Mango", "15%", "Gheata"], price: 6),
    
    Drink(id: UUID().uuidString, name: "Zmeura & Mango", priceInfo: "15 lei/L" ,imageName: "raspmango",category: Category.MultiSmoothie, description: "Suc proaspat obtinut din mere, portocale, caise. Foarte bun pentru digestie si un stil de viata sanatos. Recomandam cu incredere!",ingredients: ["50%", "Zmeura","40%","Mango", "10%","apa"],price: 8)
    
]
