	import XCTest
	import SwiftUI
	@testable import SwiftUIMagicRouting
	
	final class MagicRouteTests: XCTestCase {
		func testMagicRouteConcatenation() {

			let a = MagicRoute(path: ["this", "is", "first","route"])
			let b = MagicRoute(path: ["1","2","3"])
			let c = a + b
			
			XCTAssertEqual(c.description, "this.is.first.route.1.2.3")
		}
		
	}
