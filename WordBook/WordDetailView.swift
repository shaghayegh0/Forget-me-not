import SwiftUI

struct WordDetailView: View {
    @EnvironmentObject var store: WordStore
    let word: Word
    @State private var showingEdit = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                // Header
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .firstTextBaseline, spacing: 10) {
                        Text(word.word)
                            .font(.largeTitle.bold())
                        Text("(\(word.type.rawValue))")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }

                    if word.gender != .notApplicable {
                        HStack(spacing: 6) {
                            Circle()
                                .fill(genderColor(word.gender))
                                .frame(width: 8, height: 8)
                            Text(word.gender.rawValue)
                                .font(.subheadline)
                                .foregroundColor(genderColor(word.gender))
                        }
                    }
                }

                Divider()

                // Definitions
                VStack(alignment: .leading, spacing: 16) {
                    InfoSection(title: "English Definition", icon: "🇬🇧") {
                        Text(word.definitionEnglish)
                            .font(.body)
                    }

                    InfoSection(title: "Farsi Definition", icon: "🇮🇷") {
                        Text(word.definitionFarsi)
                            .font(.body)
                            .environment(\.layoutDirection, .rightToLeft)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }

                Divider()

                // Example sentence
                InfoSection(title: "Example Sentence", icon: "💬") {
                    Text(word.exampleSentence)
                        .font(.body)
                        .italic()
                        .foregroundColor(.primary.opacity(0.85))
                }

                Divider()

                // Metadata
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.secondary)
                    Text("Added \(word.dateAdded.formatted(date: .long, time: .omitted))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(20)
        }
        .navigationTitle(word.word)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") { showingEdit = true }
            }
        }
        .sheet(isPresented: $showingEdit) {
            EditWordView(store: store, word: store.words.first(where: { $0.id == word.id }) ?? word)
        }
    }

    func genderColor(_ gender: Gender) -> Color {
        switch gender {
        case .masculine: return .blue
        case .feminine: return .pink
        case .neuter: return .purple
        case .notApplicable: return .gray
        }
    }
}

struct InfoSection<Content: View>: View {
    let title: String
    let icon: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                Text(icon)
                Text(title)
                    .font(.caption.uppercaseSmallCaps())
                    .foregroundColor(.secondary)
            }
            content()
        }
    }
}
