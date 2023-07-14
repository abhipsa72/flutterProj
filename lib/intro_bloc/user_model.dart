import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String email;
  final String name;
  final String uid;
  final String contact_number;

  UserModel(
      {required this.email,
        required this.name,
         required this.contact_number,
        required this.uid,
        });

  Map<String, dynamic> toJson() => {
    "email": email,
    "uid": uid,
    "name": name,
"contact_number": contact_number
  };

  // static UserModel? fromSnap (DocumentSnapshot snap) {
  //   var snapshot = snap.data() as Map<String, dynamic>;
  //   return UserModel(
  //
  //     uid: snapshot['uid'],
  //     name: snapshot['name'],
  //
  //     email: snapshot['email'],
  //   );
  // }
}