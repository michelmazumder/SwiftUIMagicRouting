import SwiftUI
import SwiftUIMagicRouting

struct LoginMagicFactory: MagicViewFactory {

	func getView(binding: ViewDataModel?, storyboardFrame: StoryboardViewModel) -> AnyView {
		LoginView(viewModel: LoginViewModel().inject(storyboard: storyboardFrame))
			.any()
	}
	
}

class LoginViewModel: MagicBaseViewModel {
	
	@Published var userName = String()
	@Published var password = String()
	@Published var errorMessage = String()
	
	
	override init() {
		// define routes from here
		AppBackbone.shared.magicRouter.register(route: MagicRoute(path: ["MainMenu"]), viewBuilder: MainMenuMagicFactory())
	}
	
	func login() {
		storyboard?.navigate(subRoute: "MainMenu", viewDataModel: nil)
	}
}
