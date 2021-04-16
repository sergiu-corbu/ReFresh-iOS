//
//  Drinks.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/24/21.
//

import SwiftUI

struct Drinks: View {
    
    @ObservedObject var drinkListener = DrinkListener()
    
    var categories: [String: [Drink]]{
        .init(grouping: drinkListener.drinks, by: {$0.category.rawValue})
    }
    
    var body: some View {
        NavigationView{
            // Maybe embed a lazyVstack? 
            List(categories.keys.sorted(), id:\String.self){
                key in DrinkRow(categoryName: "\(key)".uppercased(), drinks: self.categories[key]!)
                    .frame(height: 320)
                    .padding(.top, -2)
                    .padding(.bottom, -5)
            }
            .navigationBarTitle(Text("Produsele ReFresh"))
        }
    }
}

struct Drinks_Previews: PreviewProvider {
    static var previews: some View {
        Drinks()
    }
}

struct DrinkItem: View {
    
    var drink: Drink
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(drink.imageName)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 170)
                .cornerRadius(12)
                .shadow(radius: 11)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(drink.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                
            }
        }
    }
}


struct DrinkRow: View {
    
    var categoryName: String
    var drinks: [Drink]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.categoryName)
                .font(.title)
                .foregroundColor(.primary)
            
            ScrollView(.horizontal, showsIndicators: true){
                HStack{
                    ForEach(self.drinks) { drink in
                        NavigationLink(
                            destination: DrinkDetail(drink: drink)){
                            DrinkItem(drink: drink)
                                .frame(width: 300)
                                .padding(.trailing, 20)
                        }
                    }
                }
            }
        }
    }
}
