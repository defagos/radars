import SwiftUI

struct ContentView: View {
    @StateObject private var model = ContentViewModel()

    var body: some View {
        ZStack {
            if !model.persons.isEmpty {
                List($model.persons, id: \.self, editActions: .all, selection: $model.selectedPerson) { $person in
                    Text(person.name)
                }
            }
            else {
                ContentUnavailableView("Empty", systemImage: "person.fill")
            }
        }
        .navigationTitle("Persons")
        .toolbar {
            ToolbarItem {
                Button(action: model.clear) {
                    Image(systemName: "trash")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
