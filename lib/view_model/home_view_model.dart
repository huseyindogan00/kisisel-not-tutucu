import 'package:flutter/material.dart';
import 'package:to_do_app/data/db_helper.dart';
import 'package:to_do_app/model/job.dart';

class HomeViewModel {
  static Future<List<Job>> getJobList() async {
    List<Job> jobList = await DbHelper().getJobList();
    return jobList;
  }

  static updateJobState(int id, int jobState) async {
    await DbHelper().updateJobState(id, jobState);
  }

  static getJob(int id) {}

  static Future<bool> routePage(BuildContext context, MaterialPageRoute pageRoute) async {
    bool result = await Navigator.push(context, pageRoute);
    return result;
  }
}
