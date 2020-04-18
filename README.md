# lemmatizer

  

Lemmatizer for text in English. Inspired by Python&#x27;s nltk.corpus.reader.wordnet.morphy
## Installing:
In your pubspec.yaml
```yaml
dependencies:
  lemmatizer: ^0.0.1
```
```dart
import  'package:lemmatizer/lemmatizer.dart';
```


## Basic Usage:
```dart
Lemmatizer lemmatizer =  new  Lemmatizer();
...
_text = lemmatizer.lemma(_controller.text);
```
<br>
<br>
   
## License
This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details
