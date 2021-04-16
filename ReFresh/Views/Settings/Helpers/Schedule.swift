//
//  ReusableCell.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 2/22/21.
//

import SwiftUI

struct Schedule: View {
    
    var icon: String
    var label1: String
    var label2: String
    
    var body: some View {
        
        HStack{
            Image(systemName:icon)
            Text(label1)
                .font(.headline)
            Spacer()
            Text(label2)
                .font(.subheadline)
        }
    }
}
