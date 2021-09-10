import Foundation

public struct MagicRoute: Identifiable, Equatable {
	
	let path: [String]
	
	public var id: String { path.joined(separator: ".") }
	public var description: String { self.id }
	public static let root = MagicRoute(path: [])
	
	public init(path: [String]) {
		self.path = path
	}
	
	public func appending(subPath: String) -> MagicRoute {
		var newPath = self.path
		newPath.append(subPath)
		return MagicRoute(path: newPath)
	}
	
	public func isRootRouteFor(subRoute: MagicRoute) -> Bool {
		guard self.path.count < subRoute.path.count else { return false }
		for i in (0..<self.path.count) {
			if self.path[i] != subRoute.path[i] { return false }
		}
		return true
	}
	
	public static func +(left: MagicRoute, right: MagicRoute) -> MagicRoute {
		MagicRoute(path: left.path + right.path)
	}
}

extension MagicRoute: Hashable {
	public static func == (lhs: MagicRoute, rhs: MagicRoute) -> Bool {
		return lhs.id == rhs.id
	}
	
	public func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
