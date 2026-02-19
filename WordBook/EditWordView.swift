import SwiftUI

struct EditWordView: View {
    @ObservedObject var store: WordStore
    @Environment(\.dismiss) private var dismiss

    let original: Word

    @State private var word: String
    @State private var selectedType: WordType
    @State private var selectedGender: Gender
    @State private var definitionEnglish: String
    @State private var definitionFarsi: String
    @State private var exampleSentence: String

    init(store: WordStore, word: Word) {
        self.store = store
        self.original = word
        _word = State(initialValue: word.word)
        _selectedType = State(initialValue: word.type)
        _selectedGender = State(initialValue: word.gender)
        _definitionEnglish = State(initialValue: word.definitionEnglish)
        _definitionFarsi = State(initialValue: word.definitionFarsi)
        _exampleSentence = State(initialValue: word.exampleSentence)
    }

    var isValid: Bool {
        !word.trimmingCharacters(in: .whitespaces).isEmpty &&
        !definitionEnglish.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationView {
            Form {
                Section("Word") {
                    TextField("e.g. lake, courir, beau…", text: $word)
                        .autocorrectionDisabled()

                    Picker("Type", selection: $selectedType) {
                        ForEach(WordType.allCases, id: \.self) { type in
                            Text("\(type.rawValue) – \(type.label)").tag(type)
                        }
                    }

                    Picker("Gender", selection: $selectedGender) {
                        ForEach(Gender.allCases, id: \.self) { gender in
                            Text(gender.rawValue).tag(gender)
                        }
                    }
                }

                Section("Definitions") {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("English")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        TextField("English definition", text: $definitionEnglish, axis: .vertical)
                            .lineLimit(2...4)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Farsi / فارسی")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        TextField("تعریف فارسی", text: $definitionFarsi, axis: .vertical)
                            .lineLimit(2...4)
                            .multilineTextAlignment(.trailing)
                            .environment(\.layoutDirection, .rightToLeft)
                    }
                }

                Section("Example Sentence") {
                    TextField("Write a sentence using this word…", text: $exampleSentence, axis: .vertical)
                        .lineLimit(2...5)
                }
            }
            .navigationTitle("Edit Word")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        var updated = original
                        updated.word = word.trimmingCharacters(in: .whitespaces)
                        updated.type = selectedType
                        updated.gender = selectedGender
                        updated.definitionEnglish = definitionEnglish.trimmingCharacters(in: .whitespaces)
                        updated.definitionFarsi = definitionFarsi.trimmingCharacters(in: .whitespaces)
                        updated.exampleSentence = exampleSentence.trimmingCharacters(in: .whitespaces)
                        store.update(updated)
                        dismiss()
                    }
                    .disabled(!isValid)
                    .fontWeight(.semibold)
                }
            }
        }
    }
}
