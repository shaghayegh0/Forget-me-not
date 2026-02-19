import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var store: WordStore
    @State private var showingAddWord = false
    @State private var wordToDelete: Word? = nil

    var sortedWords: [Word] {
        store.words.sorted { $0.word.lowercased() < $1.word.lowercased() }
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()

                if store.words.isEmpty {
                    EmptyStateView()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(sortedWords) { word in
                                NavigationLink(destination: WordDetailView(word: word)) {
                                    WordCard(word: word) {
                                        wordToDelete = word
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                        .padding(.bottom, 100)
                    }
                }

                // Floating add button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            showingAddWord = true
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "plus")
                                    .font(.system(size: 16, weight: .bold))
                                Text("New Word")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .foregroundColor(.black)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 16)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .shadow(color: .white.opacity(0.15), radius: 20, x: 0, y: 4)
                        }
                        Spacer()
                    }
                    .padding(.bottom, 32)
                }
            }
            .navigationTitle("Forget Me Not")
            .navigationBarTitleDisplayMode(.large)
            .preferredColorScheme(.dark)
            .sheet(isPresented: $showingAddWord) {
                AddWordView(store: store)
                    .preferredColorScheme(.dark)
            }
            .alert("Delete word?", isPresented: .constant(wordToDelete != nil), presenting: wordToDelete) { word in
                Button("Delete", role: .destructive) {
                    if let idx = store.words.firstIndex(where: { $0.id == word.id }) {
                        store.words.remove(at: idx)
                    }
                    wordToDelete = nil
                }
                Button("Cancel", role: .cancel) {
                    wordToDelete = nil
                }
            } message: { word in
                Text("\"\(word.word)\" will be permanently removed.")
            }
        }
    }
}

struct WordCard: View {
    let word: Word
    let onDelete: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            // Top row: word + gender badge + delete button
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text(word.word)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(typeColor(word.type).bg)

                        if word.gender != .notApplicable {
                            Text(genderLabel(word.gender))
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundColor(genderColor(word.gender))
                                .padding(.horizontal, 7)
                                .padding(.vertical, 3)
                                .background(genderColor(word.gender).opacity(0.18))
                                .clipShape(Capsule())
                        }
                    }

                    Text(word.type.label.uppercased())
                        .font(.system(size: 10, weight: .semibold, design: .monospaced))
                        .foregroundColor(typeColor(word.type).bg.opacity(0.7))
                        .tracking(1.5)
                }

                Spacer()

                Button {
                    onDelete()
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.25))
                        .padding(10)
                        .background(Color.white.opacity(0.06))
                        .clipShape(Circle())
                }
            }

            // Divider
            Rectangle()
                .fill(Color.white.opacity(0.07))
                .frame(height: 1)

            // Translations row — FA column only shown if it has content
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("EN")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.white.opacity(0.3))
                        .tracking(1)
                    Text(word.definitionEnglish)
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.9))
                        .lineLimit(1)
                }

                if !word.definitionFarsi.isEmpty {
                    Spacer()

                    Rectangle()
                        .fill(Color.white.opacity(0.07))
                        .frame(width: 1, height: 32)

                    Spacer()

                    VStack(alignment: .trailing, spacing: 2) {
                        Text("FA")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(.white.opacity(0.3))
                            .tracking(1)
                        Text(word.definitionFarsi)
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.9))
                            .lineLimit(1)
                            .environment(\.layoutDirection, .rightToLeft)
                    }
                }
            }
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(typeColor(word.type).bg.opacity(0.18))
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(typeColor(word.type).bg.opacity(0.35), lineWidth: 1)
                )
        )
    }

    func genderLabel(_ gender: Gender) -> String {
        switch gender {
        case .masculine: return "masc."
        case .feminine: return "fem."
        case .neuter: return "neut."
        case .notApplicable: return ""
        }
    }

    func genderColor(_ gender: Gender) -> Color {
        switch gender {
        case .masculine: return Color(red: 0.4, green: 0.7, blue: 1.0)
        case .feminine: return Color(red: 1.0, green: 0.5, blue: 0.7)
        case .neuter: return Color(red: 0.7, green: 0.55, blue: 1.0)
        case .notApplicable: return .gray
        }
    }

    func typeColor(_ type: WordType) -> (bg: Color, text: Color) {
        switch type {
        case .noun:         return (Color(red: 0.53, green: 0.73, blue: 0.95), Color(red: 0.10, green: 0.22, blue: 0.38))
        case .verb:         return (Color(red: 0.60, green: 0.88, blue: 0.76), Color(red: 0.08, green: 0.30, blue: 0.22))
        case .adjective:    return (Color(red: 0.98, green: 0.80, blue: 0.58), Color(red: 0.38, green: 0.22, blue: 0.05))
        case .adverb:       return (Color(red: 0.88, green: 0.70, blue: 0.95), Color(red: 0.28, green: 0.10, blue: 0.38))
        case .preposition:  return (Color(red: 0.95, green: 0.68, blue: 0.75), Color(red: 0.38, green: 0.10, blue: 0.18))
        case .conjunction:  return (Color(red: 0.70, green: 0.88, blue: 0.95), Color(red: 0.08, green: 0.25, blue: 0.35))
        case .pronoun:      return (Color(red: 0.95, green: 0.88, blue: 0.60), Color(red: 0.35, green: 0.28, blue: 0.05))
        case .interjection: return (Color(red: 0.95, green: 0.72, blue: 0.60), Color(red: 0.38, green: 0.15, blue: 0.05))
        case .article:      return (Color(red: 0.78, green: 0.85, blue: 0.78), Color(red: 0.15, green: 0.28, blue: 0.15))
        case .other:        return (Color(red: 0.82, green: 0.82, blue: 0.85), Color(red: 0.22, green: 0.22, blue: 0.28))
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 14) {
            Text("📖")
                .font(.system(size: 56))
            Text("No words yet")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
            Text("Tap New Word to start your collection")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.4))
        }
    }
}

#Preview {
    ContentView()
}
