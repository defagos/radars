import Foundation

struct Person: Identifiable {
    let firstName: String
    let lastName: String

    var id: String {
        fullName
    }

    var fullName: String {
        "\(firstName) \(lastName)"
    }
}
