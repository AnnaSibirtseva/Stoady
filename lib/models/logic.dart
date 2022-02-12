import 'package:stoady/models/subject.dart';
import 'package:stoady/models/topic.dart';
import 'package:stoady/models/user.dart';

import 'group.dart';

class Logic {
  static int currentIndex = 0;
  static User currentUser = User(0, "Kermit", "kermit_the_frog@mail.ru", "12345", 0);
  static Topic currentTopic = Topic(
      0,
      "Matrices",
      "In mathematics, a matrix (plural matrices) is a rectangular array or table of numbers, symbols, or expressions, arranged in rows and columns, which is used to represent a mathematical object or a property of such an object." +
          "\n\nContains the following topics:\n  - Basics \n  - Basic Operations \n  - Main Operations \n  - Types \n",
      0,
      0);
  static Group currentGroup = Group("HSE-SE", "https://sun9-11.userapi.com/impg/zyBbgn06vjopku_XSx6UXt_CZ48356RUScBTng/BhzAEXL_lKk.jpg?size=604x604&quality=96&sign=8763e441c85841148d4c7ce927321aa2&type=album");

  static List<Group> allGroups = [currentGroup, currentGroup, currentGroup, currentGroup, Group("MSU Economics and Finance", "https://s.zefirka.net/images/2017-05-17/slonyata-milye-malenkie-giganty/slonyata-milye-malenkie-giganty-9.jpg")];

  static void addIndex(bool add) {
    if(currentIndex < currentTopic.test.questions.length - 1 && add) {
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

  static String getTopicName(int id) {
    //TODO check for null
    allTopics.where((topic) => topic.getId() == id).toList();
    return allTopics.where((topic) => topic.getId() == id).toList()[0].getTitle();
  }
  static List<Topic> allTopics = [
    Topic(
        0,
        "Matrices",
        "In mathematics, a matrix (plural matrices) is a rectangular array or table of numbers, symbols, or expressions, arranged in rows and columns, which is used to represent a mathematical object or a property of such an object." +
            "\n\nContains the following topics:\n  - Basics \n  - Basic Operations \n  - Main Operations \n  - Types \n",
        0,
        0),
    Topic(
        1,
        "Vectors",
        "Probability theory is the branch of mathematics concerned with probability.",
        0,
        1),
    Topic(
        2,
        "Complex numbers",
        "Discrete mathematics is the study of mathematical structures that are fundamentally discrete rather than continuous. ",
        0,
        1),
  ];
}
