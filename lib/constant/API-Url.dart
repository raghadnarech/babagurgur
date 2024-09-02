const baseURL = "https://1-tech-masters.com/babakrkr/public/api";

class AppApi {
  static String LOGIN = '/login';

  static String Allclass = '/get-all-classes';
  static String Allroom = '/get-all-rooms';
  static String AllStudent = '/get-all-student';
  static String AllTeacher = '/get-all-teacher';
  static String AllHW = '/get-all-homework';
  static String AllNews = '/get-all-news';

  static String CreateStudent = '/create-student';
  static String CreateTeacher = '/create-teacher';
  static String CreateClass = '/create-classes';
  static String CreateRoom = '/create-room';

  static String SelectClassroomStudent = '/user-room';
  static String MyProfileStudent = '/get-my-profile';
  static String UpdateProfileAdmin = '/update-admin-data';
  static String UpdateProfileforall = '/update-my-data';
  static String CreateNumbers = '/create-numbers';
  static String UpdateNumbers = '/update-numbers';
  static String ShowNumbers = '/show-numbers';

  static String ProfileAdmin = '/show-admin-profile';

  static String ChangePassword = '/change-password';

  static String JoinStudentToGroup(int userid) =>
      '/join-StudentTo-Group/$userid';
  static String SendMessageToRoom(int roomid) => '/send-MessageTo-Room/$roomid';
  static String CreateHomeWork(int roomid) => '/create-HomeWork/$roomid';
  static String CreateExamSchedule(int roomid) =>
      '/create-Exam-Schedule/$roomid';
  static String UpdateExamSchedule(int roomid) =>
      '/update-Exam-Schedule/$roomid';
  static String CreateWeeklySchedule(int roomid) =>
      '/create-Week-Schedule/$roomid';
  static String UpdateWeeklySchedule(int roomid) =>
      '/update-Week-Schedule/$roomid';
  static String AllNewsRoom(int roomid) => '/news-Index/$roomid';
  static String AllHWRoom(int roomid) => '/hm-Index/$roomid';
  static String StudentFromRoom(int roomid) => '/student-from-room/$roomid';

  static String DeleteUser(int userid) => '/delete-user/$userid';
  static String UpdateClass(int classid) => '/update-class/$classid';
  static String DeleteClass(int classid) => '/delete-class/$classid';
  static String UpdateRoom(int roomid) => '/update-room/$roomid';
  static String DeleteRoom(int roomid) => '/delete-room/$roomid';
  static String ScheduleExam(int roomid) => '/get-exam/$roomid';
  static String ScheduleWeek(int roomid) => '/get-week/$roomid';
  static String SelectMyRoom(int roomid) => '/my-room/$roomid';

  static String ProfileUserFromAdmin(int id) => '/show-user-profile/$id';
  static String UpdateUserData(int id) => '/update-user-data/$id';

  static String UpdateUserRoom(int userid) => '/update-user-room/$userid';

  static String IMAGEURL =
      'https://1-tech-masters.com/babakrkr/public/storage/';
}
