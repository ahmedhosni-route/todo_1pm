import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_1pm/core/models/task_model.dart';

class FirebaseFunctions {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference<TaskModel> mainFunction() {
    return firestore.collection("Tasks").withConverter(
      fromFirestore: (snapshot, options) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel task) async {
    var ref = mainFunction();
    var docRef = ref.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime time) {
    var ref = mainFunction();
    return ref
        .where("date",
            isEqualTo: DateUtils.dateOnly(time).millisecondsSinceEpoch)
        .snapshots();
  }

  static void deleteTask(String id) async {
    var ref = mainFunction();
    await ref.doc(id).delete();
  }

  static void setDone(TaskModel task) async {
    var ref = mainFunction();
    task.isDone = !task.isDone;
    await ref.doc(task.id).update(task.toJson());
  }

  static createAccount(String email, String password)async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      print("=============");
      print(e);
      print("=============");
    } catch (e) {
      print("=============");
      print(e);
      print("=============");

    }
  }

  static loginAccount(String email, String password)async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
