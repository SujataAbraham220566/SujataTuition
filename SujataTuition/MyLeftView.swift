

//
//  MyLeftView.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 03/08/23.
//

import Foundation
import SwiftUI

struct MyLeftView: View{
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var photo = ""
    let titleleft: String
    let studentController: StudentController
    let sessionController: SessionController
    @State var selectedId: String = ""
    @State private var image: Image? = Image("karthick")
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    @State var classChoice = 0
    enum cLass: String{
        case std6 = "6th"
        case std7 = "7th"
        case std8 = "8th"
    }
    enum subjects: String{
        case Maths = "Maths"
        case Physics = "Physics"
        case Chemistry = "Chemistry"
        case Biology = "Biology"
    }
    struct subj{
        var Maths: Bool
        var Physics: Bool
        var Chemistry: Bool
        var Biology: Bool
        init(){
            self.Maths = false
            self.Physics = false
            self.Chemistry = false
            self.Biology = false
        }
    }
    @State var somesubj = subj()
    @State var isChecked = false
    @State var selectedOption: Int = 1

    
    struct CheckboxToggleStyle: ToggleStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack {

                RoundedRectangle(cornerRadius: 5.0)
                    .stroke(lineWidth: 2)
                    .frame(width: 25, height: 25)
                    .cornerRadius(5.0)
                    .overlay {
                        Image(systemName: configuration.isOn ? "checkmark" : "")
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            configuration.isOn.toggle()
                        }
                    }

                configuration.label

            }
        }
    }
    
    var body: some View{
        VStack{
            Spacer()
            HStack{
                Text("Sujata Tuition")
                    .font(Font.headline)
                    .bold()
                    .foregroundColor(Color.red)
                //Spacer(minLength: 100)
                //Text("Sign in")
            }
            HStack{
                Text("Name")
                TextField("Name", text: $name)
            }
            HStack{
                Text("Email")
                TextField("E-mail id", text: $email)
            }
            HStack{
                Text("Phone")
                TextField("Phone", text: $phone)
            }
            /*Image("photo")
             .resizable()
             .aspectRatio(contentMode: .fit)*/
            HStack{
                Text("Photo")
                image!
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 300)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .onTapGesture { self.shouldPresentActionScheet = true }
                    .sheet(isPresented: $shouldPresentImagePicker) {
                        SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$image, isPresented: self.$shouldPresentImagePicker)
                    }.actionSheet(isPresented: $shouldPresentActionScheet) { () ->   ActionSheet in
                        ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                            self.shouldPresentImagePicker = true
                            self.shouldPresentCamera = true
                        }), ActionSheet.Button.default(Text("Photo Library"), action: {
                            self.shouldPresentImagePicker = true
                            self.shouldPresentCamera = false
                        }), ActionSheet.Button.cancel()])
                    }
            }
            VStack{
                Text("Classes")
                    .font(Font.headline)
                RadioButtonView(index: 1, selectedIndex: $selectedOption)
                RadioButtonView(index: 2, selectedIndex: $selectedOption)
                RadioButtonView(index: 3, selectedIndex: $selectedOption)
                //Text("Selected option: \(selectedOption)")
            }
                    
            VStack(alignment: .leading){
                Text("Subjects")
                    .font(Font.headline)
            
                Toggle(isOn: $somesubj.Maths) {
                    Text("Maths")
                }
                .toggleStyle(CheckboxToggleStyle())
                Toggle(isOn: $somesubj.Physics) {
                    Text("Physics")
                }
                .toggleStyle(CheckboxToggleStyle())
                Toggle(isOn: $somesubj.Chemistry) {
                    Text("Chemistry")
                }
                .toggleStyle(CheckboxToggleStyle())
                Toggle(isOn: $somesubj.Biology) {
                    Text("Biology")
                }
                .toggleStyle(CheckboxToggleStyle())


            VStack(alignment: .center){
                Button("Enroll now", action: enroll)
                    .foregroundColor(Color.red)
                    .font(Font.headline)
                    .italic()
                    .padding(100)
                }
            }
            //.navigationTitle("Sujata Tuition")
            //}//.navigationTitle("Sujata Tution")
            //.navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    func checkboxSelected(id: String, isMarked: Bool) -> String{
        if isMarked {
            print("\(id) is marked: \(isMarked)")
        }
        return id
    }
    /*private func radioGroupCallback(id: String) {
        selectedId = id
        //callback(id)
    }*/
    private func enroll(){
        print("before add")
        //clBal = opBal + itemsAdded - itemsSold - itemsReturned
        /*studentController.addStudent(name: name, phone: phone, email: email, photo: image, doj: Date())
         //, context: itemController.container.viewContext)
         print("after add")
         studentController.updateStudent()
         print("after update")
         //needsRefresh.toggle()
         //dismiss()
         print("before add")
         if somesubj.Maths == true{
         let subject = "Maths"
         sessionController.addSession(grade: selectedId, subject: subject, sessionno: 0, studentid: UUID())
         print("after add")
         sessionController.updateSession()
         print("after update")
         }
         if somesubj.Physics == true{
         let subject = "Physics"
         sessionController.addSession(grade: selectedId, subject: subject, sessionno: 0, studentid: UUID())
         print("after add")
         sessionController.updateSession()
         print("after update")
         }
         if somesubj.Chemistry == true{
         let subject = "Chemistry"
         sessionController.addSession(grade: selectedId, subject: subject, sessionno: 0, studentid: UUID())
         print("after add")
         sessionController.updateSession()
         print("after update")
         }
         if somesubj.Biology == true{
         let subject = "Biology"
         sessionController.addSession(grade: selectedId, subject: subject, sessionno: 0, studentid: UUID())
         print("after add")
         sessionController.updateSession()
         print("after update")
         }
         
         //clBal = opBal + itemsAdded - itemsSold - itemsReturned
         //sessionController.addSession(grade: selectedId, subject: subject, sessionno: 0, studentid: UUID())
         //, context: itemController.container.viewContext)
         print("after add")
         sessionController.updateSession()
         print("after update")*/
    }
}
struct RadioButtonView: View {
    var index: Int
    @Binding var selectedIndex: Int
    var body: some View {
        Button(action: {
            selectedIndex = index
        }) {
            HStack{
                Image(systemName: self.selectedIndex == self.index ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(.black)
                Text("std\(index+5)")
            }
            .position(x:50)
            .foregroundColor(.black)
        }
    }
}

/*struct MyLeftView_Previews: PreviewProvider {
    static var previews: some View {
        MyLeftView(titleleft: "Test", studentController: StudentController, sessionController: SessionController)
    }
}*/
