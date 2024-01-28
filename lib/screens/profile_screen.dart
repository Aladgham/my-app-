import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = 'Anjad Khalaf';
    _phoneController.text = '+962779086452';
    _emailController.text = 'anjadKhalaf@gmail.com';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Stack(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromRGBO(9, 74, 128, 1),
                              width: 2),
                          borderRadius: BorderRadius.circular(50),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/anjad.png"),
                              fit: BoxFit.fill)),
                    ),
                    Positioned(
                      right: 1,
                      bottom: 0,
                      child: CircleAvatar(
                          backgroundColor: const Color.fromRGBO(9, 74, 128, 1),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ))),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text('Name', style: TextStyle(fontSize: 17)),
              ),
              TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50)))),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text('Phone Number', style: TextStyle(fontSize: 17)),
              ),
              TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50)))),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text('Email address', style: TextStyle(fontSize: 17)),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text("Change Password"),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Save"),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
