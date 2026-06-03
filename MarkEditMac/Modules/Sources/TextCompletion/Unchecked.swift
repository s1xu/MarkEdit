//
//  Unchecked.swift
//
//  Created by cyan on 5/17/24.
//

import Foundation

#if compiler(>=6.0)
  extension KeyPath: @unchecked @retroactive Sendable {}
#else
  extension KeyPath: @unchecked Sendable {}
#endif
