//
//  MainMenuStoryboardLoader.swift
//  TestMagicRouting
//
//  Created by Michel on 10/09/21.
//

import Foundation
import SwiftUIMagicRouting

class MainMenuStoryboardLoader: StoryboardLoader {
	
	required init() {}
	
	func loadStoryboard() -> Storyboard {
		let items = loadItemsFromRemoteServer()
		
		return Storyboard.createRootStoryboard(rootViewFactory: MainMenuMagicFactory()) { board in
			items.forEach { cta in
				board.addCta(cta: cta, viewFactory: MenuChoiceMagicFactory())
			}
		}
		
		//AppBackbone.shared.magicRouter.storyboard?["MainMenu"]?.append(storyboard: subStoryboard, respondingTo: "MainMenu")
	}
	
	func loadItemsFromRemoteServer() -> [String] {
		return ["scelta 1", "scelta 2", "scelta 3"]
	}
}
