import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vitalminds/core/app/logger.dart';
import 'package:vitalminds/core/models/habits_model.dart';
import 'package:vitalminds/core/models/health_model.dart' as health;
import 'package:vitalminds/core/models/schedule_model.dart';
import 'package:vitalminds/core/models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  final log = getLogger('FirestoreService');
  Future<void> uploadProfilePic(String uid, File path) async {
    await _firebaseStorage
        .ref('/$uid/profilePic')
        .putFile(path)
        .whenComplete(() => log.i("Uploaded Successfully"));
  }

  checkPhone(String phno) async {
    var doc =
        await _usersCollectionReference.where("phone", isEqualTo: phno).get();

    return doc.size != 0;
  }

  Future getWorksheetData(String uid, DateTime date) async {
    try {
      var doc = await _usersCollectionReference
          .doc(uid)
          .collection("Worksheets")
          .doc("${DateFormat('dd-MM-yyyy').format(date)}")
          .collection("worksheets")
          .where("completed", isEqualTo: true)
          .get();
      if (doc.size.isFinite) {
        return doc;
      }
    } catch (e) {
      log.e(e.message);
    }
  }

  Future getAllWorksheetsData(String uid, DateTime date) async {
    try {
      var doc = await _usersCollectionReference
          .doc(uid)
          .collection("Worksheets")
          .doc("${DateFormat('dd-MM-yyyy').format(date)}")
          .collection("worksheets")
          .get();
      if (doc.size.isFinite) {
        return doc.docs;
      }
    } catch (e) {
      log.e(e.message);
    }
  }

  Future getName(String uid) async {
    String username;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      username = value.data()['name'];
    });
    log.i("name of the current user is : " + username);
    return username;
  }

  Future downloadURL(String uid, [int i]) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File('${appDocDir.path}/download-logo.png');

    try {
      if (i == 1) {
        String res;
        await _firebaseStorage
            .ref('/$uid/profilePic')
            .getDownloadURL()
            .then((value) => res = value);
        return res;
      }
      await _firebaseStorage
          .ref('/$uid/profilePic')
          .writeToFile(downloadToFile);
      return downloadToFile;
    } on FirebaseException catch (e) {
      log.e(e.message);
    }
  }

  Future<Map> getCBTData(String uid, DateTime selectedDate) async {
    log.i('getCBTData called');
    Map m = {};
    try {
      DocumentSnapshot doc = await _usersCollectionReference
          .doc(uid)
          .collection("CBT")
          .doc('${DateFormat('dd-MM-yyyy').format(selectedDate)}')
          .get();
      if (doc.exists) {
        m = doc.data();
        return m;
      }
    } catch (e) {
      log.e(e.message);
      return m;
    }
    return null;
  }

  Future<List<Map>> getWorkSheetData(String uid, DateTime date) async {
    log.i('getWorkSheetData called');
    List<Map> m = [];
    try {
      QuerySnapshot doc = await _usersCollectionReference
          .doc(uid)
          .collection("Worksheets")
          .doc("${DateFormat('dd-MM-yyyy').format(date)}")
          .collection("worksheets")
          .get();
      if (doc.size != 0) {
        for (int i = 0; i < doc.size; i++) {
          Map temp = {doc.docs[i].id: doc.docs[i].data()};
          m.add(temp);
          log.i(m.first.toString());
        }
        return m;
      }
    } catch (e) {
      log.e(e.toString());
      return m;
    }
    return null;
  }

  Future<void> updateCBT(String uid, String q1, String title, String vidoetitle,
      String question) async {
    log.i('updateCBT called');
    try {
      bool flag = false;
      DocumentSnapshot<Map<String, dynamic>> doc =
          await _usersCollectionReference
              .doc(uid)
              .collection("CBT")
              .doc('${DateFormat('dd-MM-yyyy').format(DateTime.now())}')
              .get();
      if (!doc.exists) {
        await _usersCollectionReference
            .doc(uid)
            .collection("CBT")
            .doc('${DateFormat('dd-MM-yyyy').format(DateTime.now())}')
            .set({
          title: [
            {
              vidoetitle: [q1],
              "questions": [question]
            }
          ]
        }, SetOptions(merge: true));
      } else {
        Map data = doc.data();
        if (data.containsKey(title)) {
          List videos = doc.data()[title];
          for (int i = 0; i < videos.length; i++) {
            if (videos[i].containsKey(vidoetitle)) {
              List temp = videos[i][vidoetitle];
              List q2 = videos[i]["questions"];
              temp.add(q1);
              q2.add(question);
              videos[i].update(vidoetitle, (value) => temp);
              videos[i].update("questions", (value) => q2);
              flag = true;
              break;
            }
          }
          if (!flag) {
            videos.add({
              vidoetitle: [q1],
              "questions": [question]
            });
          }
          data[title] = videos;
          await _usersCollectionReference
              .doc(uid)
              .collection("CBT")
              .doc('${DateFormat('dd-MM-yyyy').format(DateTime.now())}')
              .update(data);
        } else {
          await _usersCollectionReference
              .doc(uid)
              .collection("CBT")
              .doc('${DateFormat('dd-MM-yyyy').format(DateTime.now())}')
              .update({
            title: [
              {
                vidoetitle: [q1],
                "questions": [question]
              }
            ]
          });
        }
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  Future getUser(String uid) async {
    log.i('getUser called');
    try {
      DocumentSnapshot userData =
          await _usersCollectionReference.doc(uid).get();
      return UserModel.fromMap(userData.data());
    } on FirebaseException catch (e) {
      log.e(e.message);
      return e.message;
    }
  }

  Future getPhone(String uid) async {
    log.i('getUser called');
    try {
      DocumentSnapshot userData =
          await _usersCollectionReference.doc(uid).get();
      return userData.get("phone") ?? " ";
    } catch (e) {
      log.e(e.message);
    }
  }

  Future addPhoneNumber(String uid, String phno) async {
    log.i('addPhoneNumber called');
    try {
      await _usersCollectionReference.doc(uid).update({"phone": phno});
    } catch (e) {
      log.e(e.message);
      return e.message;
    }
  }

  void createUser(UserModel user, String uid) {
    log.i("Creating document if doc doesn't exist for user");
    try {
      _usersCollectionReference.doc(uid).get().then((snapShot) {
        if (snapShot == null || !snapShot.exists) {
          log.i("New User");
          log.i("New User Data:" + user.toMap().toString());
          _usersCollectionReference.doc(uid).set(user.toMap());
        }
      });
    } on FirebaseException catch (e) {
      log.e(e.message);
    }
  }

  Future<bool> isUserDataPresent(String uid) async {
    log.i('isDataPresent called');
    DocumentSnapshot snapShot = await _usersCollectionReference.doc(uid).get();
    if (snapShot == null || !snapShot.exists) {
      log.i('Data is not present in database');
      return false;
    }
    log.i('Data is present in database');
    return true;
  }

  Future<bool> isDataPresent(String uid, String date, String type) async {
    log.i('isDataPresent called');
    DocumentSnapshot snapShot = await _usersCollectionReference
        .doc(uid)
        .collection(type)
        .doc(date)
        .get();
    if (snapShot == null || !snapShot.exists) {
      log.i('$type data is not present in database');
      return false;
    }
    log.i('$type data is present in database');
    return true;
  }

  Future updateHealthData(
      String uid, String date, health.HealthModel healthModel) async {
    log.i(healthModel.toMap().toString());

    var doc = await _usersCollectionReference
        .doc(uid)
        .collection("health")
        .doc(date)
        .get();
    if (doc.exists) {
      await _usersCollectionReference
          .doc(uid)
          .collection("health")
          .doc(date)
          .update(healthModel.toMap());
    } else {
      await _usersCollectionReference
          .doc(uid)
          .collection("health")
          .doc(date)
          .set(healthModel.toMap());
    }
  }

  Future getHealthData(String uid, String date) async {
    DocumentSnapshot healthData = await _usersCollectionReference
        .doc(uid)
        .collection("health")
        .doc(date)
        .get();
    Map<String, dynamic> data = healthData.data() as Map<String, dynamic>;
    return health.HealthModel.fromMap(data);
  }

  Future updateScheduleData(
      String uid, String date, ScheduleModel scheduleModel, bool added) async {
    if (scheduleModel != null) {
      if (added) {
        scheduleModel.timestamp = Timestamp.now();
      }
      await _usersCollectionReference
          .doc(uid)
          .collection("schedule")
          .doc(date)
          .set(scheduleModel.toMap());
    }
  }

  Future getScheduleData(String uid, String date) async {
    DocumentSnapshot scheduleData = await _usersCollectionReference
        .doc(uid)
        .collection("schedule")
        .doc(date)
        .get();
    return ScheduleModel.fromMap(scheduleData.data());
  }

  Future getPreviousToDo(String uid, Timestamp t) async {
    log.i(t.toDate().toString());
    List<Todo> toDo = [];
    QuerySnapshot scheduleData = await _usersCollectionReference
        .doc(uid)
        .collection("schedule")
        .orderBy("timestamp", descending: false)
        .where("timestamp", isLessThanOrEqualTo: t)
        .get();
    if (scheduleData.docs.isNotEmpty) {
      int n = scheduleData.docs.length;
      ScheduleModel scheduleModel =
          ScheduleModel.fromMap(scheduleData.docs[n - 1].data() ?? {});
      scheduleModel.todo.forEach((element) {
        if (!element.status) toDo.add(element);
      });
    }

    return toDo;
  }

  Future updateHabits(String uid, HabitsModel habitsModel) async {
    //DocumentReference doc = await _usersCollectionReference.doc(uid).collection("habits").doc("habits");
    await _usersCollectionReference
        .doc(uid)
        .collection("habits")
        .doc("habits")
        .set(habitsModel.toMap());
  }

  Future getHabits(String uid, int day) async {
    log.i("getHabits called");
    List<Habit> habits = [];
    try {
      DocumentSnapshot habitsData = await _usersCollectionReference
          .doc(uid)
          .collection("habits")
          .doc("habits")
          .get();

      if (habitsData.exists) {
        HabitsModel habitsModel = HabitsModel.fromMap(habitsData.data());
        log.i(habitsModel.toString());
        habitsModel.habits.forEach((element) {
          if (element.status) {
            bool validDay;
            switch (day) {
              case 1:
                validDay = element.days[0];
                break;
              case 2:
                validDay = element.days[1];
                break;
              case 3:
                validDay = element.days[2];
                break;
              case 4:
                validDay = element.days[3];
                break;
              case 5:
                validDay = element.days[4];
                break;
              case 6:
                validDay = element.days[5];
                break;
              case 7:
                validDay = element.days[6];
                break;
              default:
                validDay = false;
            }
            if (validDay) {
              habits.add(Habit(title: element.title, status: false, days: [
                element.days[0],
                element.days[1],
                element.days[2],
                element.days[3],
                element.days[4],
                element.days[5],
                element.days[6],
              ]));
            }
          }
        });
      }
      return habits;
    } catch (e) {
      log.i("error:" + e.toString());
    }
  }

  Future getAllHabits(String uid) async {
    DocumentSnapshot habitsData = await _usersCollectionReference
        .doc(uid)
        .collection("habits")
        .doc("habits")
        .get();
    if (habitsData.exists) {
      return HabitsModel.fromMap(habitsData.data());
    } else {
      return HabitsModel(habits: []);
    }
  }

  Future updateABCDEModelData(
      DateTime date,
      String uid,
      String internal,
      String external,
      String assumptions,
      String factual,
      String behavioral,
      String emotional,
      String physiological,
      String disputation,
      String effect,
      bool completed) async {
    await _usersCollectionReference
        .doc(uid)
        .collection("Worksheets")
        .doc("${DateFormat('dd-MM-yyyy').format(date)}")
        .collection("worksheets")
        .doc('ABCDEModel')
        .set({
      "internal": internal,
      "external": external,
      "assumptions": assumptions,
      "factual": factual,
      "behavioral": behavioral,
      "emotional": emotional,
      "physiological": physiological,
      "disputation": disputation,
      "effect": effect,
      "completed": completed
    });
  }

  Future updateBasicModelData(
      DateTime date,
      String uid,
      String worksheetTitle,
      String worryingAbout,
      bool canItBeSolved,
      List whatCanYouDo,
      bool completed) async {
    await _usersCollectionReference
        .doc(uid)
        .collection("Worksheets")
        .doc("${DateFormat('dd-MM-yyyy').format(date)}")
        .collection("worksheets")
        .doc('$worksheetTitle')
        .set({
      "worryingAbout": worryingAbout,
      "canItBeSolved": canItBeSolved,
      "whatCanYouDo": whatCanYouDo,
      "completed": completed
    });
  }

  Future updateSocialActivationModelData(
      DateTime date,
      String uid,
      String peopleToCall,
      String activity,
      String schedule,
      String activityThought,
      String activityReality,
      bool completed) async {
    await _usersCollectionReference
        .doc(uid)
        .collection("Worksheets")
        .doc("${DateFormat('dd-MM-yyyy').format(date)}")
        .collection("worksheets")
        .doc('SocialActivation')
        .set({
      "peopleToCall": peopleToCall,
      "activity": activity,
      "schedule": schedule,
      "activityThought": activityThought,
      "activityReality": activityReality,
      "completed": completed
    });
  }

  Future updateBehavioralActivationModelData(
      String uid, int rank, bool completed, DateTime date) async {
    await _usersCollectionReference
        .doc(uid)
        .collection("Worksheets")
        .doc("${DateFormat('dd-MM-yyyy').format(date)}")
        .collection("worksheets")
        .doc('BehavioralActivation')
        .set({"rank": rank, "completed": completed});
  }
}
