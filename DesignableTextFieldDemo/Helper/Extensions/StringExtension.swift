//
//  StringExtension.swift
//  AdviqoTextFieldTest
//
//  Created by Oleksandr Pronin on 22.08.17.
//  Copyright © 2017 Oleksandr Pronin. All rights reserved.
//

import Foundation

extension String
{
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}
