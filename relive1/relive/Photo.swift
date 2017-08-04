//
//  Photo.swift
//  relive
//
//  Created by Elizabeth McRae on 7/27/17.
//  Copyright © 2017 Elizabeth McRae. All rights reserved.
//

import UIKit
import os.log


class Photo: NSObject, NSCoding {
    

    
    
    //MARK: Properties
    
    var mainName: String
    var image: UIImage?
    var sigName: String
    
    struct PropertyKey {
        static let mainName = "mainName"
        static let image = "image"
        static let sigName = "sigName"
        
    }
    
    static let DocumentsDirectoryFamily = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let DocumentsDirectoryPlaces = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let DocumentsDirectoryMisc = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURLFamily = DocumentsDirectoryFamily.appendingPathComponent("familyphotos")
    static let ArchiveURLPlaces = DocumentsDirectoryPlaces.appendingPathComponent("placesphotos")
    static let ArchiveURLMisc = DocumentsDirectoryMisc.appendingPathComponent("miscphotos")
    
    //MARK: Initialization
    
    init?(mainName: String, image: UIImage?, sigName: String) {
        
        //initialization should fail if there is no name
        
        guard !mainName.isEmpty else {
            return nil
        }
        guard !sigName.isEmpty else {
            return nil
        }
        self.mainName = mainName
        self.image = image
        self.sigName = sigName
    }

    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(mainName, forKey: PropertyKey.mainName)
        aCoder.encode(image, forKey: PropertyKey.image)
        aCoder.encode(sigName, forKey: PropertyKey.sigName)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let mainName = aDecoder.decodeObject(forKey: PropertyKey.mainName) as? String else {
            os_log("Unable to decode the mainName for a photo object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage
        
        guard let sigName = aDecoder.decodeObject(forKey: PropertyKey.sigName) as? String else {
            os_log("Unable to decode the sigName for a photo object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        
        
        // Must call designated initializer.
        self.init(mainName: mainName,image: image, sigName: sigName)
    }
    
}

