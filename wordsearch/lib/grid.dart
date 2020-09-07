import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

List<List<String>> gridState = [
  ['J', 'A', 'V', 'A', 'K', 'O', 'T', 'L', 'I', 'N'],
  ['O', 'B', 'J', 'E', 'C', 'T', 'I', 'V', 'E', 'C'],
  ['V', 'J', 'R', 'I', 'A', 'J', 'L', 'E', 'A', 'E'],
  ['M', 'V', 'V', 'R', 'L', 'E', 'F', 'T', 'L', 'D'],
  ['S', 'O', 'I', 'A', 'A', 'C', 'C', 'B', 'E', 'J'],
  ['B', 'S', 'W', 'I', 'F', 'T', 'A', 'B', 'L', 'G'],
  ['P', 'E', 'O', 'S', 'W', 'I', 'F', 'T', 'I', 'Q'],
  ['D', 'F', 'Y', 'I', 'R', 'V', 'A', 'R', 'B', 'L'],
  ['E', 'V', 'S', 'A', 'M', 'E', 'D', 'B', 'O', 'O'],
  ['F', 'S', 'V', 'N', 'X', 'C', 'J', 'G', 'M', 'W'],
];

List<List<String>> targetWords = [
  ['J', 'A', 'V', 'A'],
  ['O', 'B', 'J', 'E', 'C', 'T', 'I', 'V', 'E', 'C'],
  ['V', 'A', 'R', 'I', 'A', 'B', 'L', 'E'],
  ['M', 'O', 'B', 'I', 'L', 'E'],
  ['K', 'O', 'T', 'L', 'I', 'N'],
  ['S', 'W', 'I', 'F', 'T'],
];

List<String> selectedLetters = [];

List<List<int>> selectedCoordinates = [];

int wordsFound = 0;
String winMessage = "";

class Board extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Board> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildGameBody(),
    );
  }

  // Responsible for building the layout of the game including
  // the board, the list of words to be found, and the number
  // of found words
  Widget _buildGameBody() {
    int gridStateLength = gridState.length;
    int targetWordsLength = targetWords.length;
    return Column(children: <Widget>[
      AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2.0)),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridStateLength,
            ),
            itemBuilder: _buildGridItems,
            itemCount: gridStateLength * gridStateLength,
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(1.0),
                margin: const EdgeInsets.all(2.0),
                child: Text("JAVA"),
              ),
              Container(
                padding: const EdgeInsets.all(1.0),
                margin: const EdgeInsets.all(2.0),
                child: Text("OBJECTIVE C"),
              ),
              Container(
                padding: const EdgeInsets.all(1.0),
                margin: const EdgeInsets.all(2.0),
                child: Text("VARIABLE"),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(1.0),
                margin: const EdgeInsets.all(2.0),
                child: Text("MOBILE"),
              ),
              Container(
                padding: const EdgeInsets.all(1.0),
                margin: const EdgeInsets.all(2.0),
                child: Text("KOTLIN"),
              ),
              Container(
                padding: const EdgeInsets.all(1.0),
                margin: const EdgeInsets.all(2.0),
                child: Text("SWIFT"),
              ),
            ],
          ),
        ],
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 2.0)),
        child: Text(
            "Words Found: " + wordsFound.toString() + "/$targetWordsLength"),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        child: Text(winMessage),
      ),
    ]);
  }

  // Constructs tappable grid tiles that correspond to the letters
  // in the word search
  Widget _buildGridItems(BuildContext context, int index) {
    int gridStateLength = gridState.length;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);

    return GestureDetector(
      onTap: () {
        _gridItemTapped(x, y);
      },
      onDoubleTap: () {
        _selectionCheck(selectedLetters);
        if (_winCheck()) {
          print("You win!");
        }
      },
      child: GridTile(
          child: Center(
        child: Container(
          child: _buildGridItem(x, y),
        ),
      )),
    );
  }

  // Colors in individual tiles based on whether or not they have
  // been clicked and/or are part of a word in targetWords
  Widget _buildGridItem(int x, int y) {
    if (gridState[x][y].contains('0')) {
      String letter = gridState[x][y].substring(0, 1);
      return Container(
          decoration: BoxDecoration(color: Colors.blue),
          child: Center(
              child: Text(
            letter,
            style: TextStyle(
              color: Colors.white,
            ),
          )));
    } else {
      return Text(gridState[x][y]);
    }
  }

  // Remembers tapped tiles and their coordinates until the user confirms
  // that they have finished selecting a set of tiles
  void _gridItemTapped(int x, int y) {
    setState(() {
      if (!gridState[x][y].contains('0')) {
        selectedLetters.add(gridState[x][y]);
      } else {
        selectedLetters.add(gridState[x][y].substring(0, 1));
      }
      print(selectedLetters.toString());
      selectedCoordinates.add([x, y]);
      gridState[x][y] = gridState[x][y] + '0';
    });
  }

  // Checks to see if the set of selected words is a word in the
  // list of target words
  void _selectionCheck(List<String> selection) {
    int gridStateLength = targetWords.length;
    bool wordFound = false;

    for (int i = 0; i < gridStateLength; i++) {
      if (const IterableEquality().equals(selection, targetWords[i])) {
        wordFound = true;
      }
    }
    if (wordFound) {
      print("Word found!");
      setState(() {
        wordsFound++;
      });
    } else {
      print("Word not found!");
      _unselectTiles();
    }
    selectedLetters = [];
    selectedCoordinates = [];
  }

  // Deselects all tiles that were part of an unsuccessful selection
  // of letters (the selection did not match a word in the target words)
  void _unselectTiles() {
    int selectedCoordinatesLength = selectedCoordinates.length;

    for (int i = 0; i < selectedCoordinatesLength; i++) {
      int xVal = selectedCoordinates[i][0];
      int yVal = selectedCoordinates[i][1];
      int gridValLength = gridState[xVal][yVal].length;
      gridState[xVal][yVal] =
          gridState[xVal][yVal].substring(0, gridValLength - 1);
      setState(() {
        _buildGridItem(xVal, yVal);
      });
    }

    selectedCoordinates = [];
  }

  // Notifies the player if he/she has won
  bool _winCheck() {
    int targetWordsLength = targetWords.length;
    if (targetWordsLength == wordsFound) {
      setState(() {
        winMessage = "You win!";
      });
    }
    return targetWordsLength == wordsFound;
  }
}
