//
//  Unchecked.swift
//
//  Created by cyan on 4/17/24.
//

import WebKit

#if compiler(>=6.0)
  extension WKScriptMessage: @unchecked @retroactive Sendable {}
#else
  extension WKScriptMessage: @unchecked Sendable {}
#endif
