//
//  CustomOrders.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 2/3/21.
//

import SwiftUI
import MessageUI

struct CustomOrders: View {
    
    @State var screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ScrollView{
            GroupBox{
                HStack{
                    Image(systemName: "info.circle")
                        .padding(.leading, -120)
                    Text("Criterii si optiuni")
                        .padding(.leading, -95)
                        .font(.title3)
                }
                .padding(.bottom, -1)
                
                Divider()
                HStack{
                    Text("Clientul nostru, prietenul nostru 😊 \nReFresh vă oferă acum posibilitatea de a comanda produse în cantități mari, la prețuri avantajoase. La orice comandă personalizată de minim 300 de lei, prețul final beneficiind de o reducere. Nu vă faceți griji în legătură cu transportul deoarece este inclus în preț.")
                        .font(.headline)
                        .padding([.bottom, .leading], 10)
                }
                .padding(.top, 10)
            } //box end
            .frame(width: screenWidth - 42)
            .padding(.top, -30)
            
            VStack(alignment: .center,spacing: 0){
                Form{
                    Section(header: Text("Informatii Contact")){
                        
                        LinkCell(icon: "phone", text: "Telefon", link: "", text1: "0773792483 | 0774653234")
                        LinkCell(icon: "globe", text: "Website", link: "https://google.com", text1: "refresh-drinks.ro")
                        NavigationLink( destination: ContactUs()){
                            LinkCell(icon: "homekit", text: "Locatia ReFresh", link: "", text1: "")
                        }
                    }
                }
                .frame(width: screenWidth, height: 235)
            } // contact info
            .padding(.top, 20)
        }
    }
}

struct CustomOrders_Previews: PreviewProvider {
    static var previews: some View {
        CustomOrders()
            .preferredColorScheme(.dark)
    }
}
