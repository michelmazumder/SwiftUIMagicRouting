    import XCTest
	import SwiftUI
    @testable import SwiftUIMagicRouting

	struct TestViewFactory : MagicViewFactory {
		
		let testName: String
		
		func getView(binding: ViewDataModel?, storyboardFrame: StoryboardViewModel) -> AnyView {
			return EmptyView().any()
		}
	}
	
	
    final class StoryboardTests: XCTestCase {
        func testStoryboardStructure() {
			
			let rootStoryboard = Storyboard.createRootStoryboard(rootViewFactory: TestViewFactory(testName: "Login page")) {
				$0.addCta(cta: "login", viewFactory: TestViewFactory(testName: "Main menu page")) {
					$0.addCta(cta: "1", viewFactory: TestViewFactory(testName: "Function 1 main page")) {
						$0.addCta(cta: "a", viewFactory: TestViewFactory(testName: "Function 1 A page"))
						$0.addCta(cta: "b", viewFactory: TestViewFactory(testName: "Function 1 B page"))
						$0.addCta(cta: "c", viewFactory: TestViewFactory(testName: "Function 1 C page"))
					}
					$0.addCta(cta: "2", viewFactory: TestViewFactory(testName: "Function 2 main page"))
				}
			}

			XCTAssertEqual((rootStoryboard.viewBuildersMap[MagicRoute(path: [])] as? TestViewFactory?)??.testName, "Login page")
			XCTAssertEqual((rootStoryboard.viewBuildersMap[MagicRoute (path: ["login", "2"])] as? TestViewFactory?)??.testName, "Function 2 main page")
			XCTAssertEqual((rootStoryboard.viewBuildersMap[MagicRoute (path: ["login", "1", "b"])] as? TestViewFactory?)??.testName, "Function 1 B page")
			XCTAssertNil(rootStoryboard.viewBuildersMap[MagicRoute(path: ["asd", "1"])])
        }
		
		func testAppendStoryboardStructure() {
			let rootStoryboard = Storyboard.createRootStoryboard(rootViewFactory: TestViewFactory(testName: "Login page")) {
				$0.addCta(cta: "login", viewFactory: TestViewFactory(testName: "Main menu page"))
			}
			
			let function1 = Storyboard.createRootStoryboard(rootViewFactory: TestViewFactory(testName: "Function 1 main page")) {
				$0.addCta(cta: "a", viewFactory: TestViewFactory(testName: "Function 1 A page"))
				$0.addCta(cta: "b", viewFactory: TestViewFactory(testName: "Function 1 B page"))
				$0.addCta(cta: "c", viewFactory: TestViewFactory(testName: "Function 1 C page"))
			}
			
			let function2 = Storyboard.createRootStoryboard(rootViewFactory: TestViewFactory(testName: "Function 2 main page"))
			
			XCTAssertNotNil(rootStoryboard["login"])
			
			rootStoryboard["login"]?.append(storyboard: function1, respondingTo: "1")
			rootStoryboard["login"]?.append(storyboard: function2, respondingTo: "2")

			XCTAssertEqual((rootStoryboard.viewBuildersMap[MagicRoute (path: ["login"])] as? TestViewFactory?)??.testName, "Main menu page")
			XCTAssertEqual((rootStoryboard.viewBuildersMap[MagicRoute (path: ["login", "1", "b"])] as? TestViewFactory?)??.testName, "Function 1 B page")
			XCTAssertEqual((rootStoryboard.viewBuildersMap[MagicRoute(path: [])] as? TestViewFactory?)??.testName, "Login page")
			XCTAssertEqual((rootStoryboard.viewBuildersMap[MagicRoute (path: ["login", "2"])] as? TestViewFactory?)??.testName, "Function 2 main page")
			XCTAssertEqual((rootStoryboard.viewBuildersMap[MagicRoute (path: ["login", "1", "b"])] as? TestViewFactory?)??.testName, "Function 1 B page")
			XCTAssertNil(rootStoryboard.viewBuildersMap[MagicRoute(path: ["asd", "1"])])
		}
    }
