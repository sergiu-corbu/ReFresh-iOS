//
//  Account.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 2/8/21.
//

import SwiftUI

struct Account: View {
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            Text("Salut")
        }
        .navigationBarTitle(Text("Salut, \(User.currentUser()!.fullName)"))

    }
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Account()
    }
}
