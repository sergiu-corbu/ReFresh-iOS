//
//  SignUp.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 2/8/21.
//

import SwiftUI

struct SignUp: View {
    
    @State var email = ""
    @State var password = ""
    @State var repeatpassword = ""
    @State var showSignUp = true
    @State var showFinishReg = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            if showSignUp{
                Text("Inregistrare")
                    .fontWeight(.medium)
                    .font(.largeTitle)
                    .padding([.bottom, .top], 20)
            } else {
                Text("Conectare")
                    .fontWeight(.medium)
                    .font(.largeTitle)
                    .padding([.bottom, .top], 20)
            }
            
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text("Email")
                        .font(.headline)
                        .fontWeight(.light)
                        .opacity(0.75)
                    TextField("Introduceti emailul", text: $email)
                    Divider()
                    Text("Parola")
                        .font(.headline)
                        .fontWeight(.light)
                        .opacity(0.75)
                    SecureField("Setati o parola", text: $password)
                    Divider()
                    
                    if showSignUp{
                        Text("Reintroduceti parola")
                            .font(.headline)
                            .fontWeight(.light)
                            .opacity(0.75)
                        SecureField("Confirmare parola", text: $repeatpassword)
                        Divider()
                    }
                }// 2nd vstack end
                .padding(.bottom, 15)
                .animation(.easeIn(duration: 0.14))
                HStack{
                    Spacer()
                    Button(action: {self.resetPassword()}, label: {
                            Text("Reseteaza parola")
                                .foregroundColor(Color.gray.opacity(0.7)) })
                }
                
                
                
            }// 1st vstack end
            .padding(.horizontal, 12)
            
            Button(action: {
                self.showSignUp ? self.signUpUser() : self.loginUser()
            }, label: {
                Text(showSignUp ? "Inregistrare" : "Conectare")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 250)
                    .padding()
            }) //button end
            .background(Color.orange)
            .cornerRadius(20)
            .padding(.top, 45)
            
            SignInView(showSignIn: $showSignUp)
            
        } // main vstack end
        .sheet(isPresented: $showFinishReg){
            FinishRegistration()
        }
    } //body end
    
    private func loginUser(){
        if email != "" && password != ""{
            User.loginUserWith(email: email, password: password) { (error, isEmailVerified) in
                if error != nil{
                    print("error logging user", error!.localizedDescription)
                    return
                }
                if User.currentUser() != nil && User.currentUser()!.onBoarding{
                    self.presentationMode.wrappedValue.dismiss()
                } else{
                    self.showFinishReg.toggle()
                }
            }
        }
    }
    
    private func signUpUser(){
        if email != "" && password != "" && repeatpassword != "" {
            if password == repeatpassword{
                User.registerUserWith(email: email, password: password) { (error) in
                    if error != nil{
                        print("error registring user:", error!.localizedDescription)
                        return
                    }
                    print("user created")
                    //go back to the app
                    //if user onboarding is done
                }
            } else { print("Emain and password must be set") }
            
        } else { print("Passwords don't mathc") }
       
    }
    
    private func resetPassword(){
        if email != ""{
            User.resetPassword(email: email){(error) in
                if error != nil{
                    print("error sending reset password", error!.localizedDescription)
                    return
                }
                print("please check your email")
            }
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}


struct SignInView: View{
    
    @Binding var showSignIn: Bool
    
    var body: some View{
        VStack{
            Spacer()
            HStack(spacing: 8){
                if showSignIn{
                    Text("Ai cont?")
                        .foregroundColor(Color.gray.opacity(0.5))
                    Button(action: {
                        self.showSignIn.toggle()
                    }, label: {
                        Text("Conecteaza-te")
                            .foregroundColor(.blue)})
                }
                else{
                    Text("Nu ai cont?")
                        .foregroundColor(Color.gray.opacity(0.5))
                    Button(action: {
                        self.showSignIn.toggle()
                    }, label: {
                        Text("Inregistreaza-te")
                            .foregroundColor(.blue)})
                }
            }//hstack end
            .padding([.top, .bottom], 25)
        } //vstack end
    }
}
