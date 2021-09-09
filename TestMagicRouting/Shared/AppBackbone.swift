//
//  AppBackbone.swift
//  TestMagicRouting
//
//  Created by Michel on 09/09/21.
//

import SwiftUI
import SwiftUIMagicRouting


extension View {
	func any() -> AnyView { return AnyView(self) }
}

class AppBackbone {
	static let shared = AppBackbone()
	var magicRouter = MagicRouter()
	
	private init() {
		// initialize main menu
		magicRouter.register(route: MagicRoute(path: []), viewBuilder: LoginMagicFactory())
	}
}

