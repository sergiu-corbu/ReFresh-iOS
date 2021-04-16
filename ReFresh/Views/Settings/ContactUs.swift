//
//  ContactUS.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 2/2/21.
//

import SwiftUI
import CoreLocation

struct ContactUs: View {
    
    @State var screenWidth = UIScreen.main.bounds.width
    @State var date: Date = Date()
    
    var body: some View {
        ScrollView{
            Image("loc")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(15)
            
            VStack(spacing: 10){
                HStack{
                    Text("ReFresh Cluj-Napoca")
                        .font(.title)
                        .fontWeight(.semibold)
                    Spacer()
                }
                HStack{
                    Text("Str. George Baritiu nr 7")
                        .font(.headline)
                    Spacer()
                   // if date
                    Text("Deschis")
                        .foregroundColor(.green)
                       
                        .bold()
                        .padding(.trailing, 120)
                  /*  Text("Inchis")
                        .foregroundColor(.red)
                        .bold()
                        .padding(.trailing, 50)*/
                }
                
            } //info
            .padding(.leading, 15)
            .padding(.bottom, -5)
            .frame(alignment: .leading)
            
            VStack(alignment: .center,spacing: 0){
                Form{
                    Section(header: Text("Program & contact")){
                        Schedule(icon: "calendar", label1: "Luni - Vineri", label2: "8:00 - 20:00")
                        Schedule(icon: "calendar", label1: "Sambata - Duminica", label2: "10:00 - 15:00")
                        LinkCell(icon: "ig", text: "Instagram", link: "https://google.com", text1: "@refresh")
                        LinkCell(icon: "phone", text: "Telefon", link: "", text1: "0773792483")
                        LinkCell(icon: "globe", text: "Website", link: "https://google.com", text1: "refresh-drinks.ro")
                    }
                }
                .frame(width: screenWidth, height: 260)
                
            } // contact info
            
            VStack(alignment: .center, spacing: 0){
                MapView(coordinate: CLLocationCoordinate2D(latitude:46.775439, longitude: 23.587062))
                    .frame(width: 375, height: 200, alignment: .center)
                    .cornerRadius(20)
            } // mapview
            
        }// scroll
        .edgesIgnoringSafeArea(.top)
    }
}

struct ContactUs_Previews: PreviewProvider {
    static var previews: some View {
        ContactUs()
            .preferredColorScheme(.dark)
    }
}

