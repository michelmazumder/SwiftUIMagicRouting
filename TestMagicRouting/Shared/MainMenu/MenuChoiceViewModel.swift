import SwiftUI
import SwiftUIMagicRouting

struct MenuChoiceMagicFactory: MagicViewFactory {
	
	func getView(binding: ViewDataModel?, storyboardFrame: StoryboardViewModel) -> AnyView {
		
		guard let menuModel = binding as? MenuModel else { return Text("Menu model is nil").any() }
		return MenuChoiceView(
			viewModel: MenuChoiceViewModel(dataModel: menuModel)
				.inject(storyboard: storyboardFrame)
		).any()
		
	}
	
}

class MenuChoiceViewModel: MagicBaseViewModel {
	
	@Published var dataModel: MenuModel
	
	init(dataModel: MenuModel) {
		self.dataModel = dataModel
	}
	
	func back() {
		storyboard?.back()
	}
}
