//Profile class model to handle user accounts
class Profile {
  String _fname = "",
      _lname = "",
      _email = "",
      _password = "",
      _phoneNumber = "",
      _sid = "";

  Profile(this._fname, this._lname, this._email, this._sid, this._phoneNumber,
      this._password);

  getFirstName() {
    return _fname;
  }

  getLastName() {
    return _lname;
  }

  getEmail() {
    return _email;
  }

  getSid() {
    return _sid;
  }

  getPhoneNumber() {
    return _phoneNumber;
  }

  getPassword() {
    return _password;
  }

  setFirstName(String fname) {
    _fname = fname;
  }

  setLastName(String lname) {
    _lname = lname;
  }

  setEmail(String email) {
    _email = email;
  }

  setSid(String sid) {
    _sid = sid;
  }

  setPhoneNumber(String phone) {
    _phoneNumber = phone;
  }

  setPassword(String password) {
    _password = password;
  }
}
