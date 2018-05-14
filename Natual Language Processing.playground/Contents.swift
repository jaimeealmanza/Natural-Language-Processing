import Foundation

let quote = "Here's to the crazy ones. The misfits. The rebels. The troublemakers. The round pegs in the square holes. The ones who see things differently. They're not fond of rules. And they have no respect for the status quo. You can quote them, disagree with them, glorify or vilify them. About the only thing you can't do is ignore them. Because they change things. They push the human race forward. And while some may see them as the crazy ones, we see genius. Because the people who are crazy enough to think they can change the world, are the ones who do. - Steve Jobs (Founder of Apple Inc.)"

let tagger = NSLinguisticTagger(tagSchemes: [.tokenType, .language, .lexicalClass, .nameType, .lemma], options: 0)
let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]

/*:
 
 > 1. **Token Type**: A property which classifies each character as either a word, punctuation, or whitespace.
 > 2. **Language**: Determines the language of the token
 > 3. **Lexical Class**: A property which classifies each token according to its class. For example, it’ll determine the part of speech for a word, the type of punctuation for a punctuation, or the type of whitespace for a whitespace.
 > 4. **Name Type**: This property looks for tokens which are part of a named entity. It’ll look for a personal name, an organizational name, and a place name.
 > 5. **Lemma**: This basically returns the stem of a word token. I’ll be going into more detail about this later on.
 
 */


// MARK: - Language Identification

func determineLanguage(for text: String) {
    tagger.string = text
    let language = tagger.dominantLanguage
    print("The language is \(language!)")
}

//determineLanguage(for: quote)


// MARK: - Tokenization

func tokenizeText(for text: String) {
    tagger.string = text
    let range = NSRange(location: 0, length: text.utf16.count)
    tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType, options: options) { (tag, tokenRange, stop) in
        let word = (text as NSString).substring(with: tokenRange)
        print(word)
    }
}

//tokenizeText(for: quote)


// MARK: - Lemmatization

func lemmatization(for text: String) {
    tagger.string = text
    let range = NSRange(location: 0, length: text.utf16.count)
    tagger.enumerateTags(in: range, unit: .word, scheme: .lemma, options: options) { (tag, tokenRange, stop) in
        if let lemma = tag?.rawValue {
            print(lemma)
        }
    }
}

//lemmatization(for: quote)


// MARK: - Parts of speech

func partsOfSpeech(for text: String) {
    tagger.string = text
    let range = NSRange(location: 0, length: text.utf16.count)
    tagger.enumerateTags(in: range, unit: .word, scheme: .lexicalClass, options: options) { (tag, tokenRange, _) in
        if let tag = tag {
            let word = (text as NSString).substring(with: tokenRange)
            print("\(word): \(tag.rawValue)")
        }
    }
}

//partsOfSpeech(for: quote)


// MARK: - Named entity recognition

func namedEntityRecognition(for text: String) {
    tagger.string = text
    let range = NSRange(location: 0, length: text.utf16.count)
    let tags: [NSLinguisticTag] = [.personalName, .placeName, .organizationName]
    tagger.enumerateTags(in: range, unit: .word, scheme: .nameType, options: options) { (tag, tokenRange, stop) in
        if let tag = tag, tags.contains(tag) {
            let name = (text as NSString).substring(with: tokenRange)
            print("\(name): \(tag.rawValue)")
        }
    }
}

namedEntityRecognition(for: quote)


//: # Authored by [AppCoda](https://www.appcoda.com/natural-language-processing-swift/)
