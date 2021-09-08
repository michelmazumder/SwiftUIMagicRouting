
import SwiftUI

public class StoryboardViewModel : ObservableObject {
	
	var magicRouter: MagicRouter?
	var parentStoryboardFrame: StoryboardViewModel?
	var viewDataModel: ViewDataModel?
	var transitionType: AnyTransition? = AnyTransition.move(edge: .leading)
	var animationType: Animation? = .easeIn
	
	@Published var currentNavigationPath: MagicRoute
	@Published var nextSubPath: String? = nil
	
	public init(currentRoute: MagicRoute, viewDataModel: ViewDataModel?) {
		currentNavigationPath = currentRoute
		self.viewDataModel = viewDataModel
	}
	
	// MARK: - Internal view management
	
	func onReturningFromNextView() {
		nextSubPath = nil
	}
	
	var currentView: AnyView {
		
		guard let transitionType = transitionType else { return currentViewWithoutTransition }
		
		return currentViewWithoutTransition
			.transition(transitionType)
			.animation(animationType)
			.any()
	}
	
	var currentViewWithoutTransition: AnyView {
		
		if let nextSubPath = nextSubPath {
			return StoryboardView(
				viewModel: StoryboardViewModel(
					currentRoute: currentNavigationPath.appending(subPath: nextSubPath),
					viewDataModel: self.viewDataModel
				)
				.inject(magicRouter: self.magicRouter)
				.inject(parentStoryboardFrame: self)
			).any()
		}
		return magicRouter?.getView(for: currentNavigationPath, storyboardFrame: self, binding: viewDataModel).any()
			?? Text("Magic route is nil").any()
		
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
			self.transitionType = AnyTransition.move(edge: .leading)
			self.animationType = .easeIn
			self.viewDataModel = viewDataModel
			nextSubPath = subRoute
		}
	}
	
	public func back() {
		withAnimation {
			self.transitionType = AnyTransition.move(edge: .trailing)
			self.animationType = .easeOut
			parentStoryboardFrame?.animationType = .easeOut
			parentStoryboardFrame?.transitionType = AnyTransition.move(edge: .trailing)
			parentStoryboardFrame?.onReturningFromNextView()
		}
	}
}
