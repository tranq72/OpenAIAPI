//
//  Iso639_1.swift
//
//  Created using ChatGPT on 02/03/23.
//

public enum Iso639_1: String, CaseIterable {
    case aa // Afar
    case ab // Abkhazian
    case af // Afrikaans
    case ak // Akan
    case am // Amharic
    case ar // Arabic
    case `as` // Assamese
    case av // Avaric
    case ay // Aymara
    case az // Azerbaijani
    case ba // Bashkir
    case be // Belarusian
    case bg // Bulgarian
    case bh // Bihari languages
    case bi // Bislama
    case bm // Bambara
    case bn // Bengali, Bangla
    case bo // Tibetan
    case br // Breton
    case bs // Bosnian
    case ca // Catalan
    case ce // Chechen
    case ch // Chamorro
    case co // Corsican
    case cr // Cree
    case cs // Czech
    case cu // Church Slavic, Old Slavonic, Church Slavonic, Old Bulgarian, Old Church Slavonic
    case cv // Chuvash
    case cy // Welsh
    case da // Danish
    case de // German
    case dv // Divehi, Dhivehi, Maldivian
    case dz // Dzongkha
    case ee // Ewe
    case el // Greek (Modern)
    case en // English
    case eo // Esperanto
    case es // Spanish, Castilian
    case et // Estonian
    case eu // Basque
    case fa // Persian (Farsi)
    case ff // Fulah
    case fi // Finnish
    case fj // Fijian
    case fo // Faroese
    case fr // French
    case fy // Western Frisian
    case ga // Irish
    case gd // Scottish Gaelic, Gaelic
    case gl // Galician
    case gn // Guarani
    case gu // Gujarati
    case gv // Manx
    case ha // Hausa
    case he // Hebrew (modern)
    case hi // Hindi
    case ho // Hiri Motu
    case hr // Croatian
    case ht // Haitian, Haitian Creole
    case hu // Hungarian
    case hy // Armenian
    case hz // Herero
    case ia // Interlingua (International Auxiliary Language Association)
    case id // Indonesian
    case ie // Interlingue, Occidental
    case ig // Igbo
    case ii // Sichuan Yi, Nuosu
    case ik // Inupiaq
    case io // Ido
    case `is` // Icelandic
    case it // Italian
    case iu // Inuktitut
    case ja // Japanese
    case jv // Javanese
    case ka // Georgian
    case kg // Kongo
    case ki // Kikuyu, Gikuyu
    case kj // Kuanyama, Kwanyama
    case kk // Kazakh
    case kl // Kalaallisut, Greenlandic
    case km // Central Khmer
    case kn // Kannada
    case ko // Korean
    case kr // Kanuri
    case ks // Kashmiri
    case ku // Kurdish
    case kv // Komi
    case kw // Cornish
    case ky // Kirghiz, Kyrgyz
    case la // Latin
    case lb // Luxembourgish
    case lg // Ganda
    case li // Limburgish
    case ln // Lingala
    case lo // Lao
    case lt // Lithuanian
    case lu // Luba-Katanga
    case lv // Latvian
    case mg // Malagasy
    case mh // Marshallese
    case mi // Maori
    case mk // Macedonian
    case ml // Malayalam
    case mn // Mongolian
    case mr // Marathi
    case ms // Malay
    case mt // Maltese
    case my // Burmese
    case na // Nauru
    case nb // Norwegian Bokmål
    case nd // North Ndebele
    case ne // Nepali
    case ng // Ndonga
    case nl // Dutch
    case nn // Norwegian Nynorsk
    case no // Norwegian
    case nr // South Ndebele
    case nv // Navajo, Navaho
    case ny // Chichewa, Chewa, Nyanja
    case oc // Occitan
    case oj // Ojibwe, Ojibwa
    case om // Oromo
    case or // Oriya
    case os // Ossetian, Ossetic
    case pa // Panjabi, Punjabi
    case pi // Pali
    case pl // Polish
    case ps // Pashto, Pushto
    case pt // Portuguese
    case qu // Quechua
    case rm // Romansh
    case rn // Kirundi
    case ro // Romanian
    case ru // Russian
    case rw // Kinyarwanda
    case sa // Sanskrit
    case sc // Sardinian
    case sd // Sindhi
    case se // Northern Sami
    case sg // Sango
    case si // Sinhalese, Sinhala
    case sk // Slovak
    case sl // Slovenian
    case sm // Samoan
    case sn // Shona
    case so // Somali
    case sq // Albanian
    case sr // Serbian
    case ss // Swati
    case st // Southern Sotho
    case su // Sundanese
    case sv // Swedish
    case sw // Swahili
    case ta // Tamil
    case te // Telugu
    case tg // Tajik
    case th // Thai
    case ti // Tigrinya
    case tk // Turkmen
    case tl // Tagalog
    case tn // Tswana
    case to // Tonga (Tonga Islands)
    case tr // Turkish
    case ts // Tsonga
    case tt // Tatar
    case tw // Twi
    case ty // Tahitian
    case ug // Uyghur, Uighur
    case uk // Ukrainian
    case ur // Urdu
    case uz // Uzbek
    case ve // Venda
    case vi // Vietnamese
    case vo // Volapük
    case wa // Walloon
    case wo // Wolof
    case xh // Xhosa
    case yi // Yiddish
    case yo // Yoruba
    case za // Zhuang, Chuang
    case zh // Chinese
    case zu // Zulu
    
