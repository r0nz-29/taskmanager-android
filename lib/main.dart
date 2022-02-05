import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          child: Row(
            children: [
              Container(
                child: Expanded(
                  child: CircleAvatar(
                    radius: 15.0,
                    backgroundColor: Colors.blue[50],
                    child: Image.asset('images/image (2).png'),
                  ),
                ),
              ),
              SizedBox(
                width: 260,
              ),
              Container(
                width: 0.0,
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.indigo[50],
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.notifications,
                      color: Colors.blue[900],
                      size: 25.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 90,
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                    size: 25.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                25,
                10,
                0,
                0,
              ),
              child: Text(
                'Hello !',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow[600],
                  fontSize: 35.0,
                  fontFamily: 'PublicSans',
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
              child: Row(
                children: [
                  Text(
                    'Select & Start ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'PublicSans',
                      fontSize: 30.0,
                    ),
                  ),
                  Text(
                    'Searching ',
                    style: TextStyle(
                      color: Colors.yellow[600],
                      fontWeight: FontWeight.w900,
                      fontFamily: 'PublicSans',
                      fontSize: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    child: MyStatefulWidget(),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      child: TextField(
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.blueAccent,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          hintText: "Search supplier",
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 32.0),
                              borderRadius: BorderRadius.circular(25.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 32.0),
                              borderRadius: BorderRadius.circular(8.0)),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.location_on,
                    color: Colors.yellow[600],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              width: 600,
              height: 40,
              child: Card(
                color: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(85, 0, 10, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          color: Colors.blue[800],
                          width: 100,
                          height: 40,
                          child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                Icons.home,
                                color: Colors.yellow[600],
                              ),
                              label: Text(
                                'HOME',
                                style: TextStyle(color: Colors.yellow[600]),
                              ))),
                      SizedBox(
                        width: 30.0,
                      ),
                      Expanded(
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.navigation),
                        ),
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.location_city),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'Select';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 33,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 5,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Select', 'Supplier', 'Company', 'Medicine & product']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
