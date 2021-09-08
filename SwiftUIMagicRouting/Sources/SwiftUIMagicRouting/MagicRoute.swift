import Foundation

public struct MagicRoute: Identifiable {
	let path: [String]
	public var id: String { path.joined(separator: ".") }
	public var description: String { self.id }
	
	public init(path: [String]) {
		self.path = path
	}
	
	public func appending(subPath: String) -> MagicRoute {
		var newPath = self.path
		newPath.append(subPath)
		return MagicRoute(path: newPath)
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
