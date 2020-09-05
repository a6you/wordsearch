import 'package:flutter/material.dart';

List<List<String>> gridState = [
  ['J', 'A', 'V', 'A', 'K', 'O', 'T', 'L', 'I', 'N'],
  ['O', 'B', 'J', 'E', 'C', 'T', 'I', 'V', 'E', 'C'],
  ['V', 'A', 'R', 'I', 'A', 'B', 'L', 'E', 'A', 'B'],
  ['M', 'O', 'B', 'I', 'L', 'E', 'F', 'T', 'S', 'D'],
  ['L', 'G', 'T', 'Z', 'P', 'T', 'C', 'V', 'I', 'J'],
  ['S', 'V', 'W', 'U', 'Q', 'I', 'K', 'B', 'C', 'G'],
  ['P', 'E', 'O', 'X', 'T', 'J', 'S', 'O', 'W', 'Q'],
  ['D', 'F', 'Y', 'I', 'O', 'S', 'T', 'R', 'Z', 'L'],
  ['E', 'V', 'S', 'Q', 'M', 'K', 'D', 'Y', 'F', 'O'],
  ['F', 'S', 'I', 'N', 'X', 'H', 'J', 'G', 'U', 'W'],
];

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
    ]);
  }

  Widget _buildGridItems(BuildContext context, int index) {
    int gridStateLength = gridState.length;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    return GestureDetector(
      onTap: () => _gridItemTapped(x, y),
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5)),
          child: Center(
            child: _buildGridItem(x, y),
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(int x, int y) {
    return Text(gridState[x][y]);
    /*switch (gridState[x][y]) {
      case '':
        return Text('');
        break;
      case 'P1':
        return Container(
          color: Colors.blue,
        );
        break;
      case 'P2':
        return Container(
          color: Colors.yellow,
        );
        break;
      case 'T':
        return Icon(
          Icons.terrain,
          size: 40.0,
          color: Colors.red,
        );
        break;
      case 'B':
        return Icon(Icons.remove_red_eye, size: 40.0);
        break;
      default:
        return Text(gridState[x][y].toString());
    }*/
  }

  void _gridItemTapped(int x, int y) {
    setState(() {
      gridState[x][y] = 'P1';
    });
  }
}
