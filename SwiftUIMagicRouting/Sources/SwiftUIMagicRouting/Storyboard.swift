//
//  File.swift
//  
//
//  Created by Michel on 09/09/21.
//

import Foundation

public typealias CallToAction = String

public protocol StoryboardLoader {
	init()
	func loadStoryboard() -> Storyboard
}

public class Storyboard {
	
	var segues: [CallToAction: Storyboard] = [:]
	var previousBoard: Storyboard? = nil
	var viewFactory: MagicViewFactory
	
	init(viewFactory: MagicViewFactory) {
		self.viewFactory = viewFactory
	}
	
	var viewBuildersMap: [MagicRoute: MagicViewFactory] {
		getMyBuilderMap(using: MagicRoute.root)
	}
	
	private func getMyBuilderMap(using rootMagicRoute: MagicRoute) -> [MagicRoute: MagicViewFactory] {
		var rt = [MagicRoute: MagicViewFactory]()
		rt[rootMagicRoute] = viewFactory
		segues.forEach { cta, subStoryboard in
			rt.merge(subStoryboard.getMyBuilderMap(using: rootMagicRoute.appending(subPath: cta))) { (_, new) in new }
		}
		return rt
	}
	
	// MARK: - Public interface

	public subscript (cta: CallToAction) -> Storyboard? { segues[cta] }

	public static func createRootStoryboard(rootViewFactory: MagicViewFactory, onWichDo: ((Storyboard)->Void)? = nil) -> Storyboard {
		let rs = Storyboard(viewFactory: rootViewFactory)
		onWichDo?(rs)
		return rs
	}
	
	@discardableResult public func addCta(cta: CallToAction, viewFactory: MagicViewFactory, onWichDo: ((Storyboard)->Void)? = nil) -> Storyboard {
		let newStoryboard = Storyboard(viewFactory: viewFactory)
		newStoryboard.previousBoard = self
		self.segues[cta] = newStoryboard
		onWichDo?(newStoryboard)
		return self
	}
	
	public var parent: Storyboard? { previousBoard	}
	
	public func removeCtaTree(cta: CallToAction) {
		segues.removeValue(forKey: cta)
	}
	
	public func append(storyboard: Storyboard, respondingTo cta: CallToAction) {
		assert(storyboard.previousBoard == nil)
		storyboard.previousBoard = self
		segues[cta] = storyboard
	}
}
