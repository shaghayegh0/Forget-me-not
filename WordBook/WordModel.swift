import Foundation

enum WordType: String, CaseIterable, Codable {
    case noun = "n."
    case verb = "v."
    case adjective = "adj."
    case adverb = "adv."
    case preposition = "prep."
    case conjunction = "conj."
    case pronoun = "pron."
    case interjection = "interj."
    case article = "art."
    case other = "other"
}

enum Gender: String, CaseIterable, Codable {
    case masculine = "Masculine"
    case feminine = "Feminine"
    case neuter = "Neuter"
    case notApplicable = "N/A"
}

struct Word: Identifiable, Codable {
    var id: UUID = UUID()
    var word: String
    var type: WordType
    var gender: Gender
    var definitionEnglish: String
    var definitionFarsi: String
    var exampleSentence: String
    var isFavorite: Bool = false
    var dateAdded: Date = Date()
}

class WordStore: ObservableObject {
    @Published var words: [Word] = []

    private let saveKey = "saved_words"

    init() {
        load()
    }

    func update(_ word: Word) {
        if let idx = words.firstIndex(where: { $0.id == word.id }) {
            words[idx] = word
            save()
        }
    }

    func toggleFavorite(_ word: Word) {
        if let idx = words.firstIndex(where: { $0.id == word.id }) {
            words[idx].isFavorite.toggle()
            save()
        }
    }    
    
    func add(_ word: Word) {
        words.append(word)
        save()
    }

    func delete(at offsets: IndexSet) {
        words.remove(atOffsets: offsets)
        save()
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(words) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Word].self, from: data) {
            words = decoded
        }
    }
}
