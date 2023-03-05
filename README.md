# OpenAIAPI

#### A light wrapper around [**OpenAI**](https://openai.com/api/) API, written in Swift.

The full OpenAI platform docs are here: <https://platform.openai.com/docs/>

### What's Implemented

-   [Completions](#completions)
-   [Edits](#edits)
-   [Audio](#audio)
-   [List models](#list-models)
-   [Retrieve model](#retrieve-model)


## Installation

### Swift Package Manager

1.  Select `File`/`Add Packages` from xcode menu
2.  Paste `https://github.com/tranq72/OpenAIAPI.git`

To update, select `Packages`/`Update to Latest Package Versions`

## Usage

```swift
import OpenAIAPI
let openAI = OpenAIAPI(OpenAIAPIConfig(secret: "..."))
```

##### [Completions](https://platform.openai.com/docs/api-reference/completions)

    let config = OpenAIAPICompletionParms(max_tokens: 500, temperature:0.9)

    openAI.createCompletion(prompt: "Write a poem in the style of Dante about Steve Jobs", config: config) { (result:Result<OpenAIAPICompletionResponse, WebServiceError>) in
        switch result {
           case .success(let success):
              dump(success)
           case .failure(let failure):
              print("\(failure.localizedDescription)")
        }
    }

:bulb: OpenAIAPI supports Swift concurrency, e.g.:

    Task {
          do {
              let result = try await openAI.retrieveModel("text-davinci-003")
              dump(result)
          } catch {
              print(error.localizedDescription)
          }
    }

##### [Edits](https://platform.openai.com/docs/api-reference/edits)

    let config = OpenAIAPIEditParms(n: 2)

    openAI.createEdit(instruction:"Fix spelling and grammar", input:"The pens is an the taible", config: config) { (result:Result<OpenAIAPIEditResponse, WebServiceError>) in
        switch result {
           case .success(let success):
              dump(success)
           case .failure(let failure):
              print("\(failure.localizedDescription)")
        }
    }

##### [Audio](https://platform.openai.com/docs/api-reference/audio)

    let config = OpenAIAPIAudioParms(prompt: nil, response_format:OpenAIAPIResponseFormat.json.name) //, language: Iso639_1.en.code)

    openAI.createTranscription(filedata:audio, filename: "transcript.mp3", config:queryParms) { (result:Result<OpenAIAPIAudioResponse, WebServiceError>) in
        switch result {
           case .success(let success):
              dump(success)
           case .failure(let failure):
              print("\(failure.localizedDescription)")
        }
    }

    openAI.createTranslation(filedata:audio, filename: "transcript.mp3", config:queryParms) { (result:Result<OpenAIAPIAudioResponse, WebServiceError>) in
        switch result {
           case .success(let success):
              dump(success)
           case .failure(let failure):
              print("\(failure.localizedDescription)")
        }
    }

##### [List models](https://platform.openai.com/docs/api-reference/models/list)

    openAI.listModels { (result:Result<OpenAIAPIModelsResponse, WebServiceError>)  in
      switch result {
         case .success(let success):
            dump(success)
         case .failure(let failure):
            print("\(failure.localizedDescription)")
      }
    }

##### [Retrieve model](https://platform.openai.com/docs/api-reference/models/retrieve)

    openAI.retrieveModel("text-davinci-003") { (result:Result<OpenAIAPIModelResponse, WebServiceError>) in
                switch result {
                case .success(let success):
                    dump(success)
                case .failure(let failure):
                    dLog("FAILED: \(failure.localizedDescription)")
                }
            }

### Query parameters

Default values for most parameters can be overridden for each query using the corresponding configuration objects: `OpenAIAPICompletionParms`, `OpenAIAPIEditParms`

For the full list of the supported parameters and their  default values see [OpenAIAPIQueryParms.swift](https://github.com/tranq72/OpenAIAPI/blob/main/Sources/OpenAIAPI/OpenAIAPIQueryParms.swift).
<BR>
For the supported models see [OpenAIAPIModel.swift](https://github.com/tranq72/OpenAIAPI/blob/main/Sources/OpenAIAPI/OpenAIAPIModel.swift).
<BR>
The `createTranscription` request supports an optional `language` parameter (string in ISO-639-1 code, see [Iso639_1.swift](https://github.com/tranq72/OpenAIAPI/blob/main/Sources/OpenAIAPI/Iso639_1.swift)) that can be used as a hint to improve accuracy and latency.

### API secret

Keep your API secret secure and away from client apps.
Instead of directly calling a third party API (like OpenAI, which is a paid service) you better deploy a reverse-proxy in your backend and set the `endpoint` and `secret` parameters accordingly.

## Contributing

This is just an initial draft implementation for a side project. Feel free to raise a pull request if you spot a bug or would like to contribute.

## License

MIT
