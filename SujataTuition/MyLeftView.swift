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
//import AVKit

//import MessageUI

//@available(iOS 17.0, *)
struct MyLeftView: View{
    //: UIImage? = UIImage(named: "Sujata")
    let titleleft: String
   let studentController: StudentController
    let sessionController: SessionController
    let pwdController: PwdController
    let videoController: VideoController
    //var testPlayer: AVPlayer!
    //let userAuth: UserAuth
    //let email: EmailController
    //@EnvironmentObject var userAuth: UserAuth
    //let userId: String
    //let email: String
    @StateObject var storeKit: StoreKitManager = StoreKitManager()
    //@StateObject var videoKit: VideoManager = VideoManager()
    //let titleright: String
    //@Binding var needsRefresh: Bool
    //@Environment(\.dismiss) var dismiss
    @State private var feedback = ""
    @State private var password = ""
    @State private var username = ""
    @State private var presentView = false
    @State private var presentStudentView = false
    @State private var presentSessionView = false
    @State private var presentTuitionView = false
    @State private var passwordList: [String] = []
    @State private var path: [String] = []
    @State private var pwds: [PwdFile] = [PwdFile]()

    @Environment(\.colorScheme) var colorScheme
    @State var email: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var userId: String = ""
    //@AppStorage("firstName") var firstName: String = ""
    //@AppStorage("lastName") var lastName: String = ""
    //@AppStorage("userId") var userId: String = ""
    
    @Binding var needsRefresh: Bool
    @Environment(\.dismiss) var dismiss
    @Environment(\.scenePhase) private var scenePhase
    //@State var selectedId: String = ""
    @State var image: Image? = Image("Sujata")
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    @State var classChoice = 0
    @State private var studid = UUID()
    @State private var passwdarray = []
    @State private var name = ""
    @State private var mail = ""
    @State private var state = ""
    @State private var passwd = ""
    //@State private var password = ""
    @State private var country = ""
    @State private var pwd = ""
    enum cLass: String{
        case std6 = "6th"
        case std7 = "7th"
        case std8 = "8th"
    }
    enum subjects: String{
        case Maths = "Maths"
        case Physics = "Physics"
        case Chemistry = "Chemistry"
        //case Biology = "Biology"
    }
    struct subj{
        var Maths: Bool
        var Physics: Bool
        var Chemistry: Bool
        //var Biology: Bool
        init(){
            self.Maths = false
            self.Physics = false
            self.Chemistry = false
            //self.Biology = false
        }
    }
    @State private var somesubj = subj()
    @State var isChecked = false
    @State var selectedOption: Int = 1
    //@State private var asImage = ((image) -> UIImage).self
    
    struct CheckboxToggleStyle: ToggleStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack {
                