    public var code: String {
        return String(describing: self)
    }
    public var languageName: String {
        switch self {
        case .aa: return "Afar"
        case .ab: return "Abkhazian"
        case .af: return "Afrikaans"
        case .ak: return "Akan"
        case .am: return "Amharic"
        case .ar: return "Arabic"
        case .as: return "Assamese"
        case .av: return "Avaric"
        case .ay: return "Aymara"
        case .az: return "Azerbaijani"
        case .ba: return "Bashkir"
        case .be: return "Belarusian"
        case .bg: return "Bulgarian"
        case .bh: return "Bihari languages"
        case .bi: return "Bislama"
        case .bm: return "Bambara"
        case .bn: return "Bengali, Bangla"
        case .bo: return "Tibetan"
        case .br: return "Breton"
        case .bs: return "Bosnian"
        case .ca: return "Catalan"
        case .ce: return "Chechen"
        case .ch: return "Chamorro"
        case .co: return "Corsican"
        case .cr: return "Cree"
        case .cs: return "Czech"
        case .cu: return "Church Slavic, Old Slavonic, Church Slavonic, Old Bulgarian, Old Church Slavonic"
        case .cv: return "Chuvash"
        case .cy: return "Welsh"
        case .da: return "Danish"
        case .de: return "German"
        case .dv: return "Divehi, Dhivehi, Maldivian"
        case .dz: return "Dzongkha"
        case .ee: return "Ewe"
        case .el: return "Greek (Modern)"
        case .en: return "English"
        case .eo: return "Esperanto"
        case .es: return "Spanish, Castilian"
        case .et: return "Estonian"
        case .eu: return "Basque"
        case .fa: return "Persian (Farsi)"
        case .ff: return "Fulah"
        case .fi: return "Finnish"
        case .fj: return "Fijian"
        case .fo: return "Faroese"
        case .fr: return "French"
        case .fy: return "Western Frisian"
        case .ga: return "Irish"
        case .gd: return "Scottish Gaelic, Gaelic"
        case .gl: return "Galician"
        case .gn: return "Guarani"
        case .gu: return "Gujarati"
        case .gv: return "Manx"
        case .ha: return "Hausa"
        case .he: return "Hebrew (modern)"
        case .hi: return "Hindi"
        case .ho: return "Hiri Motu"
        case .hr: return "Croatian"
        case .ht: return "Haitian, Haitian Creole"
        case .hu: return "Hungarian"
        case .hy: return "Armenian"
        case .hz: return "Herero"
        case .ia: return "Interlingua (International Auxiliary Language Association)"
        case .id: return "Indonesian"
        case .ie: return "Interlingue, Occidental"
        case .ig: return "Igbo"
        case .ii: return "Sichuan Yi, Nuosu"
        case .ik: return "Inupiaq"
        case .io: return "Ido"
        case .is: return "Icelandic"
        case .it: return "Italian"
        case .iu: return "Inuktitut"
        case .ja: return "Japanese"
        case .jv: return "Javanese"
        case .ka: return "Georgian"
        case .kg: return "Kongo"
        case .ki: return "Kikuyu, Gikuyu"
        case .kj: return "Kuanyama, Kwanyama"
        case .kk: return "Kazakh"
        case .kl: return "Kalaallisut, Greenlandic"
        case .km: return "Central Khmer"
        case .kn: return "Kannada"
        case .ko: return "Korean"
        case .kr: return "Kanuri"
        case .ks: return "Kashmiri"
        case .ku: return "Kurdish"
        case .kv: return "Komi"
        case .kw: return "Cornish"
        case .ky: return "Kirghiz, Kyrgyz"
        case .la: return "Latin"
        case .lb: return "Luxembourgish, Letzeburgesch"
        case .lg: return "Ganda"
        case .li: return "Limburgish"
        case .ln: return "Lingala"
        case .lo: return "Lao"
        case .lt: return "Lithuanian"
        case .lu: return "Luba-Katanga"
        case .lv: return "Latvian"
        case .mg: return "Malagasy"
        case .mh: return "Marshallese"
        case .mi: return "Maori"
        case .mk: return "Macedonian"
        case .ml: return "Malayalam"
        case .mn: return "Mongolian"
        case .mr: return "Marathi"
        case .ms: return "Malay"
        case .mt: return "Maltese"
        case .my: return "Burmese"
        case .na: return "Nauru"
        case .nb: return "Norwegian Bokmål"
        case .nd: return "North Ndebele"
        case .ne: return "Nepali"
        case .ng: return "Ndonga"
        case .nl: return "Dutch"
        case .nn: return "Norwegian Nynorsk"
        case .no: return "Norwegian"
        case .nr: return "South Ndebele"
        case .nv: return "Navajo, Navaho"
        case .ny: return "Chichewa, Chewa, Nyanja"
        case .oc: return "Occitan"
        case .oj: return "Ojibwe, Ojibwa"
        case .om: return "Oromo"
        case .or: return "Oriya"
        case .os: return "Ossetian, Ossetic"
        case .pa: return "Panjabi, Punjabi"
        case .pi: return "Pali"
        case .pl: return "Polish"
        case .ps: return "Pashto, Pushto"
        case .pt: return "Portuguese"
        case .qu: return "Quechua"
        case .rm: return "Romansh"
        case .rn: return "Kirundi"
        case .ro: return "Romanian"
        case .ru: return "Russian"
        case .rw: return "Kinyarwanda"
        case .sa: return "Sanskrit"
        case .sc: return "Sardinian"
        case .sd: return "Sindhi"
        case .se: return "Northern Sami"
        case .sg: return "Sango"
        case .si: return "Sinhalese, Sinhala"
        case .sk: return "Slovak"
        case .sl: return "Slovenian"
        case .sm: return "Samoan"
        case .sn: return "Shona"
        case .so: return "Somali"
        case .sq: return "Albanian"
        case .sr: return "Serbian"
        case .ss: return "Swati"
        case .st: return "Southern Sotho"
        case .su: return "Sundanese"
        case .sv: return "Swedish"
        case .sw: return "Swahili"
        case .ta: return "Tamil"
        case .te: return "Telugu"
        case .tg: return "Tajik"
        case .th: return "Thai"
        case .ti: return "Tigrinya"
        case .tk: return "Turkmen"
        case .tl: return "Tagalog"
        case .tn: return "Tswana"
        case .to: return "Tonga (Tonga Islands)"
        case .tr: return "Turkish"
        case .ts: return "Tsonga"
        case .tt: return "Tatar"
        case .tw: return "Twi"
        case .ty: return "Tahitian"
        case .ug: return "Uyghur, Uighur"
        case .uk: return "Ukrainian"
        case .ur: return "Urdu"
        case .uz: return "Uzbek"
        case .ve: return "Venda"
        case .vi: return "Vietnamese"
        case .vo: return "Volapük"
        case .wa: return "Walloon"
        case .wo: return "Wolof"
        case .xh: return "Xhosa"
        case .yi: return "Yiddish"
        case .yo: return "Yoruba"
        case .za: return "Zhuang, Chuang"
        case .zh: return "Chinese"
        case .zu: return "Zulu"
        }
    }
}
