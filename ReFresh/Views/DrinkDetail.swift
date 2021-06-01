//
//  DrinkDetail.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/25/21.
//

import SwiftUI

let width = UIScreen.main.bounds.width
let height = UIScreen.main.bounds.height

struct DrinkDetail: View {
    
    @State private var showingAlert = false
    
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
       // ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 0) {
                image
            mainBody.padding(.top, -30)
            }
       // }
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Produsul a fost adaugat in cos"),dismissButton: .default(Text("Ok")))}
    }
    
    var image: some View {
        VStack {
            Image(drink.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height / 2.5)
                .edgesIgnoringSafeArea(.top)
            
        }
    }
    
    var mainBody: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color.coralRed)
                    .frame(width: 72, height: 7)
                    .clipped()
                VStack(alignment: .leading, spacing: 10) {
                    Text(drink.name)
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                        .lineLimit(0)
                    HStack {
                        Text("\(drink.price.clean) lei")
                            .font(.title)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .padding(.top, -5)
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
                    Divider()
                    VStack(alignment: .leading) {
                        Text(drink.description)
                            .foregroundColor(.black)
                            .lineLimit(4)
                            .padding(.top, 10)
                    }
                }
                if #available(iOS 14.0, *) {
                    Label(type, systemImage: "tag")
                        .foregroundColor(.yellow) .shadow(radius: 9)
                        .padding(.top, 20) .padding(.bottom, 5)
                }
                ingredientsView
                OrderButton(showAlert: $showingAlert, drink: drink)
                Spacer()
            }
            .padding([.leading, .trailing], 24)
            .background(Color.red)
            .cornerRadius(25, corners: [.topLeft, .topRight])
        }
    }
    
    var ingredientsView: some View {
        HStack(spacing: 20) {
            if ingredients == 2 {
                Ingredients(nrOfIngredients: 1, components: [Ingredient(text: drink.ingredients[0], text2: drink.ingredients[1], color: .orange)])
            }
            
            else if ingredients == 4 {
                Ingredients(nrOfIngredients: 2, components: [Ingredient(text: drink.ingredients[0], text2: drink.ingredients[1], color: .orange),Ingredient(text: drink.ingredients[2], text2: drink.ingredients[3], color: .green)])
            }
            
            else if ingredients == 6 {
                Ingredients(nrOfIngredients: 3, components: [Ingredient(text: drink.ingredients[0], text2: drink.ingredients[1], color: .purple), Ingredient(text: drink.ingredients[2], text2: drink.ingredients[3], color: .coralRed), Ingredient(text: drink.ingredients[4], text2: drink.ingredients[5], color: .yellow)])
            }
        }
        .padding([.bottom, .top], 10)
    }
}

struct Ingredients: View {
    let nrOfIngredients: Int
    let components: [Ingredient]
    var body: some View {
        ForEach(0..<nrOfIngredients ) { item in
            VStack {
                components[item]
            }
        }
        .frame(width: 70, height: 70)
        .background(Color.darkRed)
        .cornerRadius(13)
        .shadow(radius: 9)
    }
}

struct Ingredient: View {
    let text: String
    let text2: String
    let color: Color
    
    var body: some View {
        VStack {
            Text(text)
                .foregroundColor(color)
                .font(.title3)
                .bold()
            Text(text2)
                .foregroundColor(.white)
                .font(.subheadline)
        }
    }
}
