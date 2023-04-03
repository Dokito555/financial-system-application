import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable{
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  String? profilePicture = 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profilePicture
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return UserModel(
      id: snapshot['id'] as String, 
      name: snapshot['name'] as String, 
      email: snapshot['email'] as String, 
      phoneNumber: snapshot['phoneNumber'] as String,
      profilePicture: snapshot['profilePicture'] as String? ?? ''
    );
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    email,
    phoneNumber,
    profilePicture
  ];
}