//
//  DrinkDetail.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/25/21.
//

import SwiftUI

struct DrinkDetail: View {
    
    @State private var showingAlert = false
    @State private var zoomed = false
    
    let drink: Drink
    var ingredients: Int {
        return drink.ingredients.count
    }
    var type: String { //switch case
        if drink.category.rawValue == "Sucuri"{
            return "Sucul contine"
        }
        else{
            return "Smoothie-ul contine"
        }
    }
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            Image(drink.imageName)
                .resizable()
                .aspectRatio(contentMode: zoomed ? .fill : .fit)
                .onTapGesture { self.zoomed.toggle() }
                .frame(height: UIScreen.main.bounds.height / 2.8) //maybe geometry reader
               
            VStack(spacing: 0) {
                VStack(alignment: .leading) {
                    Text(drink.name)
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .padding(.top, 1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack{
                    Text("\(drink.price.clean) lei")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.bottom, 3)
                    Text("/ 330 ml")
                        .foregroundColor(.black)
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Spacer()
                    Label(drink.priceInfo, systemImage: "info.circle")
                        .foregroundColor(.yellow)
                        .shadow(radius: 9)
                        .frame(width: 80)
                        .font(.footnote)
                        .padding(.leading, -5)
                }
                .padding(.top, 1)
                .frame(maxWidth: .infinity,alignment: .leading)
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text(drink.description)
                        .foregroundColor(.black)
                        .font(.body) .lineLimit(4)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, -5)
                    
                }
                .padding(.top)
                .frame(maxWidth: .infinity,alignment: .leading)
                
                if #available(iOS 14.0, *) {
                    Label(type, systemImage: "tag")
                        .foregroundColor(.yellow) .shadow(radius: 9)
                        .padding(.top, 20) .padding(.bottom, 5)
                } else {
                    // Fallback on earlier versions
                }
                
                HStack(spacing: 20) {
                    
                    if ingredients == 2{
                        VStack{
                            
                            Text(drink.ingredients[0])
                                .foregroundColor(.orange)
                                .font(.title3)
                            Text(drink.ingredients[1])
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        .padding()
                        .background(Color.black)
                        .cornerRadius(15)
                        .shadow(radius: 9)
                    }
                    
                    else if ingredients == 4{
                        VStack{
                            
                            Text(drink.ingredients[0])
                                .foregroundColor(.orange)
                                .font(.title3)
                            Text(drink.ingredients[1])
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        .padding()
                        .background(Color.black)
                        .cornerRadius(15)
                        .shadow(radius: 9)
                        
                        VStack{
                            
                            Text(drink.ingredients[2])
                                .foregroundColor(.green)
                                .font(.title3)
                            Text(drink.ingredients[3])
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        .padding()
                        .background(Color.black)
                        .cornerRadius(15)
                        .shadow(radius: 9)
                    }
                    
                    else if ingredients == 6{
                        VStack{
                            
                            Text(drink.ingredients[0])
                                .font(.title3)
                                .foregroundColor(.purple)
                            Text(drink.ingredients[1])
                                .font(.caption)
                                .foregroundColor(.red)
                            
                        }
                        .padding()
                        .background(Color.black)
                        .cornerRadius(15)
                        .shadow(radius: 9)
                        
                        VStack{
                            
                            Text(drink.ingredients[2])
                                .foregroundColor(.orange)
                                .font(.title3)
                            
                            Text(drink.ingredients[3])
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        .padding()
                        .background(Color.black)
                        .cornerRadius(15)
                        .shadow(radius: 9)
                        
                        VStack{
                            
                            Text(drink.ingredients[4])
                                .font(.title3)
                                .foregroundColor(.yellow)
                            Text(drink.ingredients[5])
                                .foregroundColor(.red)
                                .font(.caption)
                            
                        }
                        
                    }
                    
                } // hstack end
                .padding(.bottom,10)
                
                HStack{
                    Spacer()
                    OrderButton(showAlert: $showingAlert, drink: drink)
                    Spacer()
                }
                .padding(.top, 25)
                .padding(.bottom, UIScreen.main.bounds.height / 7) //not good
            } //vstack end
            .padding()
            .background(Color.red)
            .cornerRadius(25, corners: [.topLeft, .topRight])
            .edgesIgnoringSafeArea(.bottom)
            .padding(.top, 90) //not good
            .frame(height: UIScreen.main.bounds.width - 10) //not good
        } //scroll end
        .edgesIgnoringSafeArea(.top) //maybe all
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Produsul a fost adaugat in cos"),dismissButton: .default(Text("Ok")))}
    }
}

struct OrderButton: View{
    
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
            Text("Adauga in cos")
        }
        .frame(width: 200, height: 50)
        .foregroundColor(.white)
        .font(.headline)
        .background(Color.orange)
        .cornerRadius(20.0)
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

extension VStack {
    func squareModifiers() {
        self
            .padding()
            .background(Color.black)
            .cornerRadius(15)
            .shadow(radius: 9)
    }
}

struct DrinkDetail_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetail(drink: DrinkMenu.first!)
            .preferredColorScheme(.light)
    }
}
