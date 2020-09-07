import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

List<List<String>> gridState = [
  ['J', 'A', 'V', 'A', 'K', 'O', 'T', 'L', 'I', 'N'],
  ['O', 'B', 'J', 'E', 'C', 'T', 'I', 'V', 'E', 'C'],
  ['V', 'A', 'R', 'I', 'A', 'B', 'L', 'E', 'A', 'B'],
  ['M', 'O', 'B', 'I', 'L', 'E', 'F', 'T', 'S', 'D'],
  ['S', 'W', 'I', 'F', 'T', 'A', 'C', 'V', 'I', 'J'],
  ['S', 'V', 'W', 'U', 'Q', 'I', 'K', 'B', 'C', 'G'],
  ['P', 'E', 'O', 'X', 'T', 'J', 'S', 'O', 'W', 'Q'],
  ['D', 'F', 'Y', 'I', 'O', 'S', 'T', 'R', 'Z', 'L'],
  ['E', 'V', 'S', 'Q', 'M', 'K', 'D', 'Y', 'F', 'O'],
  ['F', 'S', 'I', 'N', 'X', 'H', 'J', 'G', 'U', 'W'],
];

List<List<String>> targetWords = [
  ['J', 'A', 'V', 'A'],
  //'O', 'B', 'J', 'E', 'C', 'T', 'I', 'V', 'E', 'C'],
  //['V', 'A', 'R', 'I', 'A', 'B', 'L', 'E'],
  //['M', 'O', 'B', 'I', 'L', 'E'],
  //['K', 'O', 'T', 'L', 'I', 'N'],
  ['S', 'W', 'I', 'F', 'T'],
];

List<String> selectedLetters = [];

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
      appBar: AppBar(
        title: Text('Game Home'),
      ),
      body: _buildGameBody(),
    );
  }

  Widget _buildGameBody() {
    int gridStateLength = gridState.length;
    //print(gridStateLength);
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
      Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 2.0)),
        child: Text("Words Found: " + wordsFound.toString()),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        //decoration:
        //BoxDecoration(border: Border.all(color: Colors.black, width: 2.0)),
        child: Text(winMessage),
      ),
    ]);
  }

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

  Widget _buildGridItem(int x, int y) {
    if (gridState[x][y].contains('0')) {
      String letter = gridState[x][y].substring(0, 1);
      return Container(
          decoration: BoxDecoration(color: Colors.blue),
          //color: Colors.blue,
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

  void _gridItemTapped(int x, int y) {
    setState(() {
      if (!gridState[x][y].contains('0')) {
        selectedLetters.add(gridState[x][y]);
        print(selectedLetters.toString());
        gridState[x][y] = gridState[x][y] + '0';
      }
    });
  }

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
      _unselectTiles(gridState);
    }
    selectedLetters = [];
  }

  void _unselectTiles(List<List<String>> grid) {
    int targetWordsLength = targetWords.length;

    for (int i = 0; i < targetWordsLength; i++) {
      for (int j = 0; j < targetWordsLength; j++) {
        if (gridState[i][j].contains('0')) {
          gridState[i][j] = gridState[i][j].substring(0, 1);
          _buildGridItem(i, j);
        }
      }
    }
  }

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
