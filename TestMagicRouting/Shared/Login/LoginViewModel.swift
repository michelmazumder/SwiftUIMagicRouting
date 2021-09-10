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
		
		// let moduleName = Bundle.main.infoDictionary!["CFBundleName"] as! String
		// print("Module name = '\(moduleName)'")
		
		guard let loaderClass = Bundle.main.classNamed("TestMagicRouting.MainMenuStoryboardLoader") as? StoryboardLoader.Type else {
			print("Warning: impossibile caricare 'MainMenuStoryboardLoader'")
			return
		}
		
		AppBackbone.shared.magicRouter.storyboard?.append(
			storyboard: loaderClass.init().loadStoryboard(),
			respondingTo: "MainMenu")

	}
	
	func login() {
		storyboard?.navigate(subRoute: "MainMenu", viewDataModel: nil)
	}
}
