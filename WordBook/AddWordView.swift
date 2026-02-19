import SwiftUI

struct AddWordView: View {
    @ObservedObject var store: WordStore
    @Environment(\.dismiss) private var dismiss

    @State private var word = ""
    @State private var selectedType: WordType = .noun
    @State private var selectedGender: Gender = .notApplicable
    @State private var definitionEnglish = ""
    @State private var definitionFarsi = ""
    @State private var exampleSentence = ""

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
                        Label("English", systemImage: "")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        TextField("English definition", text: $definitionEnglish, axis: .vertical)
                            .lineLimit(2...4)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Label("Farsi / فارسی", systemImage: "")
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
            .navigationTitle("New Word")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newWord = Word(
                            word: word.trimmingCharacters(in: .whitespaces),
                            type: selectedType,
                            gender: selectedGender,
                            definitionEnglish: definitionEnglish.trimmingCharacters(in: .whitespaces),
                            definitionFarsi: definitionFarsi.trimmingCharacters(in: .whitespaces),
                            exampleSentence: exampleSentence.trimmingCharacters(in: .whitespaces)
                        )
                        store.add(newWord)
                        dismiss()
                    }
                    .disabled(!isValid)
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

extension WordType {
    var label: String {
        switch self {
        case .noun: return "Noun"
        case .verb: return "Verb"
        case .adjective: return "Adjective"
        case .adverb: return "Adverb"
        case .preposition: return "Preposition"
        case .conjunction: return "Conjunction"
        case .pronoun: return "Pronoun"
        case .interjection: return "Interjection"
        case .article: return "Article"
        case .other: return "Other"
        }
    }
}
