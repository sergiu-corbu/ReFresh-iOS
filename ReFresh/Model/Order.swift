//
//  Orde.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/25/21.
//

import Foundation

class OnlineOrder{
    var id: String!
    var customerFullName: String!
    var customerPhone: String!
    var orderItems: [Drink] = []
    var orderDate: String!
    var toGo: Bool!
    var amount: Double! = 0
    var isCompleted: Bool!
    var isTaken: Bool!
    
    func saveOnlineOrderToFirestore(){
        FirebaseReference(.Order).document(self.id).setData(orderDictionaryFrom(self))
    }
}

func orderDictionaryFrom(_ order: OnlineOrder) -> [String : Any ]{
    var allDrinkName: [String] = []
    for drink in order.orderItems{
        allDrinkName.append(drink.name)
    }
    return NSDictionary(objects: [order.id, order.customerFullName, order.customerPhone, allDrinkName, order.amount, order.orderDate, order.toGo, order.isCompleted, order.isTaken], forKeys: [kID as NSCopying, kFULLNAME as NSCopying,kPHONENUMBER as NSCopying, kDRINKNAME as NSCopying,kAMOUNT as NSCopying, kORDERDATE as NSCopying, kORDEROPTION as NSCopying, kORDERISCOMPLETED as NSCopying, kORDERISTAKEN as NSCopying]) as! [String : Any]
}
