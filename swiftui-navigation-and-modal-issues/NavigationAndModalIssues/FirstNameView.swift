import SwiftUI

struct FirstNameView: View {
    private static let names = [
        "Amelia",
        "Andrew",
        "Ava",
        "Charlotte",
        "Christopher",
        "Daniel",
        "David",
        "Emily",
        "Ethan",
        "Isabella",
        "James",
        "Jane",
        "John",
        "Joseph",
        "Matthew",
        "Mia",
        "Michael",
        "Olivia",
        "Sarah",
        "Sophia"
    ]

    var body: some View {
        List(Self.names, id: \.self) { name in
            NavigationLink(name, value: name)
        }
        .navigationTitle("First name")
        .navigationDestination(for: String.self) { name in
            LastNameView(firstName: name)
        }
    }
}

struct FirstNameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FirstNameView()
        }
    }
}
