//
//  Job.swift
//  JobLine
//
//  Created by naoya-kanoh on 2015/09/02.
//  Copyright (c) 2015年 naoya.kanoh. All rights reserved.
//

import Foundation
import CoreData

class Job: NSManagedObject {

    @NSManaged var content: String?
    @NSManaged var detail: Detail?

}
