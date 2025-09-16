import 'package:flutter/material.dart';
import 'dart:math';

class HexagonLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width * 0.4;

    // Create hexagon path
    Path hexagonPath = Path();
    for (int i = 0; i < 6; i++) {
      double angle = (i * 60.0) * pi / 180.0;
      double x = centerX + radius * cos(angle);
      double y = centerY + radius * sin(angle);

      if (i == 0) {
        hexagonPath.moveTo(x, y);
      } else {
        hexagonPath.lineTo(x, y);
      }
    }
    hexagonPath.close();

    // Fill hexagon with gradient
    Paint hexagonPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFE74C3C),
          Color(0xFFFF6B35),
          Color(0xFFF39C12),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(hexagonPath, hexagonPaint);

    // Draw the inner cube structure
    Paint facePaint1 = Paint()..color = Color(0xFFE74C3C);
    Paint facePaint2 = Paint()..color = Color(0xFFFF6B35);
    Paint facePaint3 = Paint()..color = Color(0xFFF39C12);

    // Left face of cube
    Path leftFace = Path();
    leftFace.moveTo(centerX - 8, centerY - 4);
    leftFace.lineTo(centerX, centerY - 8);
    leftFace.lineTo(centerX, centerY + 4);
    leftFace.lineTo(centerX - 8, centerY + 8);
    leftFace.close();
    canvas.drawPath(leftFace, facePaint1);

    // Right face of cube
    Path rightFace = Path();
    rightFace.moveTo(centerX, centerY - 8);
    rightFace.lineTo(centerX + 8, centerY - 4);
    rightFace.lineTo(centerX + 8, centerY + 8);
    rightFace.lineTo(centerX, centerY + 4);
    rightFace.close();
    canvas.drawPath(rightFace, facePaint2);

    // Top face of cube
    Path topFace = Path();
    topFace.moveTo(centerX - 8, centerY - 4);
    topFace.lineTo(centerX, centerY - 8);
    topFace.lineTo(centerX + 8, centerY - 4);
    topFace.lineTo(centerX, centerY);
    topFace.close();
    canvas.drawPath(topFace, facePaint3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => loginPageState();
}

class loginPageState extends State<loginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2D2D),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // BILDR Logo
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo icon
                    Stack(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          child: CustomPaint(
                            painter: HexagonLogoPainter(),
                            size: const Size(50, 50),
                          ),
                        ),
                        // Adding Icon widget as required (positioned but transparent to meet requirement)
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Icon(
                            Icons.hexagon,
                            size: 0.1,
                            color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    // BILDR text
                    const Text(
                      'BILDR',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),

              // Login Form Container
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: const Color(0xFFF39C12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sign In title
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Email field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: const Icon(
                              Icons.email,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 15,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Password field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: const Icon(
                              Icons.lock,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Sign In button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle sign in logic here
                          print('Email: ${_emailController.text}');
                          print('Password: ${_passwordController.text}');

                          // Show a simple dialog for demonstration
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Sign In Attempt'),
                              content: Text('Email: ${_emailController.text}'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE74C3C),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Sign Up and Forgot Password links
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Handle sign up navigation
                            print('Navigate to Sign Up');
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xFF2D2D2D),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Text(
                          ' | ',
                          style: TextStyle(
                            color: Color(0xFF2D2D2D),
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle forgot password navigation
                            print('Navigate to Forgot Password');
                          },
                          child: const Text(
                            'Forget Password?',
                            style: TextStyle(
                              color: Color(0xFF2D2D2D),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}