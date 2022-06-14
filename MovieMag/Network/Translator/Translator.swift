//
//  Translator.swift
//  MovieMag
//
//  Created by pc on 14.06.2022.
//

import Foundation
import MLKitTranslate
import NaturalLanguage

struct Translator {
    let options = TranslatorOptions(sourceLanguage: .english, targetLanguage: .turkish)
    let englishTurkishTranslator = NaturalLanguage.natural
}
