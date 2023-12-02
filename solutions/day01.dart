import 'dart:io';
import 'package:path/path.dart' as path;
import '../utils/index.dart';

class Day01 extends GenericDay {
  Day01() : super(1);

  File inputFile = File(path.join(Directory.current.path, r'input\aoc01.txt'));

  Map<String, String> regexWordsMap = {
    'one': '1',
    'two': '2',
    'three': '3',
    'four': '4',
    'five': '5',
    'six': '6',
    'seven': '7',
    'eight': '8',
    'nine': '9',
    '1': '1',
    '2': '2',
    '3': '3',
    '4': '4',
    '5': '5',
    '6': '6',
    '7': '7',
    '8': '8',
    '9': '9'
  };

  @override
  List<String> parseInput() {
    return readInputFile(inputFile);
  }

  @override
  int solvePart1() {
    final inputList = readInputFile(inputFile);

    final numbers = convertingToInt(inputList);

    return calcRes(numbers);
  }

  @override
  int solvePart2() {
    final inputList = readInputFile(inputFile);

    final inputNoWords = wordToDigit(inputList, regexWordsMap);

    final numbers = convertingToInt(inputNoWords);

    return calcRes(numbers);
  }
}

//read file.
List<String> readInputFile(File inputFile) {
  var inputList = List<String>.empty(growable: true);
  try {
    inputList = inputFile.readAsLinesSync();
  } catch (error) {
    print('file reading failed: $error');
  }
  return inputList;
}

//adds up the numbers.
int calcRes(List<int> numbers) {
  var result = 0;
  for (final element in numbers) {
    result += element;
  }
  return result;
}

//get rid of non digets. takes first and last one. makes int of it.
List<int> convertingToInt(List<String> inputNoWords) {
  final numbers = List<int>.empty(growable: true);
  for (final element in inputNoWords) {
    final numberStringRaw = element.replaceAll(RegExp('[^0-9]'), '');

    var numberString = '';

    if (numberStringRaw.length > 1) {
      final string1 = numberStringRaw.substring(0, 1);
      final string2 = numberStringRaw.substring(
          numberStringRaw.length - 1, numberStringRaw.length,);
      numberString = string1 + string2;
    } else {
      numberString = numberStringRaw + numberStringRaw;
    }

    numbers.add(int.parse(numberString));
  }
  return numbers;
}

//replaces words with digets.
List<String> wordToDigit(
    List<String> inputList, Map<String, String> regexWordsMap,) {
  final inputNoWords = List<String>.empty(growable: true);
  for (final element in inputList) {
    var inputString = element;
    var squished = false;

    final foundDigits = <int, String>{};
    for (final word in regexWordsMap.entries) {
      if (inputString.contains(word.key)) {
        final indexFirst = inputString.indexOf(word.key);
        final indexLast = inputString.lastIndexOf(word.key);
        foundDigits.addAll({indexFirst: word.key, indexLast: word.key});
      }
    }

    if (foundDigits.length == 2) {
      var sizeWords = 0;
      for (final element in foundDigits.entries) {
        sizeWords += element.value.length;
      }
      if (sizeWords > inputString.length) {
        squished = true;
      }
    }

    if (foundDigits.isNotEmpty) {
      final maxKey = foundDigits.keys.reduce((a, b) => a >= b ? a : b);
      final minKey = foundDigits.keys.reduce((a, b) => a <= b ? a : b);
      final firstDigitString = foundDigits[minKey];
      final lastDigitString = foundDigits[maxKey];

      final firstDigit = regexWordsMap.entries
          .where((element) => element.key == firstDigitString)
          .first
          .value;
      final lastDigit = regexWordsMap.entries
          .where((element) => element.key == lastDigitString)
          .first
          .value;

      if (squished) {
        inputString = firstDigit + lastDigit;
      } else {
        inputString = inputString.replaceFirst(firstDigitString!, firstDigit);

        inputString = inputString.replaceAll(lastDigitString!, lastDigit);
      }
    }
    inputNoWords.add(inputString);
  }
  return inputNoWords;
}
