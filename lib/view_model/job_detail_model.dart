import 'package:flutter/material.dart';
import 'package:to_do_app/data/db_helper.dart';
import 'package:to_do_app/model/job.dart';
import 'package:to_do_app/view/job_detail_view.dart';

class JobDetailsModel {
  static JobDetailView showAlertDialog(BuildContext context, Job job) {
    return JobDetailView(job: job);
  }

  static Future<int> updateJob(Job job) async {
    int result = await DbHelper().updateJob(job);
    return result;
  }

  static delete(int? id, String tableName) async {
    DbHelper().delete(id!, tableName);
  }
}
