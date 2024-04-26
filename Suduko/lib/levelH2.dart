import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'levelH3.dart';

class SudokuGameLevelH2 extends StatefulWidget {
  const SudokuGameLevelH2({Key? key}) : super(key: key);

  @override
  _SudokuGameLevelH2State createState() => _SudokuGameLevelH2State();
}

class _SudokuGameLevelH2State extends State<SudokuGameLevelH2> {
  late List<List<int>> sudokuBoard;
  late List<List<bool>> isOriginal; // To track original puzzle numbers
  int selectedRow = -1;
  int selectedCol = -1;
  late Stopwatch _stopwatch;
  late Timer _timer;

  final List<List<int>> solutionBoard = [
    [9, 7, 6, 5, 1, 3, 2, 4, 8],
    [1, 5, 8, 6, 4, 2, 7, 9, 3],
    [2, 3, 4, 7, 9, 8, 5, 1, 6],
    [7, 6, 1, 8, 3, 5, 9, 2, 4],
    [8, 2, 3, 4, 7, 9, 1, 6, 5],
    [5, 4, 9, 1, 2, 6, 8, 3, 7],
    [6, 9, 7, 3, 5, 1, 4, 8, 2],
    [3, 1, 5, 2, 8, 4, 6, 7, 9],
    [4, 8, 2, 9, 6, 7, 3, 5, 1],
  ];

  @override
  void initState() {
    super.initState();
    initializeBoard();
    _stopwatch = Stopwatch()..start();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();
    super.dispose();
  }

  void initializeBoard() {
    sudokuBoard = [
      [9, 0, 6, 0, 1, 3, 0, 0, 8],
      [0, 5, 8, 0, 0, 0, 0, 9, 0],
      [0, 3, 0, 0, 0, 0, 0, 1, 0],
      [0, 6, 0, 8, 0, 0, 9, 2, 0],
      [0, 0, 3, 4, 0, 9, 1, 0, 0],
      [0, 4, 9, 0, 0, 6, 0, 3, 0],
      [0, 9, 0, 0, 0, 0, 0, 8, 0],
      [0, 1, 0, 0, 0, 0, 6, 7, 0],
      [4, 0, 0, 9, 6, 0, 3, 0, 1],
    ];
    isOriginal = List<List<bool>>.generate(
      9,
      (row) => List<bool>.generate(9, (col) => sudokuBoard[row][col] != 0),
    );
  }

  void selectCell(int row, int col) {
    setState(() {
      selectedRow = row;
      selectedCol = col;
    });
  }

  void inputNumber(int number) {
    if (selectedRow != -1 &&
        selectedCol != -1 &&
        !isOriginal[selectedRow][selectedCol]) {
      setState(() {
        sudokuBoard[selectedRow][selectedCol] = number;
      });
    }
  }

  void resetBoard() {
    setState(() {
      initializeBoard();
      selectedRow = -1;
      selectedCol = -1;
      _stopwatch.reset();
      _stopwatch.start();
    });
  }

  void clearInput() {
    if (selectedRow != -1 &&
        selectedCol != -1 &&
        !isOriginal[selectedRow][selectedCol]) {
      setState(() {
        sudokuBoard[selectedRow][selectedCol] = 0;
      });
    }
  }

