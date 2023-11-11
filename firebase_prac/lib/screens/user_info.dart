class UserInfo {
  String _name="", _age="", _email="", _number="", _gender="", _dob="";

  String get name => _name;

  get dob => _dob;

  set dob(value) {
    _dob = value;
  }

  set name(String value) {
    _name = value;
  }

  get age => _age;

  get gender => _gender;

  set gender(value) {
    _gender = value;
  }

  get number => _number;

  set number(value) {
    _number = value;
  }

  get email => _email;

  set email(value) {
    _email = value;
  }

  set age(value) {
    _age = value;
  }

}