//
//  TranslationLayer.swift
//  Moview
//
//  Created by Shubham Ojha on 13/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import CoreData

protocol ITranslationLayer {
    func getUnsavedCoreDataObject<T: Decodable>(type: T.Type, data: Data, context: NSManagedObjectContext) -> T?
}



class TranslationLayer: ITranslationLayer{
    
    static let shared = TranslationLayer()
    
    private init() { }

    func getUnsavedCoreDataObject<T: Decodable>(type: T.Type, data: Data, context: NSManagedObjectContext) -> T? {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.userInfo.updateValue(context, forKey: CodingUserInfoKey.managedObjectContext!)
        var jsonObject : T?
        do {
            jsonObject = try jsonDecoder.decode(T.self, from: data)
        }catch {
            print("Failed Decoding with error: ================",error)
        }
        
        if let res = jsonObject {
            print("Response:============: \(res)")
            return res
        }else {
            print("================Failed decoding response================")
        }
        return nil
    }

}
