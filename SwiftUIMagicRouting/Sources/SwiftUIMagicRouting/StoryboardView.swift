import SwiftUI

struct StoryboardView: View {
	
	@ObservedObject var viewModel: StoryboardViewModel
	
	var body: some View {
		
		Group {
			if viewModel.showNextView {
				viewModel.nextView
					.transition(AnyTransition.move(edge: .leading))
					.animation(.easeIn)
			}
			else {
				viewModel.currentView
					.transition(AnyTransition.move(edge: .trailing))
					.animation(.easeOut)
			}
		}
	}
}

extension View {
	func any() -> AnyView { return AnyView(self) }
}
