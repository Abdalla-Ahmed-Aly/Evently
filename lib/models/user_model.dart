class UserModel {
  String id;
  String name;
  String email;
  String password;
  List <String> eventFavoriteIds = [];

  UserModel(
      {required this.name,
      required this.email,
      required this.password,
      required this.id,required this.eventFavoriteIds});

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          email: json['email'],
          password: json['password'],
          eventFavoriteIds: (json['eventFavoriteIds']as List).cast<String>(),
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'eventFavoriteIds': eventFavoriteIds,
      };
}
