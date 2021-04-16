//
//  FinishRegistration.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 2/1/21.
//

import SwiftUI

struct FinishRegistration: View {
    
    @State var fullName = ""
    @State var phone = ""
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Form{
            Section(){
                
                Text("Introduceti datele de contact")
                    .fontWeight(.medium)
                    .font(.headline)
                    .padding([.top,.bottom],15)
                TextField("Nume complet", text: $fullName)
                TextField("Telefon", text: $phone)
                
            } //section end
            
            Button(action: {
                finishRegistration()
            }, label: {
                Text("Finalizare inregistrare")
                    .frame(alignment: .center)
            }).disabled(!self.fieldsCompleted())
        }
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)//form end
       // .frame(width: 400, height: 500)
    }
    private func fieldsCompleted() -> Bool{
        return self.fullName != "" && self.phone != ""
    }
    
    private func finishRegistration(){
        updateCurrentUser(withValues: [kFULLNAME: fullName, kPHONENUMBER: phone, kONBOARD: true]) { (error) in
            if error != nil{
                print("error updating user", error!.localizedDescription)
                return
            }
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct FinishRegistration_Previews: PreviewProvider {
    static var previews: some View {
        FinishRegistration()
    }
}
