import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPressed = false;

  connectToVPN() async {
    try {
      var response = await http.post(
        Uri.parse('http://115.113.39.74:65528/api/user/wireguardapi'),
        // Add any necessary headers or parameters here
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Connected to VPN successfully"), duration: Duration(seconds: 3),));
        // Successful connection, handle the response accordingly
        print('Connected to VPN successfully');
      } else {
        // Handle error response
        print('Failed to connect to VPN. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that may occur
      print('Error: $e');
    }
  }

  disconnectFromVPN() async {
    try {
      var response = await http.post(
        Uri.parse('http://115.113.39.74:65528/api/user/wireguardapi'),
        // Add any necessary headers or parameters here
      );

      if (response.statusCode == 200) {
        // Successful disconnection, handle the response accordingly
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("DisConnected to VPN successfully")));
        print('Disconnected from VPN successfully');
      } else {
        // Handle error response
        print('Failed to disconnect from VPN. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that may occur
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cyberpeace VPN"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
          ),

          GestureDetector(
            onTap: () {
              setState(() {
                isPressed = !isPressed;
              });
              if (isPressed == true){
                connectToVPN();
              }
              else if (isPressed == false) {
                disconnectFromVPN();
              }
            },
            child: Material(
              color: Colors.transparent,
              child: Ink(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isPressed ? Colors.blue : Colors.grey,
                ),
                child: Center(
                  child: Container(
                    width: 150.0,
                    height: 150.0,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isPressed ? Icons.rocket_outlined : Icons.rocket,
                          color: Colors.white,
                          size: 60.0,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          isPressed ? "On" : "Off",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
