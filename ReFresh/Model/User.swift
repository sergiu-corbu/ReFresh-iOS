//
//  User.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/26/21.
//

import Foundation
import FirebaseAuth

class User{
    let id: String
    var email: String
    var fullName: String
    var phoneNumber: String
    var onBoarding: Bool
    
    init(_id: String, _email: String, _fullName: String, _phoneNumber: String){
        id = _id
        email = _email
        fullName = _fullName
        phoneNumber = _phoneNumber
        onBoarding = false
    }
    
    init(_ dictionary : NSDictionary){
        id = dictionary[kID] as? String ?? ""
        email = dictionary[kEMAIL] as? String ?? ""
        fullName = dictionary[kFULLNAME] as? String ?? ""
        phoneNumber = dictionary[kPHONENUMBER] as? String ?? ""
        onBoarding = dictionary[kONBOARD] as? Bool ?? false
    }
    
    class func currentId() -> String{
        return Auth.auth().currentUser!.uid
    }
    
    class func currentUser() -> User?{
        if Auth.auth().currentUser != nil{
            if let dictionary = userDefaults.object(forKey: kCURRENTUSER){
                return User.init(dictionary as! NSDictionary)
            }
        }
        return nil
    }
    
    class func loginUserWith(email: String, password: String, completion: @escaping(_ error: Error?, _ isEmailVerified: Bool) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            if error == nil{
                if authDataResult!.user.isEmailVerified{
                    downloadUserFromFirestore(userId: authDataResult!.user.uid, email: email) { (error) in
                        completion(error, true)
                    }
                }else{ completion(error, false) }
            }else{ completion(error, false) }
        }
    }
    
    class func registerUserWith(email: String, password: String, completion: @escaping(_ error: Error?)-> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            completion(error)
            if error == nil{
                authDataResult!.user.sendEmailVerification { (error) in
                    print("verification email sent error is: ", error?.localizedDescription)
                }
            }
        }
    }
    
    class func resetPassword(email: String, completion: @escaping (_ error: Error?) -> Void){
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            completion(error)
        }
    }
    
    class func logOutUser(completion: @escaping (_ error: Error?) -> Void){
        do{
            try Auth.auth().signOut()
            userDefaults.removeObject(forKey: kCURRENTUSER)
            userDefaults.synchronize()
            completion(nil)
        } catch let error as Error{ completion(error) }
    }
}

public func downloadUserFromFirestore(userId: String, email: String, completion: @escaping (_ error: Error?) -> Void){
    FirebaseReference(.User).document(userId).getDocument { (snapshot, error) in
        guard let snapshot = snapshot else {return}
        if snapshot.exists{
            saveUserLocally(userDictionary: snapshot.data()! as NSDictionary)
        }else{
            let user = User(_id: userId, _email: email, _fullName: "", _phoneNumber: "")
            saveUserLocally(userDictionary: userDictionaryFrom(user: user) as NSDictionary)
            saveUserToFirestore(user: user)
        }
        completion(error)
    }
}

func saveUserToFirestore(user: User){
    FirebaseReference(.User).document(user.id).setData(userDictionaryFrom(user: user)){
        (error) in
        if error != nil{ print("error creating user") }
    }
}

func saveUserLocally(userDictionary: NSDictionary){
    userDefaults.set(userDictionary, forKey: kCURRENTUSER)
    userDefaults.synchronize()
}

func userDictionaryFrom(user: User) -> [String : Any]{
    return NSDictionary(objects: [user.id, user.email, user.fullName, user.phoneNumber, user.onBoarding], forKeys: [kID as NSCopying,kEMAIL as NSCopying, kFULLNAME as NSCopying, kPHONENUMBER as NSCopying, kONBOARD as NSCopying]) as! [String : Any]
}

func updateCurrentUser(withValues: [String : Any], completion: @escaping(_ error: Error?) -> Void){
    if let dictionary = userDefaults.object(forKey: kCURRENTUSER){
        let userObject = (dictionary as! NSDictionary).mutableCopy() as! NSMutableDictionary
        userObject.setValuesForKeys(withValues)
        FirebaseReference(.User).document(User.currentId()).updateData(withValues) { (error) in
            completion(error)
            if error == nil{
                saveUserLocally(userDictionary: userObject)
            }
        }
    }
}
