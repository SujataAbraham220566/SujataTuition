//
//  SessionView.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 02/03/24.
//

import Foundation
import SwiftUI
import CoreData

struct SessionView: View {
    //@Environment(\.managedObjectContext) var managedObjContext1
    let studentController: StudentController
    let sessionController: SessionController
    //@FetchRequest(entity: Items.entity(), sortDescriptors: []) var items: FetchedResults<Items>
    @State private var students: [Students] = [Students]()
    @State private var sessions: [Sessions] = [Sessions]()
    @State var needsRefresh: Bool = false
    @Environment(\.scenePhase) private var scenePhase
    //@State private var newItemData = Item.Data()
    @State private var showingAddView = false
    //@State var selectedRow: String?
    //@State var isEditing = false
    private func populateStudentsSessions(){
        students = studentController.getAllStudents()
        sessions = sessionController.getAllSessions()
    }

    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Button("Save"){
                    studentController.save(context: studentController.container.viewContext)
                    students = studentController.getAllStudents()
                    sessionController.save(context: sessionController.container.viewContext)
                    sessions = sessionController.getAllSessions()

                }
                List{
                    ForEach(sessions, id:\.self) { session in
                        NavigationLink(destination: EditSessionView()) {
                            VStack(alignment: .leading){
                                HStack{
                                    Text("\(String(describing: session.grade!))")
                                        .accessibilityAddTraits(.isHeader)
                                        .font(.headline)
                                    Text("\(String(describing: session.subject))")
                                        .labelStyle(.titleAndIcon)
                                        .font(.caption)
                                    Text("\(String(describing: session.sessionno))")
                                        .labelStyle(.titleAndIcon)
                                        .font(.caption)
                                }
                                HStack{
                                    Text("\(String(describing: session.password))")
                                        .labelStyle(.titleAndIcon)
                                        .font(.caption)
                                    Text("\(String(describing: session.studentid))")
                                        .labelStyle(.titleAndIcon)
                                        .font(.caption)
                                    /*Text("\(String(describing: student.grade))")
                                        .labelStyle(.titleAndIcon)
                                        .font(.caption)
                                    Text("\(String(describing: student.subject))")
                                        .labelStyle(.titleAndIcon)
                                        .font(.caption)*/
                                }
                            }
                        }
                    }
                    .onDelete(perform: {indexSet in
                        indexSet.forEach { index in
                            let session = sessions[index]
                            sessionController.deleteSession(session: session)
                            populateStudentsSessions()
                        }
                    })
                    .onAppear(perform: {
                        students = studentController.getAllStudents()
                        sessions = sessionController.getAllSessions()
                    })
                   // .frame(maxWidth: .infinity)
                }
                .listStyle(.plain)
                .accentColor(needsRefresh ? .white : .black)
            }
            .navigationTitle("Sessions")
            //.onAppear(perform: {
            //    items = itemController.getAllItems()
            //})
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        showingAddView.toggle()
                    } label: {
                        Label("Add Session", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView){
                AddSessionView(sessionController: sessionController, needsRefresh: $needsRefresh)
            }
        }
        .navigationViewStyle(.stack)
    }

    private func deleteSession(Offsets: IndexSet){
        withAnimation{
            Offsets.map{students[$0]}.forEach(sessionController.container.viewContext.delete)
            StudentController().save(context: studentController.container.viewContext)
            SessionController().save(context: sessionController.container.viewContext)
        }
    }
}
