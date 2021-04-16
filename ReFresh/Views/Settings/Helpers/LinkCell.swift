//
//  ReusableCell1.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 2/22/21.
//

import SwiftUI

struct LinkCell: View {
    
    var icon: String
    var text: String
    var link: String
    var text1: String

    var body: some View {
        HStack{
            Image(systemName: icon)
            Text(text)
                .font(.headline)
            Spacer()
            Button(action: {guard let url = URL(string: self.link), UIApplication.shared.canOpenURL(url) else{ return }
                    UIApplication.shared.open(url as URL)}, label: {
                Text(text1)
                    .foregroundColor(.primary)
            })
    
        }
    }
}

struct LinkCell_Previews: PreviewProvider {
    static var previews: some View {
        LinkCell(icon: "ig", text: "Website", link: "https://google.com", text1: "")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
