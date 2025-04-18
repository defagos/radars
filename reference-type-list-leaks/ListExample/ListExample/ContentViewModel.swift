import Combine

final class ContentViewModel: ObservableObject {
    @Published var persons: [Person] = [
        .init(name: "Alice"),
        .init(name: "Bob"),
        .init(name: "Charles"),
        .init(name: "Daniela"),
        .init(name: "Ernesto"),
        .init(name: "Fiona")
    ]

    @Published var selectedPerson: Person?

    init() {}

    func clear() {
        persons.removeAll()
        selectedPerson = nil
    }
}
