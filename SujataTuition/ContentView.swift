//
//  ContentView.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 02/03/24.
//

import SwiftUI
import CoreData
import UIKit
import MessageUI
import AVKit
//import FirebaseInAppMessaging

//@available(iOS 17.0, *)
struct ContentView: View {
    let studentController: StudentController
    let sessionController: SessionController
    let pwdController: PwdController
    let videoController: VideoController
    //@EnvironmentObject var userAuth: UserAuth
    @State private var needsRefresh = false
    //@Environment var window: UIWindow?
    @Environment(\.scenePhase) private var scenePhase
    //@State var path: String = ""
    //@Environment(\.managedObjectContext) private var viewContext
    //@FetchRequest(
    //    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    //    animation: .default)
    //private var items: FetchedResults<Item>
    //private var asImage: (Image) -> UIImage
    
    var body: some View {
        
        //NavigationView {
            /*if userAuth.isLoggedin && userAuth.email == "sujatact@gmail.com"{
                CheckyourDatabase(studentController: studentController, sessionController: sessionController, pwdController: pwdController, needsRefresh: $needsRefresh)
            } else if !userAuth.isLoggedin {*/
        MyLeftView(titleleft: "Sujata tuuutt", studentController: studentController, sessionController: sessionController, pwdController: pwdController, videoController: videoController, needsRefresh: $needsRefresh)
                
        //}
            
        //}
            //.frame(width:100, height: 300)
        //} detail: {
           // MyRightView(studentController: studentController, sessionController: sessionController, pwdController: pwdController, needsRefresh: $needsRefresh)
            //.frame(width:100, height: 150)
        //}
    }
}
        
                
        /*struct ContentView_Previews: PreviewProvider {
                static var previews: some View {
                    ContentView(studentController: studentController, sessionController: sessionController, pwdController: pwdController, needsRefresh: false).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

               }
        }*/
