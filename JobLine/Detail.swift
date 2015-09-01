//
//  Detail.swift
//  JobLine
//
//  Created by naoya-kanoh on 2015/09/02.
//  Copyright (c) 2015年 naoya.kanoh. All rights reserved.
//

import Foundation
import CoreData

class Detail: NSManagedObject {

    @NSManaged var limit: NSDate
    @NSManaged var update: NSDate
    @NSManaged var supplement: String
    @NSManaged var tag: String
    @NSManaged var progress: NSNumber
    @NSManaged var job: NSSet

}