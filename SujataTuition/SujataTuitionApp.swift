//
//  SujataTuitionApp.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 15/07/23.
//

import SwiftUI

@main
struct SujataTuitionApp: App {
    //let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    @StateObject private var studentController = StudentController()
    @StateObject private var sessionController = SessionController()
    var body: some Scene{
        WindowGroup{
            ContentView(studentController: studentController, sessionController: sessionController)
            //.environment(\.managedObjectContext, itemController.container.viewContext)
            //.environment(\.managedObjectContext, billController.container.viewContext)
                .environmentObject(studentController)
                .environmentObject(sessionController)
        }
        .onChange(of: scenePhase){ _ in
            studentController.save(context: studentController.container.viewContext)
            sessionController.save(context: sessionController.container.viewContext)
        }
    }    
}
