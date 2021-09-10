//
//  AppBackbone.swift
//  TestMagicRouting
//
//  Created by Michel on 09/09/21.
//

import SwiftUI
import SwiftUIMagicRouting


extension View {
	func any() -> AnyView { return AnyView(self.frame(minWidth: 400, idealWidth: 600, minHeight: 450, idealHeight: 800)) }
}

class AppBackbone {
	static let shared = AppBackbone()
	var magicRouter = MagicRouter()
	
	private init() {
		// initialize main menu
		magicRouter.storyboard = Storyboard.createRootStoryboard(rootViewFactory: LoginMagicFactory())
	}
}

