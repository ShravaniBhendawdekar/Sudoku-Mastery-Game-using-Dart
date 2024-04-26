import 'package:flutter/material.dart';
import 'levels_page_easy.dart';
import 'levels_page_medium.dart';
import 'levels_page_hard.dart';

class DiffPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Difficulty Level'),
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
                      MaterialPageRoute(builder: (context) => LevelsPage1()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 20.0), // Increase font size
                    elevation: 10.0, // Increase drop shadow
                  ),
                  child: Text('Easy'),
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
                      MaterialPageRoute(builder: (context) => LevelsPage2()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 20.0), // Increase font size
                    elevation: 10.0, // Increase drop shadow
                  ),
                  child: Text('Medium'),
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
                      MaterialPageRoute(builder: (context) => LevelsPage3()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 20.0), // Increase font size
                    elevation: 10.0, // Increase drop shadow
                  ),
                  child: Text('Hard'),
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
    home: DiffPage(),
  ));
}
