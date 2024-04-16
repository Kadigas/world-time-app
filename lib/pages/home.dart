import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;
    print(data);

    String bgImage = data['isDayTime'] ? 'day.jpg' : 'night.jpg';
    Color bgColor = data['isDayTime'] ? Colors.blue.shade700 : Colors.indigo.shade900;
    Color btnColor = data['isDayTime'] ? Colors.blue : Colors.indigo.shade900;
    Color boxColor = data['isDayTime'] ? Colors.white10 : Colors.black26;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'location': result['location'],
                          'flag': result['flag'],
                          'time': result['time'],
                          'isDayTime': result['isDayTime'],
                        };
                      });
                      print(result);
                      },
                    icon: const Icon(
                      Icons.location_on_sharp,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Edit Location',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(btnColor),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: boxColor, // Background color
                    borderRadius: BorderRadius.circular(24.0), // Border radius
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            data['location'],
                            style: const TextStyle(
                              fontSize: 28.0,
                              letterSpacing: 2.0,
                              color: Colors.white
                            ),
                          )
                        ],
                      ),
                      Text(
                        data['time'],
                        style: const TextStyle(
                          fontSize: 66.0,
                          letterSpacing: 2.0,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
