//
//  StoreKitManager.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 25/05/24.
//

import Foundation
import StoreKit

class StoreKitManager: ObservableObject{
    @Published var storeProducts: [Product]
    @Published var purchasedCourses: [Product]
    
    var updateListenerTask: Task<Void, Error>? = nil
    private let productDict: [String:String]
    
    public enum StoreError: Error{
        case failedVerification
    }
    
    init(){
        storeProducts = []
        purchasedCourses = []
        /*f let plistPath = Bundle.main.path(forResource: "Products", ofType: "plist"), let plist = FileManager.default.contents(atPath: plistPath){
            productDict = (try? PropertyListSerialization.propertyList(from: plist, format: nil) as? [String:String]) ?? [:]
        } else {
            productDict = [:]
        }*/
        
        productDict = StoreKitManager.loadProductidToDict()
        updateListenerTask = listenForTransactions()
        Task{
            await requestProduct()
            await updateCustomerProductStatus()
        }
    }
    static func loadProductidToDict() -> [String: String]{
        guard let plistPath = Bundle.main.path(forResource: "PropertyList", ofType: "plist"), let plist = FileManager.default.contents(atPath: plistPath),
            let data = try? PropertyListSerialization.propertyList(from: plist, format: nil) as? [String:String]
        else {
            return [:]
        }
        return data
    }
    
    deinit{
        updateListenerTask?.cancel()
    }
    func listenForTransactions() -> Task<Void, Error>{
        return Task.detached{
            for await result in Transaction.updates{
                do{
                    let transaction = try self.checkVerified(result)
                    await self.updateCustomerProductStatus()
                    await transaction.finish()
                } catch {
                    print("Transaction failed verification")
                }
            }
        }
    }
    @MainActor
    func requestProduct() async {
    //func requestProduct() async -> [Product] {
        do{
            storeProducts = try await Product.products(for: productDict.values)
        } catch {
            print("Failed error retrieving products")
        }
        //return storeProducts
    }
    
    func purchase(_ product: Product) async throws -> Transaction?{
        let result = try await product.purchase()
        switch result {
            case .success(let verificationResult):
            let transaction = try checkVerified(verificationResult)
                print(transaction, "trans")
                await updateCustomerProductStatus()
                await transaction.finish()
                return transaction
            case .userCancelled, .pending:
                return nil
            default:
                return nil
        }
    }
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T{
        switch result{
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let signedType):
            return signedType
        }
    }
    @MainActor
    func updateCustomerProductStatus() async {
        //var purchasedCourses: [Product] = []
        for await result in Transaction.currentEntitlements{
            do{
                let transaction = try checkVerified(result)
                if let course = storeProducts.first(where: {$0.id == transaction.productID}){
                    purchasedCourses.append(course)
                    //print(purchasedCourses)
                }
            } catch {
                print("Transaction failed verification")
            }
            self.purchasedCourses = purchasedCourses
        }
    }
    func isPurchased(_ product: Product) async throws -> Bool{
        return purchasedCourses.contains(product)
    }
    
}
