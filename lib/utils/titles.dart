import 'package:ds/utils/lan.dart';

import 'keys.dart';

final t = Titles.instance;

class LanModel {
  late String lan;
  late String currLan;
  late String code;

  LanModel({
    required this.lan,
    required this.code,
    required this.currLan,
  });
}

class Titles {
  Titles._();

  static Titles instance = Titles._();
  String settings = "settings";
  String avatar = "avatar";
  String joinedTime = "joined.time";
  String newSchoolPride = "new.school.pride";
  String editSchoolPride = 'edit.school.pride';
  String science = "science";
  String teacher = "teacher";
  String teachers = 'teachers';
  String ourPride = "our.pride";
  String director = "director";
  String school = "school";
  String statute = "statute";
  String sciences = "sciences";
  String login = "login";
  String news = "news";
  String english = "english";
  String uzbek = "uzbek";
  String russian = "russian";
  String uzbekKrill = "uzbek.krill";
  String token = "token";
  String tokens = "tokens";
  String next = "next";
  String logInAsTeacher = "login.as.teacher";
  String loginAsDirector = "login.as.director";
  String signUpAsTeacher = "sign.up.as.teacher";
  String signUpAsDirector = "sign.up.as.director";
  String signIn = "sign.in";
  String signUp = "sign.up";
  String system = "system";
  String profile = "profile";
  String schoolBio = "school.bio";
  String callSchedule = 'call.schedule';
  String receptionTime = "reception.time";
  String structure = "structure";
  String schoolPosts = "school.posts";
  String addScience = "add.science";
  String add = "add";
  String update = "update";
  String editScience = "edit.science";
  String addStatute = "add.statute";
  String addChapter = "add.chapter";
  String editChapter = "edit.chapter";
  String editStatute = "edit.statute";
  String statutes = "statutes";
  String statuteChapters = "statute.chapters";
  String makePost = "make.posts";
  String editPost = "edit.posts";
  String pickImage = "pick.image";
  String pickVideo = "pick.video";
  String images = "images";
  String socialMedia = "social.media";
  String location = "location";
  String tels = "phone.numbers";
  String statistics = "statistics";
  String bio = "bio";
  String addSchedule = "add.schedule";
  String editSchedule = "edit.schedule";
  String schedule = "schedule";
  String startTime = "start.time";
  String endTime = 'end.time';
  String addReceptionTime = "add.reception.time";
  String editReceptionTime = "edit.reception.time";
  String days = "days";
  String des = "des";
  String fullname = "Full name";
  String save = "save";
  String generateNewToken = "generate.new.token";
  String language = "language";
  String selectLan = "select.lan";
  String addClass = "add.class";
  String detailClass = "detail.class";
  String signOut = "sign.out";
  String article = "article";
  String myPosts = "my.posts";
  String articles = "articles";
  String myArticles = "my.articles";
  String writeNewArticle = "write.new.article";
  String editArticle = "edit.article";

  // #days
  String mon = "mon";
  String monday = "monday";
  String tue = "tue";
  String tuesday = "tuesday";
  String wed = "wed";
  String wednesday = "wednesday";
  String thu = "thu";
  String thursday = "thursday";
  String fri = "fri";
  String friday = "friday";
  String sat = "sat";
  String saturday = "saturday";
  String sun = "sun";
  String sunday = "sunday";
  String m = "m";
  String t = "t";
  List<String> shortDays = [];
  List<String> listOfDays = [];
  List<LanModel> lan1 = [];

  void init() {
    lan1 = [
      LanModel(
        lan: lan(uzbek, keys.uz),
        code: keys.uz,
        currLan: uzbek,
      ),
      LanModel(
        lan: lan(uzbekKrill, keys.krill),
        code: keys.krill,
        currLan: uzbekKrill,
      ),
      LanModel(
        lan: lan(english, keys.en),
        code: keys.en,
        currLan: english,
      ),
      LanModel(
        lan: lan(russian, keys.ru),
        code: keys.ru,
        currLan: russian,
      ),
    ];
    shortDays = [
      mon,
      tue,
      wed,
      thu,
      fri,
      sat,
      sun,
    ];
    listOfDays = [
      lan(monday),
      lan(tuesday),
      lan(wednesday),
      lan(thursday),
      lan(friday),
      lan(saturday),
      lan(sunday),
    ];
  }
}
