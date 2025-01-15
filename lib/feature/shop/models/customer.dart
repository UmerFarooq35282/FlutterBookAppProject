class Customer{

  const Customer(
      {
        required this.customerID,
        required this.name,
        required this.email,
        required this.phone,
        required this.address,
        required this.imageURL,
        required this.role,
        required this.password,
        required this.gender
      }
    );

  final String customerID;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String imageURL;
  final String role;
  final String password;
  final String gender;

  factory Customer.fromMap(Map<String , dynamic> json){
    return Customer(
        customerID: json['customer'][0]['CustomerID'], 
        name: json['customer'][0]['Name'], 
        email: json['customer'][0]['Email'], 
        phone: json['customer'][0]['Phone'], 
        address: json['customer'][0]['Address'], 
        imageURL: json['customer'][0]['ImageURL'], 
        role: json['customer'][0]['Role'], 
        password: json['customer'][0]['password'], 
        gender: json['customer'][0]['Gender']
      );
  }
}