  bool isBoardSolved() {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (sudokuBoard[i][j] == 0) {
          return false;
        }
      }
    }
    return true;
  }

  bool isValidBoard(List<List<int>> board) {
    // Add your logic to check if the board is valid (no duplicate numbers in rows, columns, and boxes)
    return true; // Placeholder return value
  }

  void checkBoard() {
    bool solved = true;
    List<List<bool>> incorrectCells =
        List.generate(9, (_) => List.filled(9, false));

    // Check if all cells are filled and numbers are valid
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (sudokuBoard[i][j] != solutionBoard[i][j]) {
          solved = false;
          incorrectCells[i][j] = true;
        }
      }
    }

    if (!isBoardSolved()) {
      // Puzzle not completely solved
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Incomplete Puzzle"),
            content: Text("Please complete the Sudoku puzzle."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else if (solved) {
      // Correct solution
      _stopwatch.stop();
      String timeTaken =
          '${_stopwatch.elapsed.inMinutes}:${(_stopwatch.elapsed.inSeconds.remainder(60)).toString().padLeft(2, '0')}';

      int stars = 5;
      if (_stopwatch.elapsed.inMinutes < 5) {
        stars = 5;
      } else if (_stopwatch.elapsed.inMinutes < 8) {
        stars = 4;
      } else if (_stopwatch.elapsed.inMinutes < 15) {
        stars = 3;
      } else if (_stopwatch.elapsed.inMinutes < 20) {
        stars = 2;
      } else {
        stars = 1;
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Congratulations!"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("You solved the Sudoku puzzle in $timeTaken."),
                Row(
                  children: List.generate(stars, (index) {
                    return Icon(Icons.star, color: Colors.yellow);
                  }),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SudokuGameLevelH3()),
                  );
                },
                child: Text('Next Level'),
              )
            ],
          );
        },
      );
    } else {
      // Incorrect solution
      setState(() {
        for (int i = 0; i < 9; i++) {
          for (int j = 0; j < 9; j++) {
            if (incorrectCells[i][j]) {
              // Mark incorrect cells with a different color
              if (sudokuBoard[i][j] != 0) {
                // Only change color if the cell is not empty
                sudokuBoard[i][j] = -1; // Use -1 to indicate incorrect
              }
            }
          }
        }
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Wrong Solution"),
            content: Text(
                "The Sudoku puzzle solution is incorrect. Please recheck!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  bool _compareBoards(List<List<int>> board1, List<List<int>> board2) {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (board1[i][j] != board2[i][j]) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final duration = _stopwatch.elapsed;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: Text('Sudoku Hard Level 2'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Text(
              '$minutes:$seconds',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            final int key = event.logicalKey.keyId;
            if (key >= LogicalKeyboardKey.digit1.keyId &&
                key <= LogicalKeyboardKey.digit9.keyId) {
              // Number keys (1-9) pressed
              inputNumber(key - LogicalKeyboardKey.digit1.keyId + 1);
            }
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display the Sudoku board
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 9,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                  ),
                  itemCount: 81,
                  itemBuilder: (context, index) {
                    int row = index ~/ 9;
                    int col = index % 9;

                    // Determine if it's in an alternate 3x3 grid
                    bool isInAlternateGrid = (row ~/ 3 + col ~/ 3) % 2 == 0;

                    return GestureDetector(
                      onTap: () {
                        selectCell(row, col);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedRow == row && selectedCol == col
                              ? Colors.yellow
                              : isInAlternateGrid
                                  ? Colors.lightBlue[
                                      100] // Light blue for alternate grid
                                  : sudokuBoard[row][col] ==
                                          -1 // Change color for incorrect cells
                                      ? Colors.white
                                      : Colors.white,
                          border: Border.all(
                              color: Colors.black, width: 1.0), // Black border
                        ),
                        child: Center(
                          child: Text(
                            sudokuBoard[row][col] == 0
                                ? ''
                                : sudokuBoard[row][col] ==
                                        -1 // Use 'X' for incorrect cells
                                    ? 'X'
                                    : sudokuBoard[row][col].toString(),
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: isOriginal[row][col]
                                  ? Colors.black // Pre-filled cells black
                                  : sudokuBoard[row][col] ==
                                          -1 // User-input cells red if incorrect
                                      ? Colors.red
                                      : Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Number buttons
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Wrap(
                  spacing: 10.0,
                  children: List.generate(9, (index) {
                    return GestureDetector(
                      onTap: () {
                        inputNumber(index + 1);
                      },
                      child: Container(
                        width: 30.0,
                        height: 30.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // Reset, Check, and Clear buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: resetBoard,
                    child: Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: checkBoard,
                    child: Text('Check'),
                  ),
                  ElevatedButton(
                    onPressed: clearInput,
                    child: Text('Clear'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SudokuGameLevelH2(),
  ));
}
