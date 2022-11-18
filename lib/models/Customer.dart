class Customer{
  String name;
  String email;
  String phone_number;
  String password;

  Customer(this.name, this.email, this.phone_number, this.password);

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone_number': phone_number,
    'password': password
  };

  factory Customer.fromJson(Map<String, dynamic> json){
    return Customer(
      json['name'].toString(),
      json['email'].toString(),
      json['phone_number'].toString(),
      json['password'].toString()
    );  
  }
}