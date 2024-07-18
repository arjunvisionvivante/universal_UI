class User {
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? dob;
  Address? address;
  String? phoneNumber;
String? countrycode;
  User({
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.dob,
    this.address,
    this.phoneNumber,
    this.countrycode,
  });

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'dob': dob,
      'address': address?.toJson(),
      'phone_number': int.parse(phoneNumber.toString()),
      'country_code':countrycode.toString(),
      'direct':true
    };
  }
}

class Address {
  String? street;
  String? city;
  String? state;
  String? zipCode;

  Address({
    this.street,
    this.city,
    this.state,
    this.zipCode,
  });

  // Convert Address object to JSON
  String toJson() {
    return street.toString() +
        city.toString() +
        state.toString() +
        zipCode.toString();
  }
}
