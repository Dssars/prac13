import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_service.dart';
import 'package:flutter_application_1/auth/auth_service.dart';
import 'package:flutter_application_1/components/order_item.dart';
import 'package:flutter_application_1/models/order.dart';
import 'package:flutter_application_1/models/profile_model.dart';
import 'package:flutter_application_1/pages/change_profile.dart';

Profile profile = Profile(
  url:'../profile_image.jpg',
  name:'',
);
List<Order> orders = [];

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key,});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
 
}

class _ProfilePageState extends State<ProfilePage> {

  late Future<List<Order>> _orders;

  @override
  void initState() {
    super.initState();
    _orders = ApiService().getOrders();
  }

  final authService = AuthService();

  void logout() async {
    await authService.signOut();
  }

  void _changeProfile(Profile profile2) {
    setState(() {
      profile = profile2;
    });
  }

  @override
  Widget build(BuildContext context) {

    final currentEmail = authService.getCurrentUserEmail();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('ПРОФИЛЬ', style: TextStyle(fontSize: 24, color: Colors.white),),), backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout))
        ],
      ),
      backgroundColor:  const Color.fromARGB(255, 139, 147, 255),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(color: const Color.fromARGB(255,255, 113, 205), borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.white, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8), // Image border
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(130), // Image radius
                          child: Image.asset(profile.url, fit: BoxFit.cover),
                        ),
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Text(currentEmail.toString(), style: const TextStyle(fontSize: 32, color: Colors.white),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        height: 70,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            side: BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          backgroundColor: const Color.fromARGB(255, 139, 147, 255),),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChangeProfile(
                              profile: profile,
                              onChange: _changeProfile,
                              ),
                            ),
                          ),
                          child: const Center(child: Text('Редактировать профиль', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white,),),),),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder<List<Order>>( 
                future: _orders, 
                builder: (context, snapshot) { 
                  if (snapshot.connectionState == ConnectionState.waiting) { 
                    return const Center(child: CircularProgressIndicator()); 
                  } else if (snapshot.hasError) { 
                    return Center(child: Text('Error: ${snapshot.error}')); 
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) { 
                    return const Center(child: Text('No orders found')); 
                  }
        
                  orders = snapshot.data!;
                  return Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                    shrinkWrap: true, // Позволяет ListView занимать только необходимое пространство
                    physics: const NeverScrollableScrollPhysics(), // Отключаем прокрутку в ListView
                    itemCount: orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      final order = orders[index];
                      return OrderItem(order: order);
                    },
                  ),
                ); 
                },       
              ),
        
            ],
          ),
          
        ),
        ),
      ),

    );
  }
}