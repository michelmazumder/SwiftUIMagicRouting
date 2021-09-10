
import SwiftUI
import SwiftUIMagicRouting

struct MainMenuMagicFactory: MagicViewFactory {
	func getView(binding: ViewDataModel?, storyboardFrame: StoryboardViewModel) -> AnyView {
		MainMenuView(
			viewModel: MainMenuViewModel()
				.inject(storyboard: storyboardFrame)
		)
		.any()
	}
}


class MainMenuViewModel : MagicBaseViewModel {
	
	@Published var ctas = ["scelta 1", "scelta 2", "scelta 3"]
	var dataModel = MenuModel()
	
	override init() {
		let items = ["scelta 1", "scelta 2", "scelta 3"]
		self.ctas = items
		
		let subStoryboard = Storyboard.createRootStoryboard(rootViewFactory: MainMenuMagicFactory()) { board in
			items.forEach { cta in
				board.addCta(cta: cta, viewFactory: MenuChoiceMagicFactory())
			}
		}
		
		AppBackbone.shared.magicRouter.storyboard?["MainMenu"]?.append(storyboard: subStoryboard, respondingTo: "MainMenu")
	}
	
	func selectItem(item: String) {
		dataModel.selectedEntry = item
		storyboard?.navigate(subRoute: item, viewDataModel: dataModel)
	}
}
