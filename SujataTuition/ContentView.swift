//
//  ContentView.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 15/07/23.
//

import SwiftUI
import CoreData
import UIKit
import MessageUI

struct ContentView: View {
    let studentController: StudentController
    let sessionController: SessionController
    //@Environment(\.managedObjectContext) private var viewContext
    //@FetchRequest(
    //    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    //    animation: .default)
    //private var items: FetchedResults<Item>
                    
    var body: some View {
        NavigationSplitView {
            MyLeftView(titleleft: "Sujata Tuition", studentController: studentController, sessionController: sessionController)
            //.frame(width:100, height: 300)
        } detail: {
            MyRightView()
            //.frame(width:100, height: 150)
        }
        /*.onAppear(){
            let storeContainer =
                persistentContainer.persistentStoreCoordinator

            // Delete each existing persistent store
            for store in storeContainer.persistentStores {
                try storeContainer.destroyPersistentStore(
                    at: store.url!,
                    ofType: store.type,
                    options: nil
                )
            }

            // Re-create the persistent container
            persistentContainer = NSPersistentContainer(
                name: "StudentModel" // the name of
                // a .xcdatamodeld file
            )

            // Calling loadPersistentStores will re-create the
            // persistent stores
            /*persistentContainer.loadPersistentStores {
                (store, error) in
                // Handle errors
            }*/
        }*/
    }
        
}



                /*    private func addItem() {
                        withAnimation {
                            let newItem = Item(context: viewContext)
                            newItem.timestamp = Date()

                            do {
                                try viewContext.save()
                            } catch {
                                // Replace this implementation with code to handle the error appropriately.
                                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
                        }
                    }

                    private func deleteItems(offsets: IndexSet) {
                        withAnimation {
                            offsets.map { items[$0] }.forEach(viewContext.delete)

                            do {
                                try viewContext.save()
                            } catch {
                                // Replace this implementation with code to handle the error appropriately.
                                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
                        }
                    }
                }

                private let itemFormatter: DateFormatter = {
                    let formatter = DateFormatter()
                    formatter.dateStyle = .short
                    formatter.timeStyle = .medium
                    return formatter
                }()
                */
                /*struct ContentView_Previews: PreviewProvider {
                    static var previews: some View {
                        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                    }
                }
                */

