import SwiftUI

struct PersonView: View {
    let person: Person

    var body: some View {
        Text(person.fullName)
    }
}
