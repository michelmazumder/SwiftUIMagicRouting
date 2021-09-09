import SwiftUI

public protocol ViewDataModel { }

public protocol MagicViewFactory {
	func getView(binding: ViewDataModel?, storyboardFrame: StoryboardViewModel) -> AnyView
}

public class MagicRouter {
	
	private var viewBuilders = [MagicRoute: MagicViewFactory]()
	
	public init() {}
	
	public func getRootView() -> AnyView {
		AnyView(StoryboardView(
			viewModel:
				StoryboardViewModel(
					currentRoute: MagicRoute(path: []),
					viewDataModel: nil
				)
				.inject(magicRouter: self)
		))
	}
	
	public func getView(for route: MagicRoute,
						storyboardFrame: StoryboardViewModel,
						binding dataModel: ViewDataModel? = nil) -> AnyView {
		guard let v = viewBuilders[route]?
				.getView(binding: dataModel, storyboardFrame: storyboardFrame)
		else { return AnyView(Text("View for \(route.description) not found")) }
		return AnyView(v)
	}
	
	public func register(route: MagicRoute, viewBuilder: MagicViewFactory) -> MagicRouter {
		viewBuilders[route] = viewBuilder
		return self
	}
}
