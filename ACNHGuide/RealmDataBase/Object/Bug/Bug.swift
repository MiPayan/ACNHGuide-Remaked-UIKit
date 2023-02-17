//
//  Bug.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 15/02/2023.
//

import Foundation
import RealmSwift

final class Bug: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    init(_id: ObjectId) {
        super.init()
        self._id = _id
    }
}
