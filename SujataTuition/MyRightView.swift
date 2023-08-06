//
//  MyRightView.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 03/08/23.
//

import Foundation
import SwiftUI
import MessageUI
import UIKit

struct MyRightView: View{
    //let titleright: String
    @State private var feedback = ""
    
    var body: some View{
        VStack{
            Text("Sign in")
            Divider()
            Text("AVAILABLE ONLY ON iPad")
            Text("DURATION OF EACH SESSION IS 1 HOUR")
            Text("EACH SUBJECT HAS 70 SESSIONS APPROX.")
            Text("COST PER SUBJECT IS Rs. 30,000/-")
            Text("THE ENROLLED COURSE IS ACTIVE FOR A YEAR FROM DATE OF JOINING")
            Text("EACH SESSION CAN BE VIEWED ONCE AT ANY TIME")
            Button(action: {
               EmailController.shared.sendEmail(subject: "Hello", body: "Hello From ishtiz.com", to: "sujatact@gmail.com")
             }) {
                 TextField("Contact US", text: $feedback)
                     .multilineTextAlignment(.leading)
             }
        }
        //.navigationViewStyle(StackNavigationViewStyle())
    }
    /*        List {
     ForEach(items) { item in
     NavigationLink {
     Text("Item at \(item.timestamp!, formatter: itemFormatter)")
     } label: {
     Text(item.timestamp!, formatter: itemFormatter)
     }
     }
     .onDelete(perform: deleteItems)
     }
     .toolbar {
     ToolbarItem(placement: .navigationBarTrailing) {
     EditButton()
     }
     ToolbarItem {
     Button(action: addItem) {
     Label("Add Item", systemImage: "plus")
     }
     }
     }
     Text("Select an item")
     */
}
        
    //    Now add a button action to send the email:


struct MyRightView_Previews: PreviewProvider {
    static var previews: some View {
        MyRightView()
    }
}
