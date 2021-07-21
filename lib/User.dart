import 'dart:collection';

import 'package:flutter/material.dart';

class User {
  String username;
  String password;
  List<Day> days;

  User.noArg(this.username, this.password, this.days);

  User(String username, String password, List<Day> days) {
    this.username = username;
    this.password = password;
    this.days = days;
  }

  factory User.fromJson(dynamic json) {
    var dayObjsJson = json['days'] as List;
    List<Day> _days = dayObjsJson.map((dayJson) => Day.fromJson(dayJson)).toList();

    return User.noArg(
        json['username'] as String,
        json['password'] as String,
        _days);
  }
}

class Day {
  String dayName;
  String workoutName;

  List<Exercise> exercises;

  Day.noArg(this.dayName, this.workoutName, this.exercises);

  Day(String dayName, List<Exercise> exercises) {
    this.dayName = dayName;
    this.exercises = exercises;
    workoutName = "Enter Workout Name";
  }

  factory Day.fromJson(dynamic json) {
    var exerciseObjsJson = json['exercises'] as List;
    List<Exercise> _exercises= exerciseObjsJson.map((exerciseJson) => Exercise.fromJson(exerciseJson)).toList();

    return Day.noArg(
        json['dayName'] as String,
        json['workoutName'] as String,
        _exercises);
  }

  void setWorkoutName(String workoutName) {
    this.workoutName = workoutName;
  }
}

class Exercise {
  String name;
  int reps;
  int sets;
  int weight;

  Exercise.noArg({this.name, this.reps, this.sets, this.weight});

  Exercise(String name, int reps, int sets, int weight) {
    this.name = name;
    this.reps = reps;
    this.sets = sets;
    this.weight = weight;
  }

  factory Exercise.fromJson(dynamic json) {
    return Exercise(
        json['name'] as String,
        json['reps'] as int,
        json['sets'] as int,
        json['weight'] as int
        );
  }
}
