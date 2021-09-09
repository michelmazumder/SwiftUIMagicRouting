
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
	
	@Published var items = ["scelta 1", "scelta 2", "scelta 3"]
	var dataModel = MenuModel()
	
	override init() {
		let items = ["scelta 1", "scelta 2", "scelta 3"]
		self.items = items
		let currentRoute = MagicRoute(path: ["MainMenu"])
		AppBackbone.shared.magicRouter.register(route: currentRoute, viewBuilder: MainMenuMagicFactory())
		items.forEach {
			item in
			AppBackbone.shared.magicRouter.register(
				route: currentRoute.appending(subPath: item),
				viewBuilder: MenuChoiceMagicFactory()
			)
		}
	}
	
	func selectItem(item: String) {
		dataModel.selectedEntry = item
		storyboard?.navigate(subRoute: item, viewDataModel: dataModel)
	}
}
