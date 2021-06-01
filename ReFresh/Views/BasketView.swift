//
//  Basket.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/24/21.
//

import SwiftUI

struct BasketView: View {
    
    @ObservedObject var basketListener = BasketListener()
    @State private var showOrderAlert = false
    @State private var orderDate: Date = Date()
    @State private var toGo = false
    @State private var checkoutPressed = 0
    
    let minDate = Calendar.current.date(byAdding: .day, value: 0 ,to: Date())!
    let maxDate = Calendar.current.date(byAdding: .day, value: 1 ,to: Date())!
    
    var totalPrice: Double{
        let total = basketListener.orderBasket.total
        return total
    }
    
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM , HH:mm"
        return formatter
    }
    
    var orderDateString: String{
        return dateFormatter.string(from: orderDate)
    }
    
    var body: some View {
        
        NavigationView{
            Form{
                Section{
                    ForEach(self.basketListener.orderBasket?.items ?? []){
                        drink in HStack{
                            Image(drink.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 65, height: 45)
                                .cornerRadius(10)
                            VStack(alignment: .leading){
                                Text(drink.name)
                                    //.padding(.bottom, -2)
                                    .font(.headline)
                                Text("\(drink.price.clean) lei / pahar") .font(.footnote)
                            } .padding(.leading, 10)
                        } //hstack end
                    }.onDelete(perform: { (indexSet) in
                        self.deleteItems(at: indexSet)
                    })
                }
                
                Section(header: Text("Alege optiunea de livrare")){
                    
                    HStack{
                        Text("Data ridicare")
                        DatePicker("",selection: $orderDate, in: minDate...maxDate)
                            .padding(.leading, -5)
                    }
                    Toggle(isOn: $toGo){ Text("Comanda to Go")}
                    Label("Plata se va efectua la ridicarea comenzii", systemImage: "info.circle")
                        .shadow(radius: 9)
                        .font(.footnote)
                }
                
                Section(header: HStack{
                    Spacer()
                    Text("Total: \(totalPrice.clean) lei") .font(.title2) .padding(.leading, 10) .padding(.bottom, 10)
                    Spacer()
                }){
                    Button(action:{
                        self.showOrderAlert.toggle()
                        self.createOrder()
                        self.emptyBasket()
                    }) {
                        HStack{
                            Spacer()
                            Text("Plaseaza comanda")
                                .font(.title2)
                            Spacer()
                        }
                        
                    }
                }.disabled(self.basketListener.orderBasket?.items.isEmpty ?? true)
            }//form end
            
            .navigationBarTitle(Text("Comanda ta")) .listStyle(GroupedListStyle())
        } .alert(isPresented: $showOrderAlert){ Alert(title: Text("Comanda a fost plasata"), message: Text("Va multumim!"))}
    } //body end
    
    private func createOrder(){
        let order = OnlineOrder()
        order.amount = totalPrice
        order.id = UUID().uuidString
        order.customerFullName = User.currentUser()!.fullName
        order.customerPhone = User.currentUser()!.phoneNumber
        order.orderDate = orderDateString
        order.toGo = toGo
        order.orderItems = self.basketListener.orderBasket.items
        order.saveOnlineOrderToFirestore()
    }
    private func emptyBasket(){
        self.basketListener.orderBasket.emptyBasket()
        self.orderDate = Date()
        self.toGo = false
    }
    func deleteItems(at offsets: IndexSet){
        self.basketListener.orderBasket.items.remove(at: offsets.first!)
        self.basketListener.orderBasket.saveBasketToFirestore()}
}

struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView()
    }
}
