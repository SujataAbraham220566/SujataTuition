//
//  MyLeftView.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 02/03/24.
//
import Foundation
import SwiftUI
import CoreData
import AuthenticationServices
import MessageUI
import StoreKit

enum Class: String {
    case Sixth = "6th"
    case Seventh = "7th"
    case Eight = "8th"
}

enum Subjects: String {
    case Maths = "Maths"
    case Physics = "Physics"
    case Chemistry = "Chemistry"
    //case Biology = "Biology"
}

struct HomeView: View {
    let moc: NSManagedObjectContext
    var storeKitManager = StoreKitManager()
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack{
                    Text("Sujata Classroom")
                        .font(.custom("Borel-Regular", size: 20))    //(Font.headline)
                        .bold()
                        .foregroundColor(Color.red)
                    
                    VStack {
                        Text("Personalized Online Intensive Coaching Class")
                            .font(.custom("Rubic Doodle shadow", size: 10))
                        
                        Text("Foundation for JEE/NEET/Olympiad")
                            .font(.custom("Rubic Doodle shadow", size: 10))
                        
                        Text("Basic to Advanced topics covered for Class VI, VII, VIII")
                            .font(.custom("Rubic Doodle shadow", size: 10))
                    }
                    .frame(width: 300, height: 80, alignment: .center)
                    .foregroundColor(.red)
                    .background(.white)
                    .border(Color.red)
                    .cornerRadius(20)
                }
                
                Spacer(minLength: 5)
                
                HStack{
                    Spacer(minLength: 30)
                    Image("classpicture1")
                        .resizable()
                        .frame(width:150, height: 100, alignment: .center)
                        .colorMultiply(.blue)
                        .scaledToFit()
                    Spacer(minLength: 10)
                    Image("classpicture2")
                        .resizable()
                        .frame(width: 150, height: 100, alignment: .center)
                        .colorMultiply(.blue)
                        .scaledToFit()
                    Spacer(minLength: 10)
                    Image("classpicture3")
                        .resizable()
                        .frame(width: 150, height: 100, alignment: .center)
                        .colorMultiply(.blue)
                        .scaledToFit()
                    Spacer(minLength: 30)
                }
                
                Spacer(minLength: 1)
                
                VStack {
                    NavigationLink(destination: CoursesView()) {
                        Text("ENROLL")
                    }
                }
                .foregroundColor(.red)
                .font(.title)
                
//                Spacer(minLength: 1)
//                
//                NavigationLink(destination: TuitionView()) {
//                    Text("VIEW")
//                }
//                .foregroundColor(.red)
//                .font(.title)
                
                Spacer(minLength: 30)
            }
            .background(.blue)
        }
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
