# lemmatizer
## This project is discontinued. Suggested replacement :github.com/xErik/lemmatizerx
  

Lemmatizer for text in English. Inspired by Python's nltk.corpus.reader.wordnet.morphy
## Installing:
In your pubspec.yaml
```yaml
dependencies:
  lemmatizer: ^1.0.0
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
