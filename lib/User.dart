
import 'package:flutter/material.dart';

class User {
  String username;
  String password;
  List<Day> days;

  User (String username, String password, List<Day> days) {
    this.username = username;
    this.password = password;
    this.days = days;
  }

}

class Day {
  String dayName;
  String workoutName;
  List<Exercise> exercises;

  Day (String dayName, List<Exercise> exercises) {
    this.dayName = dayName;
    this.exercises = exercises;
    workoutName = "Enter Workout Name";
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

  Exercise (String name, int reps, int sets, int weight) {
    this.name = name;
    this.reps = reps;
    this.sets = sets;
    this.weight = weight;
  }
}

