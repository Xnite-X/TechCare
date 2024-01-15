import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? uid;
  List<Map<String, dynamic>> transactionData = [];

  @override
  void initState() {
    super.initState();
    _getUserUid();
  }

  Future<void> _getUserUid() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        uid = user.uid;
      });
      // Now you can call your fetchData function here with the retrieved uid
      fetchData(uid);
    } else {
      // Handle the case when the user is not authenticated
    }
  }

  Future<void> fetchData(String? uid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    if (uid != null) {
      // Reference to the user document using the provided uid
      CollectionReference userCollection = firestore.collection('users');
      DocumentReference userDocRef = userCollection.doc(uid);

      // Reference to the 'order_information' subcollection
      CollectionReference orderInfoCollection =
          userDocRef.collection('order_information');

      QuerySnapshot querySnapshot = await orderInfoCollection.get();

      if (querySnapshot.docs.isNotEmpty) {
        // Loop through the documents in the 'order_information' subcollection
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;
          transactionData.add(data);
        }
        setState(() {});
      } else {
        print('No documents found for this user.');
      }
    } else {
      print('UID is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: transactionData.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100], // Set your desired background color
                  border: Border.all(
                    color: Colors.grey, // Set your desired border color
                    width: 1.0, // Set the width of the border
                  ),
                  borderRadius: BorderRadius.circular(
                      4.0), // Set the border radius if you need rounded corners
                ),
                margin: EdgeInsets.all(
                    4.0), // Optional: to add space around each ListTile
                child: ListTile(
                  title: Text('Order ${index + 1}'),
                  subtitle:
                      Text('Service: ${transactionData[index]['kerusakan']}'),
                  trailing: Text(
                    'Completed',
                    style: TextStyle(
                      color: Colors
                          .green, // Set your desired text color for 'Completed'
                      fontWeight: FontWeight
                          .bold, // Optional: if you want the 'Completed' to be bold
                    ),
                  ),
                ),
              );
            }));
  }
}
