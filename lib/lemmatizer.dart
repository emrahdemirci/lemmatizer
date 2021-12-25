library lemmatizer;

import 'package:flutter/services.dart';

enum POS { NOUN, VERB, ADJ, ADV, ABBR, UNKNOWN }

class Lemmatizer {
  static const WN_FILES = {
    POS.NOUN: ['index_noun.txt', 'noun_exc.txt'],
    POS.VERB: ['index_verb.txt', 'verb_exc.txt'],
    POS.ADJ: ['index_adj.txt', 'adj_exc.txt'],
    POS.ADV: ['index_adv.txt', 'adv_exc.txt']
  };

  static const MORPHOLOGICAL_SUBSTITUTIONS = {
    POS.NOUN: [
      ['s', ''],
      ['ses', 's'],
      ['ves', 'f'],
      ['xes', 'x'],
      ['zes', 'z'],
      ['ches', 'ch'],
      ['shes', 'sh'],
      ['men', 'man'],
      ['ies', 'y']
    ],
    POS.VERB: [
      ['s', ''],
      ['ies', 'y'],
      ['ied', 'y'],
      ['es', 'e'],
      ['es', ''],
      ['ed', 'e'],
      ['ed', ''],
      ['ing', 'e'],
      ['ing', '']
    ],
    POS.ADJ: [
      ['er', ''],
      ['est', ''],
      ['er', 'e'],
      ['est', 'e']
    ],
    POS.ADV: [],
    POS.ABBR: [],
    POS.UNKNOWN: []
  };

  var wordlists = {};
  var exceptions = {};

  Lemmatizer() {
    wordlists = {};
    exceptions = {};

    for (var item in MORPHOLOGICAL_SUBSTITUTIONS.keys) {
      wordlists[item] = {};
      exceptions[item] = {};
    }

    for (var entry in WN_FILES.entries) {
      loadWordnetFiles(entry.key, entry.value[0], entry.value[1]);
    }
  }

  String lemma(form, {String? pos}) {
    var words = ["verb", "noun", "adj", "adv", "abbr"];
    if (!words.contains(pos)) {
      for (var item in words) {
        var result = lemma(form, pos: item);
        if (result != form) {
          return result;
        }
      }
      return form;
    }

    POS poss = strToPos(pos);
    var ea = eachLemma(form, poss);
    if (ea != null) {
      return ea;
    }
    return form;
  }

  Future<void> loadWordnetFiles(POS pos, list, exc) async {
    var fileList =
        await rootBundle.loadString("packages/lemmatizer/assets/" + list);
    var listLines = fileList.split("\n");

    for (var line in listLines) {
      var w = line.split(" ")[0];
      wordlists[pos][w] = w;
    }

    var fileExc =
        await rootBundle.loadString("packages/lemmatizer/assets/" + exc);
    var listExc = fileExc.split("\n");

    if (fileExc.trim().length > 0) {
      for (var line in listExc) {
        if (line.trim().length > 0) {
          var w = line.split(" ")[0];
          exceptions[pos][w[0]] = exceptions[pos][w[0]] ?? [];
          exceptions[pos][w[0]] = w[1];
        }
      }
    }
  }

  eachLemma(String form, POS pos) {
    var lemma = exceptions[pos][form];
    if (lemma != null) {
      return lemma;
    }

    if (pos == POS.NOUN && form.endsWith('ful')) {
      return eachLemma(form.substring(0, form.length - 3), pos) +
          "ful"; //todo : bak
    }

    return eachSubstitutions(form, pos);
  }

  eachSubstitutions(String form, POS pos) {
    var lemma = wordlists[pos][form];
    if (lemma != null) {
      return lemma;
    }

    var lst = MORPHOLOGICAL_SUBSTITUTIONS[pos]!;
    for (var item in lst) {
      var _old = item[0];
      var _new = item[1];
      if (form.endsWith(_old)) {
        var res = eachSubstitutions(
            form.substring(0, form.length - _old.length as int?) + _new, pos);
        if (res != null) {
          return res;
        }
      }
    }
  }

  POS strToPos(String? str) {
    switch (str) {
      case "n":
      case "noun":
        return POS.NOUN;
        break;
      case "v":
      case "verb":
        return POS.VERB;
        break;
      case "a":
      case "j":
      case "adjective":
      case "adj":
        return POS.ADJ;
        break;
      case "r":
      case "adverb":
      case "adv":
        return POS.ABBR;
      default:
        return POS.UNKNOWN;
        break;
    }
  }
}
