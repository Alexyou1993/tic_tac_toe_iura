import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic tac toe by Iura',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Tic tac toe by Iura'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    _matrix = List<List<dynamic>>(3);
    for (int i = 0; i < _matrix.length; i++) {
      _matrix[i] = List<dynamic>(3);
      for (int j = 0; j < _matrix[i].length; j++) {
        _matrix[i][j] = ' ';
      }
    }
  }

  final List<int> list = List<int>.generate(9, (int index) => index);
  List<List<dynamic>> _matrix;
  String _lastChar = 'o';
  int pointX = 0;
  int pointO = 0;
  bool show = false;
  bool win = false;
  String _displayMessage = '';

  GestureDetector _buildElement(int i, int j) {
    return GestureDetector(
      onTap: () {
        _changeMatrixField(i, j);
        _checkWinner(i, j);
        _checkIfTie();
      },
      child: Container(
        width: 64,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Text(
          _matrix[i][j].toString(),
          style: const TextStyle(
            fontSize: 52,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _initMatrix() {
    for (int x = 0; x < _matrix.length; x++) {
      for (int y = 0; y < _matrix.length; y++) {
        setState(() {
          _matrix[x][y] = ' ';
        });
      }
    }
    win = false;
  }

  void _changeMatrixField(int x, int y) {
    setState(() {
      if (_matrix[x][y] == ' ') {
        if (_lastChar == 'o') {
          setState(() {
            _matrix[x][y] = 'x';
          });
        } else {
          setState(() {
            _matrix[x][y] = 'o';
          });
        }
        _lastChar = _matrix[x][y].toString();
      }
    });
  }

  void _checkWinner(int x, int y) {
    int col = 0, row = 0, diag = 0, rdiag = 0;
    final int n = _matrix.length;
    final String player = _matrix[x][y].toString();
    for (int i = 0; i < n; i++) {
      if (_matrix[x][i] == player) {
        setState(() => col++);
      }
      if (_matrix[i][y] == player) {
        setState(() => row++);
      }
      if (_matrix[i][i] == player) {
        setState(() => diag++);
      }
      if (_matrix[i][n - 1 - i] == player) {
        setState(() => rdiag++);
      }
    }
    if (row == n || col == n || diag == n || rdiag == n) {
      setState(() {
        _displayMessage = '$player won';
        win = true;
        _initMatrix();
      });
      if (player == 'x') {
        setState(() {
          pointX++;
        });
      } else {
        setState(() {
          pointO++;
        });
      }
    }
  }

  void _checkIfTie() {
    int countX = 0;
    int countY = 0;
    for (int x = 0; x < _matrix.length; x++) {
      for (int y = 0; y < _matrix.length; y++) {
        if (_matrix[x][y] == 'x') {
          setState(() {
            countX++;
          });
        } else if (_matrix[x][y] == 'o') {
          setState(() {
            countY++;
          });
        }
      }
      if (win == false) {
        if (countX > 3 || countY > 3) {
          setState(() {
            _displayMessage = "'it's a tie";
            _initMatrix();
          });
        }
      }
    }
  }

  void _initScore() {
    setState(() {
      pointX = 0;
      pointO = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Score: ',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.grey,
              backgroundColor: Colors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(16),
                child: Text(
                  'X:$pointX',
                  style: const TextStyle(
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                child: Text(
                  'O:$pointO',
                  style: const TextStyle(
                      color: Colors.blue,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildElement(0, 0),
              _buildElement(0, 1),
              _buildElement(0, 2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildElement(1, 0),
              _buildElement(1, 1),
              _buildElement(1, 2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildElement(2, 0),
              _buildElement(2, 1),
              _buildElement(2, 2),
            ],
          ),
          Text(
            _displayMessage,
            style: const TextStyle(color: Colors.white),
          ),
          FlatButton(
            color: Colors.grey[800],
            child: const Text(
              'Reset Game',
              style:
                  TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
            ),
            onPressed: () {
              setState(() {
                _initMatrix();
                _displayMessage = '';
              });
            },
          ),
          FlatButton(
            color: Colors.grey[800],
            child: const Text(
              'Reset Score',
              style:
                  TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
            ),
            onPressed: () {
              _initScore();
              _initMatrix();
            },
          )
        ],
      ),
    );
  }
}
