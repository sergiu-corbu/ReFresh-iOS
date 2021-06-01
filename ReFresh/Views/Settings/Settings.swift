//
//  User.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/24/21.
//

import SwiftUI

struct Settings: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section{
                        NavigationLink(
                            destination: Account()){
                        Button(action:{ }){
                            SettingsCell(title: "Info client", imgName: "info.circle", clr: .red)
                                .foregroundColor(colorScheme == .dark ? .white : .black) }
                        }
                        
                        NavigationLink(
                            destination: ContactUs()){
                            Button(action:{}){
                                SettingsCell(title: "Despre ReFresh", imgName: "map", clr: .red)
                                    .foregroundColor(colorScheme == .dark ? .white : .black) }
                        }
                       
                        NavigationLink(
                            destination: CustomOrders()){
                        Button(action:{}){
                            SettingsCell(title: "Comenzi personalizate", imgName: "bag", clr: .red)
                                .foregroundColor(colorScheme == .dark ? .white : .black) }
                        }
                    }
                    .padding(.all, 9)
                    
                    Section{
                        NavigationLink(
                            destination: ContactUs()){
                        Button(action:{}){
                            SettingsCell(title: "Termeni si conditii", imgName: "hand.raised", clr: .red)
                                .foregroundColor(colorScheme == .dark ? .white : .black)}
                        }
                        
                        NavigationLink(
                            destination: ContactUs()){
                        Button(action:{createMenu() }){
                            SettingsCell(title: "Distribuie aplicatia", imgName: "square.and.arrow.up", clr: .red)
                                .foregroundColor(colorScheme == .dark ? .white : .black)}
                        }
                        
                        HStack{
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.red)
                                .padding(.trailing, 12)
                            Button(action: {
                                createMenu()
                               // User.logOutUser { (error) in
                              //      print("error logging out user", error?.localizedDescription)
                             //   }
                            }, label: {
                                Text("Deconectare")
                                    .foregroundColor(.red)
                                    .font(.headline)
                                    .bold()
                            })
                        }
                      
                        
                    }
                    .padding(.all, 9)
                } // form end
                .navigationBarTitle(Text("Setari"))

            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
            .preferredColorScheme(.light)
    }
}
