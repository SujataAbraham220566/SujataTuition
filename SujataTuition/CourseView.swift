//
//  CourseView.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 26/05/24.
//

import Foundation
import SwiftUI
import MessageUI
import CoreData
import StoreKit

//@available(iOS 17.0, *)
struct CourseView: View{
    let studentController: StudentController
    let sessionController: SessionController
    let pwdController: PwdController
    let userId: String
    let email: String
    @StateObject var storeKit: StoreKitManager
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
    @State var isPurchased: Bool = false

    
    var body: some View{
        VStack{
            ForEach(storeKit.storeProducts){ product in
                HStack{
                    Text(product.displayName)
                        Spacer()
                    Button(action:{
                        Task{
                            try await storeKit.purchase(product)
                            
                        }
                    }){
                        CourseItem(storeKit: storeKit, product: product)
                    }
                /*Button("Continue", action: {
                 Task{
                 ProductItem(storeKit: storeKit, product: product)
                 }
                 })*/
                //Spacer()
                   /* Button("Make payment", action: {
                        Task{
                            _ = try await storeKit.purchase(product)
                            //isPurchased = try await storeKit.isPurchased(product)
                            //print(isPurchased, "is purch")
                            //if isPurchased{
                            Text(Image(systemName: "checkmark"))
                                .padding(10)
                        }
                            //} else {
                            Text(product.displayPrice)
                                .padding(10)
                        }
                    })*/
                    /*.onChange (of: storeKit.purchasedCourses, perform: { course in
                        Task{
                            isPurchased = (try? await storeKit.isPurchased(product)) ?? false
                        }
                    })*/
                //CourseItem(storeKit: storeKit, product: product)
            }
            Button("Restore Purchases", action: {
                Task{
                    try? await AppStore.sync()
                }
            })
        }
        .padding()
    }
}
    struct CourseItem: View{
        @ObservedObject var storeKit: StoreKitManager
        @State var isPurchased: Bool = false
        var product: Product
        
        var body: some View{
            VStack{
                if isPurchased{
                    Text(Image(systemName: "checkmark"))
                        .bold()
                        .padding(10)
                } else {
                    Text(product.displayPrice)
                        .padding(10)
                }
            }
            .onChange(of: storeKit.purchasedCourses) { oldCourse, course in
                Task{
                    isPurchased = (try? await storeKit.isPurchased(product)) ?? false
                }
            }
            //.onChange(of: storeKit.purchasedCourses, changePurchase(product: product))
        }
    }
    /*func changePurchase(product: product){
        Task{
            isPurchased = (try? await storeKit.isPurchased(product)) ?? false
        }

    }*/
}

/*struct ProductItem: View{
    @ObservedObject var storeKit: StoreKitManager
    //@State var isPurchased: Bool = false
    var product: Product
        
    var body: some View{
        VStack{
            /*if isPurchased{
                Text(Image(systemName: "checkmark"))
                    .bold()
                    .padding(10)
            } else {*/
                Text(product.displayName)
                    .padding(10)
        }
    }
}*/
