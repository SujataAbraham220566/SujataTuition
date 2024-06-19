//
//  AddStudentView.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 02/03/24.
//

import SwiftUI
import Foundation
import CoreData

struct AddStudentView: View{
    let studentController: StudentController
    //@Environment(\.managedObjectContext) var managedObjContext1
    @Environment(\.dismiss) var dismiss
    @Binding var needsRefresh: Bool
    
    //var item: FetchedResults<Items>.Element
    //@State private var isPresentingEditView = false
    @State private var doj = Date()
    @State private var name = ""
    @State private var email = ""
    @State private var state = ""
    //@State private var photo = UIImage()
    @State private var country = ""
    //UIImage? = UIImage(named: "Sujata")
    @State private var studentid = UUID()
    @State var image: Image? = Image("Sujata")
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    
    var body: some View {
        Form{
            VStack {
                HStack{
                    Text("Student Name")
                    Spacer()
                    TextField("Student Name", text: $name)
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack{
                    Text("Mail")
                    Spacer()
                    TextField("Mail", text: $email)
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack{
                    Text("Date of joining")
                    Spacer()
                    TextField("doj", value: $doj, format: .dateTime)
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack{
                    Text("State")
                    Spacer()
                    TextField("State", text: $state)
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack{
                    Text("Country")
                    Spacer()
                    TextField("Country", text: $country)
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                /*image!
                 //Image("photo")
                 .resizable()
                 .aspectRatio(contentMode: .fill)
                 .frame(width: 300, height: 300)
                 .clipShape(Circle())
                 .overlay(Circle().stroke(Color.white, lineWidth: 4))
                 .shadow(radius: 10)
                 .onTapGesture { self.shouldPresentActionScheet = true }
                 .sheet(isPresented: $shouldPresentImagePicker) {
                 SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$image, isPresented: self.$shouldPresentImagePicker, photo: self.$photo)
                 }.actionSheet(isPresented: $shouldPresentActionScheet) { () ->   ActionSheet in
                 ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                 self.shouldPresentImagePicker = true
                 self.shouldPresentCamera = true
                 }), ActionSheet.Button.default(Text("Photo Library"), action: {
                 self.shouldPresentImagePicker = true
                 self.shouldPresentCamera = false
                 }),
                 ActionSheet.Button.cancel()])
                 }
                 /*                  Spacer()
                  TextField("Photo", value: $photo)
                  .font(.headline)
                  .foregroundColor(.accentColor)*/
                 }*/
                //Spacer()
                //.foregroundColor(.accentColor)
                
                HStack{
                    Spacer()
                    Button("Submit"){
                        print("before add")
                        //clBal = opBal + itemsAdded - itemsSold - itemsReturned
                        studentid = studentController.addStudent(name: name, state: state, email: email, country: country, doj: doj)
                        //, context: itemController.container.viewContext)
                        print("after add")
                        studentController.updateStudent()
                        print("after update")
                        needsRefresh.toggle()
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}
/*struct AddStudentView_Previews: PreviewProvider {
    static var previews: some View {
        AddStudentView(studentController: studentController, needsRefresh: false)
    }
}*/

