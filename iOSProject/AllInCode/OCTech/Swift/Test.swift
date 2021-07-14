//
//  Test.swift
//  AllInCode
//
//  Created by hd on 2021/7/8.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

import Foundation
class Test: NSObject {
    @objc func show() {  // 必须加@objc前缀，才能在oc中可见
        print("hello bridge!");
    }
}
