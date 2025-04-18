final class Person {
    let name: String

    init(name: String) {
        self.name = name
    }

    deinit {
        print("--> deinit \(name)")
    }
}

extension Person: Hashable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

extension Person: CustomDebugStringConvertible {
    var debugDescription: String {
        name
    }
}

