import 'package:flutter/material.dart';
import 'package:to_do_app/data/db_helper.dart';
import 'package:to_do_app/model/job.dart';

class JobInsertModel {
  static Future<int> insertJob(Job job) async {
    int result = await DbHelper().addJob(job);
    return result;
  }

  static Future<bool> router(
      BuildContext context, MaterialPageRoute pageRoute) async {
    bool result = await Navigator.push(context, pageRoute);
    return result;
  }
}
