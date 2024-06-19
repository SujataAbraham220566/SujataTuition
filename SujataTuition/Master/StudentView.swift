//
//  StudentView.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 02/03/24.
//

import Foundation
import SwiftUI
import CoreData

struct StudentView: View {
    //@Environment(\.managedObjectContext) var managedObjContext1
    let studentController: StudentController
    let sessionController: SessionController
    //@FetchRequest(entity: Students.entity(), sortDescriptors: []) var students: FetchedResults<Students>
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
                    ForEach(students, id:\.self) { student in
                        NavigationLink(destination: EditStudentView()) {
                            VStack(alignment: .leading){
                                HStack{
                                    Text("\(String(describing: student.name!))")
                                        .accessibilityAddTraits(.isHeader)
                                        .font(.headline)
                                    Text("\(String(describing: student.state))")
                                        .labelStyle(.titleAndIcon)
                                        .font(.caption)
                                    Text("\(String(describing: student.doj))")
                                        .labelStyle(.titleAndIcon)
                                        .font(.caption)
                                }
                                HStack{
                                    Text("\(String(describing: student.state))")
                                        .labelStyle(.titleAndIcon)
                                        .font(.caption)
                                    Text("\(String(describing: student.country))")
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
                            let student = students[index]
                            studentController.deleteStudent(student: student)
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
            .navigationTitle("Student Sessions")
            //.onAppear(perform: {
            //    items = itemController.getAllItems()
            //})
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        showingAddView.toggle()
                    } label: {
                        Label("Add Student", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView){
                AddStudentView(studentController: studentController, needsRefresh: $needsRefresh)
            }
        }
        .navigationViewStyle(.stack)
    }

    private func deleteStudent(Offsets: IndexSet){
        withAnimation{
            Offsets.map{students[$0]}.forEach(studentController.container.viewContext.delete)
            StudentController().save(context: studentController.container.viewContext)
            SessionController().save(context: sessionController.container.viewContext)
        }
    }
}
   
/*struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        MasterView(studentController: studentController, sessionController: sessionController)
    }
}
*/