                RoundedRectangle(cornerRadius: 5.0)
                    .stroke(lineWidth: 2)
                    .frame(width: 25, height: 25)
                    .cornerRadius(5.0)
                    .overlay {
                        if configuration.isOn {
                            Image(systemName: "checkmark")
                        }
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
        NavigationView{
            
            VStack{
                //Spacer(minLength: 20)
                VStack{
                    //Spacer(minLength: 5)
                    Text("Sujata Classroom")
                        .font(.custom("Borel-Regular", size: 20))    //(Font.headline)
                        .bold()
                        .foregroundColor(Color.red)
                    
                    //Text("  ")
                    VStack{
                        Text("Personalized Online Intensive Coaching Class")
                            .font(.custom("Rubic Doodle shadow", size: 10))
                        //Spacer(minLength: 100)
                        //Text("Sign in")
                        
                        
                        //    Text("                                        ")
                        Text("Foundation for JEE/NEET/Olympiad")
                            .font(.custom("Rubic Doodle shadow", size: 10))
                        
                        
                        // Text("                                        ")
                        Text("Basic to Advanced topics covered for Class VI, VII, VIII")
                            .font(.custom("Rubic Doodle shadow", size: 10))
                    }
                    .frame(width: 300, height: 80, alignment: .center)
                    .foregroundColor(.red)
                    .background(.white)
                    .border(Color.red)
                    .cornerRadius(20)
                }
                Spacer(minLength: 1)
                VStack{
                    Text("Enter your information")
                        .frame(width: 200, height:50, alignment: .center)
                        .foregroundColor(.red)
                    Spacer(minLength: 5)
                    HStack{
                        Text("Your Name       ")
                        //Spacer(minLength: 5)
                        TextField("Your name", text: $name)
                            .frame(width:  200, height: 30, alignment: .leading)
                            .foregroundColor(.red)
                            .background(.white)
                            .border(Color.gray)
                    }
                    //.cornerRadius(5)
                    Spacer(minLength: 1)
                    HStack{
                        Text("E-mail address  ")
                        //Spacer(minLength: 5)
                        TextField("E-mail", text: $mail)
                            .frame(width: 200, height: 30, alignment: .leading)
                            .foregroundColor(.red)
                            .background(.white)
                            .border(Color.gray)
                    }    //.cornerRadius(5)
                    Spacer(minLength: 10)
                    HStack{
                        Text("State           ")
                        //Spacer(minLength: 5)
                        TextField("State", text: $state)
                            .frame(width: 200, height: 30, alignment: .leading)
                            .foregroundColor(.red)
                            .background(.white)
                            .border(Color.gray)
                    }    //.cornerRadius(5)
                    Spacer(minLength: 10)
                    HStack{
                        Text("Country         ")
                        //Spacer(minLength: 5)
                        TextField("Country", text: $country)
                            .frame(width: 200, height: 30, alignment: .leading)
                            .foregroundColor(.red)
                            .background(.white)
                            .border(Color.gray)
                    }
                    Spacer(minLength: 10)    //.cornerRadius(5)
                }
                .frame(width: 700, height: 300)
                .foregroundColor(.gray)
                .border(Color.gray)
                .background(.white)
                .cornerRadius(20)
                
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
                HStack{
                    Text("Classes")
                        .font(.headline)
                        .foregroundColor(.white)
                    RadioButtonView(index: 1, selectedIndex: $selectedOption)
                    //.font(.title)
                    RadioButtonView(index: 2, selectedIndex: $selectedOption)
                    //.font(.title)
                    RadioButtonView(index: 3, selectedIndex: $selectedOption)
                    //.font(.title)
                    //Text("Selected option: \(selectedOption)")
                }
                .foregroundColor(.purple)
                Spacer(minLength: 1)
                HStack{
                    Text("Subjects")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Toggle(isOn: $somesubj.Maths) {
                        Text("Maths")
                            .foregroundColor(.red)
                            .font(.headline)
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    .foregroundColor(.green)
                    
                    Toggle(isOn: $somesubj.Physics) {
                        Text("Physics")
                            .foregroundColor(.red)
                            .font(.headline)
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    .foregroundColor(.green)
                    
                    Toggle(isOn: $somesubj.Chemistry) {
                        Text("Chemistry")
                            .foregroundColor(.red)
                            .font(.headline)
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    .foregroundColor(.green)
                    /*Toggle(isOn: $somesubj.Biology) {
                     Text("Biology")
                     }
                     .toggleStyle(CheckboxToggleStyle())*/
                    //Spacer(minLength: 30)
                }
                
                Spacer(minLength: 1)
                //Spacer(minLength: 1)
                /*VStack{
                    //if !userId.isEmpty{
                    SignInWithAppleButton(.continue){ request in
                        request.requestedScopes = [.email, .fullName]
                    }
                onCompletion: { result in
                    switch(result){
                    case .success(let auth):
                        switch auth.credential{
                        case let credential as ASAuthorizationAppleIDCredential:
                            let userId = credential.user
                            let email = credential.email
                            //let email = tempemail!.replacingOccurrences(of: " ", with: "")
                            let firstName = credential.fullName?.givenName
                            let lastName = credential.fullName?.familyName
                            //userAuth.email = email!
                            self.email = email ?? ""
                            self.userId = userId
                            self.firstName = firstName ?? ""
                            self.lastName = lastName ?? ""
                            backupyourdetails()
                            //self.userId = ""
                            //self.firstName = ""
                            //self.lastName = ""
                            //self.email = ""
                            //userAuth.email = ""
                            //userAuth.login()
                            break
                        default:
                            exit(0)
                        }
                    case .failure( _):
                        break
                    }
                }
                    
                }
                .frame(height: 50)
                .padding()
                .cornerRadius(8)
                .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                Spacer(minLength: 1)*/
                VStack{
                    //Button(action: {
                    NavigationLink(destination: CourseView(studentController: studentController, sessionController: sessionController, pwdController: pwdController, userId: userId, email: email, storeKit: storeKit) ){
                        Text ("ENROLL")
                    }
                }
                /*.onAppear(perform: {
                    storekitupdate(selectedOption, subj.Maths, subj.Physics, subj.Chemistry)
                })*/
                .onTapGesture(perform: {
                    backupyourdetails()
                })
                .foregroundColor(.red)
                .font(.title)
                Spacer(minLength: 1)
                /*VStack{
                    Button(action: clearallDetails, label: {
                        Text("Clear")
                    })
                }*/
                //Spacer(minLength: 1)
                
                /*} else {
                 exit(0)
                 }*/
                
                
                /*VStack{
                 if email == "sujatact@gmail.com"{
                 CheckyourDatabase(studentController: studentController, sessionController: sessionController, pwdController: pwdController, needsRefresh: $needsRefresh)
                 
                 }
                 }*/
                /*Spacer(minLength: 1)
                 VStack{
                 if !(userId == ""){
                 Text("Your datails have been shared")
                 .font(.caption)
                 .foregroundColor(.red)
                 }
                 }*/
                 //Spacer(minLength: 1)
                 VStack{
                     NavigationLink(destination: TuitionView(studentController: studentController, sessionController: sessionController, pwdController: pwdController, studid: studid, password: password)){
                         Text("LOGIN")
                     }
                     .foregroundColor(.red)
                     .font(.title)
                 }
                Spacer(minLength: 30)
            }
            .background(.blue)
        }//.on (perform: clearallDetails)
    }
    
    
    //struct signInButton: View{
    /*     var body: some View{
     //if userId.isEmpty{
     SignInWithAppleButton(.continue){ request in
     request.requestedScopes = [.email, .fullName]
     }
     onCompletion: { result in
     switch(result){
     case .success(let auth):
     switch auth.credential{
     case let credential as ASAuthorizationAppleIDCredential:
     let userId = credential.user
     let email = credential.email
     let firstName = credential.fullName?.givenName
     let lastName = credential.fullName?.familyName
     self.email = email ?? ""
     self.userId = userId
     self.firstName = firstName ?? ""
     self.lastName = lastName ?? ""
     backupyourdetails()
     break
     default:
     break
     }
     case .failure(let error):
     break
     }
     }
     .frame(height: 50)
     .padding()
     .cornerRadius(8)
     .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
     //backupyourdetails()
     
     }
     }
     */
    /*func storekitupdate(){
        var storekit = StoreKitManager(subj.Maths,
        )
    }*/
    
    func backupyourdetails(){
        print("before add")
        //print(photo)
        /*if let im = image{
         print(im)
         }*/
        //print("photo")
        //photo = asImage(image!)
        studid = studentController.addStudent(name: name, state: state, email: mail, country: country, doj: Date())
        //passwd = String(arc4random())
        passwdarray.append(userId)
        pwdController.addPwd(pwd: userId, id: studid)
        
        print("after add")
        studentController.updateStudent()
        print("after update")
        //needsRefresh.toggle()
        //dismiss()
        print("before add")
        if somesubj.Maths == true{
            let subject = "Maths"
            sessionController.addSession(grade: String(selectedOption), subject: subject, sessionno: 0, studentid: studid, password: userId)
            print("after add")
            sessionController.updateSession()
            print("after update")
        }
        print("after add1")
        if somesubj.Physics == true{
            let subject = "Physics"
            sessionController.addSession(grade: String(selectedOption), subject: subject, sessionno: 0, studentid: studid, password: userId)
            print("after add")
            sessionController.updateSession()
            print("after update")
        }
        print("after add2")
        if somesubj.Chemistry == true{
            let subject = "Chemistry"
            sessionController.addSession(grade: String(selectedOption), subject: subject, sessionno: 0, studentid: studid, password: userId)
            print("after add")
            sessionController.updateSession()
            print("after update")
        }
        print("after add3")
        /*if somesubj.Biology == true{
         let subject = "Biology"
         sessionController.addSession(grade: selectedId, subject: subject, sessionno: 0, studentid: studid, password: passwd)
         print("after add")
         sessionController.updateSession()
         print("after update")
         }*/
        /*EmailController.shared.sendEmail(subject: "Welcome to Sujata Tuitions", body: "Your username \(name) Your password is \(passwd)", to: "\(mail)")*/
        //scheduleCustomNotification()
        print("after add")
        sessionController.updateSession()
        print("after update")
        print("Signed in")
        //if !(userId == ""){
          //  Text("Your datails have been shared")
                //.font(.caption)
                //.foregroundColor(.red)
        //}
        //userAuth.login()
        //userAuth.email = email
        needsRefresh.toggle()
        clearallDetails()
        //clearallDetails()
        //dismiss()
    }
    
    func clearallDetails(){
        self.userId = ""
        self.firstName = ""
        self.lastName = ""
        self.email = ""
    }
    
    
    /*func scheduleCustomNotification() {
     let content = UNMutableNotificationContent()
     content.title = "name : \(name) \n \(mail) \n \(selectedId) \n Maths \(somesubj.Maths) \n Physics \(somesubj.Physics) \n Chemistry \(somesubj.Chemistry) \n"
     content.body = "\(Date()) \n \(state) \n \(country)"
     
     let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // Schedule notification to appear after 5 seconds
     
     let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
     
     UNUserNotificationCenter.current().add(request) { error in
     if let error = error {
     print("Error scheduling notification: \(error)")
     } else {
     print("Custom notification scheduled successfully.")
     }
     }
     //admin.firestore().collection("messages").add({
     //     to: "+16593993862"
     //body: "Hello"
     //})
     }*/
    
}
//extension UIView {
// This is the function to convert UIView to UIImage
   /* public func asImage(image: Image) -> UIImage? {
        let diameter: CGFloat = 100
        let rect = CGRect(origin: CGPoint.zero,
                          size: CGSize(width: diameter, height: diameter))

        let renderer = UIGraphicsImageRenderer(size: rect.size)
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.path = CGPath(ellipseIn: rect,
                                 transform: nil)
              
        //(bounds: UIView.bounds)
        return renderer.image { rendererContext in
            shapeLayer.render(in: rendererContext.cgContext)
        }
    }
//}
extension Image {
    @MainActor
    func getUIImage(newSize: CGSize) -> UIImage? {
        let image = resizable()
            .scaledToFill()
            .frame(width: newSize.width, height: newSize.height)
            .clipped()
        return ImageRenderer(content: image).uiImage
    }
}*/

/*var myView: some View{
    Image("photo")
}*/

struct RadioButtonView: View {
    var index: Int
    @Binding var selectedIndex: Int
    var body: some View {
        Button(action: {
            selectedIndex = index
        }) {
            HStack{
                Image(systemName: self.selectedIndex == self.index ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(.red)
                Text("std \(index+5)")
                    .font(.headline)
            }
            //.position(x:10)
            .foregroundColor(.green)
            }
        
    }
}

                        
/*struct MyLeftView_Previews: PreviewProvider {
    static var previews: some View {
        MyLeftView(titleleft: "Test", studentController: studentController, sessionController: sessionController)
    }
}*/
//This is working code for sending a communication notification:
