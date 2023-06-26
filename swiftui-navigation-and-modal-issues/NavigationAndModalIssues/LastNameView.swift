import SwiftUI

struct LastNameView: View {
    private static let names = [
        "Anderson",
        "Brown",
        "Clark",
        "Davis",
        "Doe",
        "Harris",
        "Jackson",
        "Johnson",
        "Lee",
        "Lewis",
        "Martinez",
        "Moore",
        "Smith",
        "Taylor",
        "Thompson",
        "Thomas",
        "Walker",
        "White",
        "Wilson",
        "Young"
    ]

    let firstName: String

    @State private var person: Person?

    var body: some View {
        List(Self.names, id: \.self) { name in
            Button {
                person = .init(firstName: firstName, lastName: name)
            } label: {
                Text(name)
            }
        }
        .navigationTitle(firstName)
        .sheet(item: $person) { person in
            PersonView(person: person)
        }
        .navigationTitle("Persons")
    }
}

struct LastNameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LastNameView(firstName: "John")
        }
    }
}
