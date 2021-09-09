//
//  TestMagicRoutingApp.swift
//  Shared
//
//  Created by Michel on 09/09/21.
//

import SwiftUI
import SwiftUIMagicRouting

@main
struct TestMagicRoutingApp: App {
	
	var mainView: AnyView { AppBackbone.shared.magicRouter.getRootView() }
	
	var body: some Scene {
		WindowGroup {
			mainView
		}
	}
	
}
