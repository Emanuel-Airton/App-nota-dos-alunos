class AuthModel {
  late String _email;
  late String _password;

  AuthModel(this._email, this._password);
  get email => _email;

  set email(value) => _email = value;

  get senha => _password;

  set senha(value) => _password = value;
}
