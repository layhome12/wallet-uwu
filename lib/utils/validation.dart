String? uValidator(
    {required String? value,
    bool isRequire = false,
    bool isEmail = false,
    int minLenght = 0,
    String match = ''}) {
  //Required Field
  if (isRequire) {
    if (value == null || value.isEmpty) {
      return 'Field ini masih kosong';
    }
  }

  //Check Valid Email
  if (isEmail) {
    if (value == null || !value.contains("@") || !value.contains(".")) {
      return 'Email ini tidak valid';
    }
  }

  // Min Length
  if (minLenght != 0) {
    if (value!.length < minLenght) {
      return 'Panjang minimal $minLenght';
    }
  }

  //Matches Password
  if (match != '') {
    if (value != match) {
      return 'Password tidak sama';
    }
  }
  return null;
}
