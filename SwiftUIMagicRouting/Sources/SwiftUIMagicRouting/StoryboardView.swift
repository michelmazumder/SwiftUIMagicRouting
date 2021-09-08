import SwiftUI

struct StoryboardView: View {
	
	@ObservedObject var viewModel: StoryboardViewModel
	
	var body: some View {
		viewModel.currentView
	}
}

extension View {
	func any() -> AnyView { return AnyView(self) }
}
