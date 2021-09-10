
import SwiftUI

public class StoryboardViewModel : ObservableObject {
	
	var magicRouter: MagicRouter?
	var parentStoryboardFrame: StoryboardViewModel?
	var viewDataModel: ViewDataModel?
	
	@Published var currentNavigationPath: MagicRoute
	@Published var nextSubPath: String? = nil
	
	public init(currentRoute: MagicRoute, viewDataModel: ViewDataModel?) {
		currentNavigationPath = currentRoute
		self.viewDataModel = viewDataModel
	}
	
	// MARK: - Internal view management
	
	var showNextView: Bool { nextSubPath != nil }
	
	func onReturningFromNextView() {
		nextSubPath = nil
	}
	
	@ViewBuilder func errorView(message: String) -> some View {
		Text(message)
	}
	
	@ViewBuilder var currentView: some View {
		if let magicRouter = magicRouter {
			magicRouter.getView(for: currentNavigationPath, storyboardFrame: self, binding: viewDataModel)
		}
		else {
			errorView(message: "Magic route is nil")
		}
	}
	
	@ViewBuilder var nextView: some View {
		if let nextSubPath = nextSubPath {
			StoryboardView(
				viewModel: StoryboardViewModel(
					currentRoute: currentNavigationPath.appending(subPath: nextSubPath),
					viewDataModel: self.viewDataModel
				)
				.inject(magicRouter: self.magicRouter)
				.inject(parentStoryboardFrame: self)
			)
		}
		else {
			errorView(message: "NextSubPath is null")
		}
	}
	
	// MARK: - Dependency injection
	
	func inject(magicRouter: MagicRouter?) -> StoryboardViewModel {
		self.magicRouter = magicRouter
		return self
	}
	
	func inject(parentStoryboardFrame: StoryboardViewModel?) -> StoryboardViewModel {
		self.parentStoryboardFrame = parentStoryboardFrame
		return self
	}
	
	
	// MARK: - Public navigation
	
	public func navigate(subRoute: String, viewDataModel: ViewDataModel?) {
		assert(nextSubPath == nil) // non dovrei navigare oltre
		withAnimation {
			self.viewDataModel = viewDataModel
			nextSubPath = subRoute
		}
	}
	
	public func back() {
		withAnimation {
			parentStoryboardFrame?.onReturningFromNextView()
		}
	}
}
