import 'package:stoady/models/auth_info.dart';
import 'package:stoady/models/question.dart';
import 'package:stoady/models/random.dart';
import 'package:stoady/models/result.dart';
import 'package:stoady/models/subject.dart';
import 'package:stoady/models/team_members.dart';
import 'package:stoady/models/topic_info.dart';
import 'package:stoady/models/user.dart';
import 'package:stoady/models/user_group.dart';

import 'group.dart';

class Logic {
  static int currentIndex = 0;
  static User currentUser =
      User(1, "Kermit", "kermit_the_frog@mail.ru", "12345", 0);
  static AuthInfo userInfo = AuthInfo("", "");
  static AuthInfo registerInfo =
      AuthInfo.registerInfo("", "", "", Avatar.getRandomAvatar());

  static int currentGroupId = -1;
  static Group currentGroup = Group(" ", " ", []);

  static int currentSubjectId = -1;
  static Subject currentSubject = Subject(-1, " ", " ");

  static int currentTopicId = -1;
  static TopicInfo currentTopicInfo = TopicInfo.withQuestions(" ", " ", []);

  static List<Question> questions = [];

  static List<Result> statistics = [];

  static TeamMembers members = TeamMembers([]);


  static bool isAdmin() {
    List<UserGroup> list = (userGroups
        .where((group) => group.teamId == currentGroupId)).toList();
    if (list.isNotEmpty) {
      return list[0].isAdmin();
    }
    return false;
  }
  static List<UserGroup> userGroups = [];

  static void addIndex(bool add) {
    if (currentIndex < questions.length - 1 && add) {
      currentIndex++;
    } else if (currentIndex > 0 && !add) {
      currentIndex--;
    }
  }

  static List<Subject> allSubjects = [
    Subject(0, "Algebra",
        "Algebra is the study of mathematical symbols and the rules for manipulating these symbols"),
    Subject(1, "Probability Theory",
        "Probability theory is the branch of mathematics concerned with probability."),
    Subject(2, "Discrete Mathematics",
        "Discrete mathematics is the study of mathematical structures that are fundamentally discrete rather than continuous. "),
  ];
}
