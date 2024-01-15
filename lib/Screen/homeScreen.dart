import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_yuk/Screen/TransactionScreen.dart';
import 'package:service_yuk/Screen/profileScreen.dart';
import 'package:service_yuk/models/service_category.dart';
import 'package:service_yuk/Menu/navigationbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ServiceCategory> serviceCategory = [];
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    getServiceCategory();
  }

  void getServiceCategory() {
    serviceCategory = ServiceCategory.getServiceCategory(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _bodyContent(),
      bottomNavigationBar: NavigationMenu(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _bodyContent() {
    List<Widget> widgetOptions = <Widget>[
      _serviceCategory(),
      TransactionScreen(),
      ProfileScreen(),
    ];

    return Center(
      child: widgetOptions.elementAt(_selectedIndex),
    );
  }

  Column _serviceCategory() {
    final User? user = FirebaseAuth.instance.currentUser;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Service',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 120,
              child: ListView.separated(
                itemCount: serviceCategory.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20, right: 20),
                itemBuilder: (context, index) {
                  final category = serviceCategory[index];
                  return InkWell(
                    onTap: user != null ? category.onTap : null,
                    child: Opacity(
                      opacity: user != null ? 1.0 : 0.5,
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: category.boxColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(0.8),
                                child: category.icon,
                              ),
                            ),
                            Text(
                              category.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  width: 25,
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        "TechCare",
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
    );
  }
}
