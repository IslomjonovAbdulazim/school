final myErrors = Errors.instance;

class Errors {
  Errors._();

  static Errors instance = Errors._();

  String nickRequired = "nick.is.required";
  String lsRequired = "learning.center.name.is.required";
  String nameRequired = "name.is.required";
  String passwordRequired = "password.is.required";
  String invalidNick = "invalid.nick";
  String weakPassword = "Weak password";
  String scienceRequired = "science.required";
  String usedNick = "used.nick";
  String selectDays = "select.days";
  String fillDes = "fill.des";
  String startTime = "start.time";
  String endTime = "end.time";
  String userNotFound = "user.not.found";
  String wrongPassword = "wrong.password";
}