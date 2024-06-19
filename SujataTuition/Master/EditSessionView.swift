//
//  EditSessionView.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 02/03/24.
//

import Foundation
import SwiftUI

struct EditSessionView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct EditSessionView_Previews: PreviewProvider {
    static var previews: some View {
        EditSessionView()
    }
}

//
//  ItemView.swift
//  ShopB&S
//
//  Created by Sujata Abraham on 22/07/22.
//
/*
import SwiftUI

struct EditItemView: View{
    //@EnvironmentObject var
    let itemController: ItemController
    //@Environment(\.managedObjectContext) var managedObjContext1
    var item: Items
    @Binding var needsRefresh: Bool
    @Environment(\.dismiss) var dismiss
    //var item: FetchedResults<Items>.Element
    //@State private var isPresentingEditView = false
    @State private var name = ""
    @State private var category = ""
    @State private var price = 0
    @State private var opBal = 0
    @State private var itemsAdded = 0
    @State private var itemsSold = 0
    @State private var itemsReturned = 0
    @State private var clBal = 0

    var body: some View {
        //Form{
            VStack(alignment: .leading){
                HStack{
                    Text("Item Name")
                    Spacer()
                    Text("\(name)")
                        .onAppear{
                        name = item.name!
                        }
                    //.font(.headline)
                    //.foregroundColor(.accentColor)
                }
                HStack{
                    Text("Category")
                    Spacer()
                    Text("\(category)")
                    .onAppear{
                        category = item.category!
                    }
                    //.font(.headline)
                    //.foregroundColor(.accentColor)
                }
                HStack{
                    Text("Price")
                    Spacer()
                    Text("\(price)")
                        .onAppear{
                            price = Int(item.price)
                        }
                    //.font(.headline)
                    //.foregroundColor(.accentColor)
                }
                HStack{
                    Text("Op. Bal")
                    Spacer()
                    Text("\(opBal)")
                        .onAppear{
                            opBal = Int(item.opBal)
                        }
                    //.font(.headline)
                    //.foregroundColor(.accentColor)
                }
                HStack{
                    Text("Items Added         ")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                    TextField("Items Added", value: $itemsAdded, format: .number)
                        .onAppear{
                            itemsAdded = Int(item.itemsAdded)
                        }
                    .font(.headline)
                    .foregroundColor(.accentColor)
                }
                HStack{
                    Text("Items Returned      ")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                    TextField("Items Returned", value: $itemsReturned, format: .number)
                        .onAppear{
                            itemsReturned = Int(item.itemsReturned)
                        }
                    .font(.headline)
                    .foregroundColor(.accentColor)
                }
                HStack{
                    Text("Items Sold")
                    Spacer()
                    Text("\(itemsSold)")
                        .onAppear{
                            itemsSold = Int(item.itemsSold)
                        }
                    //.font(.headline)
                    //.foregroundColor(.accentColor)
                }
                HStack{
                    Text("Cl Bal")
                    Spacer()
                    Text("\(clBal)")
                        .onAppear{
                            clBal = Int(item.opBal) + Int(item.itemsAdded) - Int(item.itemsSold) - Int(item.itemsReturned)
                        }
                        .onSubmit{
                            clBal = Int(item.opBal) + Int(itemsAdded) - Int(item.itemsSold) - Int(itemsReturned)
                        }
                    .font(.headline)
                    //.foregroundColor(.accentColor)
                }
                HStack{
                    Spacer()
                    Button("Submit"){
                        clBal = Int(item.opBal) + Int(itemsAdded) - Int(item.itemsSold) - Int(itemsReturned)
                        itemController.editItem(item: item, name: name, category: category, price: Int16(price), opBal: Int16(opBal), itemsAdded: Int16(itemsAdded), itemsReturned: Int16(itemsReturned), itemsSold: Int16(itemsSold), clBal: Int16(clBal))
                        itemController.updateItem()
                        needsRefresh.toggle()
                        dismiss()
                    }
                    Spacer()
                }
                Spacer()
            }
        //}
    }
}

*/
