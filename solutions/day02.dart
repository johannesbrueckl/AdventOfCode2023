import '../utils/index.dart';

class Day02 extends GenericDay {
  Day02() : super(2);

  @override
  List<String> parseInput() {
    return input.getPerLine();
  }

  @override
  int solvePart1() {
    final input = parseInput();
    const redAllowedCubes = 12;
    const greenAllowedCubes = 13;
    const blueAllowedCubes = 14;
    final validGameIDs = List<int>.empty(growable: true);
    for (final inputLine in input) {
      //print('\n $inputLine');
      final splittedGameInput = inputLine.split(':');
      final gamesSplitted = splittedGameInput.elementAt(1).split(';');
      var cheated = false;
      for (final game in gamesSplitted) {
        final gameCubes = game.split(',');
        //print(game);
        for (final cubes in gameCubes) {
          final cubeAmount = int.parse(cubes.replaceAll(RegExp('[^0-9]'), ''));
          if (cubes.contains('red') && redAllowedCubes < cubeAmount) {
            cheated = true;
            //print('$cubes: $cubeAmount cheated: $cheated');
          } else if (cubes.contains('green') &&
              greenAllowedCubes < cubeAmount) {
            cheated = true;
            //print('$cubes: $cubeAmount cheated: $cheated');
          } else if (cubes.contains('blue') && blueAllowedCubes < cubeAmount) {
            cheated = true;
            //print('$cubes: $cubeAmount cheated: $cheated');
          }
        }
      }
      if (!cheated) {
        final gameID = int.parse(
            splittedGameInput.elementAt(0).replaceAll(RegExp('[^0-9]'), ''),);
        validGameIDs.add(gameID);
        //print('not cheated game $gameID added.');
      }
    }
    return validGameIDs.reduce((a, b) => a + b);
  }

  @override
  int solvePart2() {
    final input = parseInput();
    final minCubeAmounts = List<int>.empty(growable: true);
    for (final inputLine in input) {
      //print('\n $inputLine');
      final splittedGameInput = inputLine.split(':');
      final gamesSplitted = splittedGameInput.elementAt(1).split(';');
      final cubeAmountMap = <String, int>{'red': 0, 'green': 0, 'blue': 0};
      for (final game in gamesSplitted) {
        final gameCubes = game.split(',');
        //print(game);
        for (final cubes in gameCubes) {
          final cubeAmount = int.parse(cubes.replaceAll(RegExp('[^0-9]'), ''));
          if (cubes.contains('red') &&
              cubeAmountMap.values.elementAt(0) < cubeAmount) {
            cubeAmountMap.update('red', (value) => cubeAmount);
            //print('$cubes: $cubeAmount');
          } else if (cubes.contains('green') &&
              cubeAmountMap.values.elementAt(1) < cubeAmount) {
            cubeAmountMap.update('green', (value) => cubeAmount);
            //print('$cubes: $cubeAmount');
          } else if (cubes.contains('blue') &&
              cubeAmountMap.values.elementAt(2) < cubeAmount) {
            cubeAmountMap.update('blue', (value) => cubeAmount);
            //print('$cubes: $cubeAmount');
          }
        }
      }
      minCubeAmounts.add(cubeAmountMap.values.reduce((a, b) => a * b));
    }
    return minCubeAmounts.reduce((a, b) => a + b);
  }
}
