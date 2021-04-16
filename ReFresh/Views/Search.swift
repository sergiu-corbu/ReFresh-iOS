//
//  Search.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/26/21.
//

import SwiftUI

struct Search: View {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var item = DrinkListener()
    @State var searchText = ""
    @State var isSearching = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                HStack{
                    HStack{
                        TextField("Suc, smoothie si alte produse naturale", text: $searchText)
                            .padding(.leading,28)
                            .padding([.top, .bottom], -3)
                           
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(22)
                    .padding(.top, 10)
                    
                    .padding(.horizontal)
                    .onTapGesture(perform: {
                        isSearching = true
                    })
                    .overlay(
                        HStack{
                            Image(systemName: "magnifyingglass")
                            Spacer()
                            if isSearching{
                                Button(action: {searchText = ""}, label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .padding(.vertical)
                                })
                            }
                            
                        }.padding(.horizontal,32) .padding(.top, 10)
                        
                    ).transition(.move(edge: .trailing))
                    .animation(.spring())
                    .padding(.bottom, 10)
                    if isSearching{
                        Button(action: {
                            isSearching = false
                            searchText = ""
                            
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }, label: {
                            Text("Anulare")
                                .padding(.trailing)
                                .padding(.leading, 0)
                        })
                        .transition(.move(edge: .trailing))
                        .animation(.spring())
                    }
                }
                ForEach((self.item.drinks).filter({ "\($0)".contains(searchText) || searchText.isEmpty}), id: \.self){ item in
                    NavigationLink(destination: DrinkDetail(drink: item)){
                        HStack{
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 70, height: 45)
                                .cornerRadius(10)
                                .padding(.trailing, 10)
                            Text(item.name)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            Spacer()
                        }
                        .padding()
                        .padding(.bottom, -10)
                        Divider()
                            .padding(.leading, 20) .padding(.trailing, 20)
                    }
                }
            } .navigationBarTitle("Cauta")
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
            .preferredColorScheme(.dark)
    }
}
