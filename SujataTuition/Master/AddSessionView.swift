//
//  AddSessionView.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 02/03/24.
//

import SwiftUI
import Foundation
import CoreData

struct AddSessionView: View{
    let sessionController: SessionController
    //@Environment(\.managedObjectContext) var managedObjContext1
    @Environment(\.dismiss) var dismiss
    @Binding var needsRefresh: Bool
    
    //var item: FetchedResults<Items>.Element
    //@State private var isPresentingEditView = false
    @State private var grade = ""
    @State private var sessionno = ""
    @State private var subject = ""
    @State private var password = ""
    //@State private var photo = UIImage()
    //@State private var photo: UIImage? = UIImage(named: "Sujata")
    @State private var studentid = UUID()
    @State private var sessionid = UUID()
        
    var body: some View {
        Form{
            VStack {
                HStack{
                    Text("grade")
                    Spacer()
                    TextField("grade", text: $grade)
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack{
                    Text("sessionno")
                    Spacer()
                    TextField("sessionno", text: $sessionno)
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack{
                    Text("subject")
                    Spacer()
                    TextField("subject", text: $subject)
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack{
                    Text("password")
                    Spacer()
                    TextField("password", text: $password)
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                Spacer()
                        //.foregroundColor(.accentColor)
                }
                HStack{
                    Spacer()
                    Button("Submit"){
                        print("before add")
                        //clBal = opBal + itemsAdded - itemsSold - itemsReturned
                        sessionController.addSession(grade: grade, subject: subject, sessionno: Int16(sessionno)!, studentid: studentid, password: password)
                        //, context: itemController.container.viewContext)
                        print("after add")
                        sessionController.updateSession()
                        print("after update")
                        needsRefresh.toggle()
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
