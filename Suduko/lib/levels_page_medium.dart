import 'package:flutter/material.dart';
import 'levelM1.dart';
import 'levelM2.dart';
import 'levelM3.dart';

class LevelsPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sudoku Levels'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                width: 200.0,
                height: 80.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SudokuGameLevelM1()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 20.0), // Increase font size
                    elevation: 10.0, // Increase drop shadow
                  ),
                  child: Text('Level 1'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                width: 200.0,
                height: 80.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SudokuGameLevelM2()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 20.0), // Increase font size
                    elevation: 10.0, // Increase drop shadow
                  ),
                  child: Text('Level 2'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                width: 200.0,
                height: 80.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SudokuGameLevelM3()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 20.0), // Increase font size
                    elevation: 10.0, // Increase drop shadow
                  ),
                  child: Text('Level 3'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LevelsPage2(),
  ));
}
