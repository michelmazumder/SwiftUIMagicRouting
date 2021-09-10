import SwiftUI

public protocol ViewDataModel { }

public protocol MagicViewFactory {
	func getView(binding: ViewDataModel?, storyboardFrame: StoryboardViewModel) -> AnyView
}


public class MagicRouter: ObservableObject {
	
	private var viewBuilders: [MagicRoute: MagicViewFactory] {
		storyboard?.viewBuildersMap ?? [:]
	}
	@Published public var storyboard: Storyboard? = nil
	
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
		
		guard let v = viewBuilders[route]?.getView(binding: dataModel, storyboardFrame: storyboardFrame)
		else { return Text("View for \(route.description) not found").padding().any() }
		return v.any()
		
	}
}
