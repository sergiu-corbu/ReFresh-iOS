//
//  ContentView.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/20/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    var body: some View {
        if User.currentUser() != nil && User.currentUser()!.onBoarding {
            AppView()
        } else if User.currentUser() != nil {
            FinishRegistration()
        } else { SignUp() }
       /* VStack{
            if User.currentUser() != nil && User.currentUser()!.onBoarding{
               
            } else if User.currentUser() != nil{
                FinishRegistration()
            } else { SignUp()}
        }*/
    }
}

struct AppView: View {
    var body: some View {
        TabView{
            Drinks() .tabItem { Image(systemName: "homepod")
                Text("Produse")}
            Search() .tabItem { Image(systemName: "magnifyingglass")
                Text("Cauta")}
            BasketView() .tabItem { Image(systemName: "bag")
                Text("Comanda") }
            Settings() .tabItem { Image(systemName: "gear")
                Text("Setari")}
        }
        .accentColor(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
