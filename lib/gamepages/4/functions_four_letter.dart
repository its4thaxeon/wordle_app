import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wordle_app/utils/words/4/words.dart';
import 'page_four_letter.dart';

abstract class FourLetterLogic extends State<FourLetterPage> {
  late String actualWord;
  late int gameIndex;
  late List<String> wordsEntered;
  late List<String> backgrounds;
  late bool gameFinished;
  late bool gameResult;
  late String trueLetters;
  late String neutralLetters;
  late String wrongLetters;

  @override
  void initState() {
    super.initState();
    actualWord = words[Random().nextInt(words.length)].toUpperCase();
    print(actualWord);
    gameIndex = 0;
    trueLetters = "";
    neutralLetters = "";
    wrongLetters = "";
    wordsEntered = ["", "", "", ""];
    backgrounds = ["", "", "", ""];
    gameFinished = false;
    gameResult = false;
  }

  void addLetter(String letter) {
    setState(() {
      wordsEntered[gameIndex].length != 4
          ? wordsEntered[gameIndex] += letter
          : true;
    });
  }

  void deleteLetter() {
    setState(() {
      wordsEntered[gameIndex].isNotEmpty
          ? (wordsEntered[gameIndex] = wordsEntered[gameIndex]
              .substring(0, wordsEntered[gameIndex].length - 1))
          : true;
    });
  }

  void evaluateAndChangeBackgrounds() {
    List<String> tempWord = ["", "", "", ""];
    if (wordsEntered[gameIndex].length == 4) {
      for (int i = 0; i < 4; i++) {
        tempWord[i] = actualWord[i];
      }

      for (int i = 0; i < 4; i++) {
        if (tempWord[i] == wordsEntered[gameIndex][i]) {
          backgrounds[gameIndex] += "t";
          tempWord[i] = "";
          trueLetters += wordsEntered[gameIndex][i];
        } else if (tempWord.contains(wordsEntered[gameIndex][i]) &&
            wordsEntered[gameIndex][i] != tempWord[i]) {
          backgrounds[gameIndex] += "n";
          neutralLetters += wordsEntered[gameIndex][i];
          tempWord[tempWord.indexOf(wordsEntered[gameIndex][i])] = "";
        } else if (!(tempWord.contains(wordsEntered[gameIndex][i]))) {
          backgrounds[gameIndex] += "f";
          (neutralLetters.contains(wordsEntered[gameIndex][i]) ||
                  trueLetters.contains(wordsEntered[gameIndex][i]))
              ? (true)
              : wrongLetters += wordsEntered[gameIndex][i];
        }
      }
    }
  }

  void enter() {
    setState(() {
      if (wordsEntered[gameIndex].length == 4 && gameFinished == false) {
        if (gameIndex < 4) {
          evaluateAndChangeBackgrounds();
          if (backgrounds[gameIndex] == "tttt") {
            gameFinished = true;
            gameResult = true;
          } else if (backgrounds[3] != "") {
            gameFinished = true;
            gameResult = false;
          } else {
            gameIndex++;
          }
        } else {
          true;
        }
      }
    });
  }

  void restartGame() {
    setState(() {
      actualWord = words[Random().nextInt(words.length)].toUpperCase();
      gameIndex = 0;
      trueLetters = "";
      neutralLetters = "";
      wrongLetters = "";
      wordsEntered = ["", "", "", "", ""];
      backgrounds = ["", "", "", "", ""];
      gameFinished = false;
    });
  }
}
