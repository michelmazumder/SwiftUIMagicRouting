import Foundation

open class MagicBaseViewModel: ObservableObject {
	
	public var storyboard: StoryboardViewModel?
	
	// MARK: - Dependency injection
	public func inject(storyboard: StoryboardViewModel) -> Self {
		self.storyboard = storyboard
		return self
	}
	
	public init() {}
}
