# OpenAIAPI

#### A light wrapper around [**OpenAI**](https://openai.com/api/) API, written in Swift.
The full OpenAI platform docs are here: https://platform.openai.com/docs/

### What's Implemented
- [Completions](https://platform.openai.com/docs/api-reference/completions)
- [Edits](https://platform.openai.com/docs/api-reference/edits)
- ...


## Installation
### Swift Package Manager

1. Select `File`/`Add Packages` from xcode menu
1. Paste `https://github.com/tranq72/OpenAIAPI.git`

To update, select `Packages`/`Update to Latest Package Versions`

## Usage

```swift
import OpenAIAPI
let openAI = OpenAIAPI(OpenAIAPIConfig(secret: "..."))
```

```
let config = OpenAIAPIEditParms(n: 2)
openAI.createEdit(instruction:"Fix spelling and grammar", input:"The pens is an the taible", config: config) { result in
    switch result {
       case .success(let success):
          dump(success)
       case .failure(let failure):
          print("\(failure.localizedDescription)")
    }
}
```

```
let queryParms = OpenAIAPICompletionParms(max_tokens: 500, temperature:0.9)
openAI.createCompletion(prompt: "Write a poem in the style of Dante about Steve Jobs", config: queryParms) { result in
    switch result {
       case .success(let success):
          dump(success)
       case .failure(let failure):
          print("\(failure.localizedDescription)")
    }
}
```

### Query parameters

Default values for most parameters can be overridden for each query using the corresponding configuration objects: `OpenAIAPICompletionParms`, `OpenAIAPIEditParms`

For the full list of the supported parameters and their  default values see [OpenAIAPIQueryParms.swift](https://github.com/tranq72/OpenAIAPI/blob/main/Sources/OpenAIAPI/OpenAIAPIQueryParms.swift).
<BR>
For the supported models see [OpenAIAPIModel.swift](https://github.com/tranq72/OpenAIAPI/blob/main/Sources/OpenAIAPI/OpenAIAPIModel.swift).

### API secret

Keep your API secret secure and away from client apps.
Instead of directly calling a third party API (like OpenAI, which is a paid service) you better deploy a reverse-proxy in your backend and set the `endpoint` and `secret` parameters accordingly.

## Contributing
This is just an initial draft implementation for a side project. Feel free to raise a pull request if you spot a bug or would like to contribute.

## License
MIT
