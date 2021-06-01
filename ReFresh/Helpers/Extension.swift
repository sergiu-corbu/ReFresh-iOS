//
//  Extension.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/25/21.
//

import Foundation
import SwiftUI

extension Double{
    var clean: String{
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%..0f", self) : String(self)
    }
}

extension Color {
    static let coralRed = Color("coralRed")
    static let darkRed = Color("backgroudRed")
    static let darkOrange = Color("darkOrange")
}

struct OrderButton: View {
    
    @Binding var showAlert: Bool
    @ObservedObject var basketListener = BasketListener()
    @Environment(\.presentationMode) var presentationMode
    
    var drink: Drink
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            self.showAlert.toggle()
            self.addItemToBasket()
        }) {
            HStack {
                Text("Adauga in cos")
                Image(systemName: "bag")
            }
        }
        .foregroundColor(.white)
        .font(.headline)
        .frame(width: 200, height: 50)
        .background(Color.darkOrange)
        .cornerRadius(20.0)
        .padding(.top, 20)
    }
    private func addItemToBasket() {
        var orderBasket: Order!
        if self.basketListener.orderBasket != nil {
            orderBasket = self.basketListener.orderBasket
        } else {
            orderBasket = Order()
            orderBasket.customerFullName = User.currentUser()?.fullName
            orderBasket.id = UUID().uuidString
        }
        orderBasket.add(self.drink)
        orderBasket.saveBasketToFirestore()
    }
}
