import 'package:flutter/material.dart';
import 'package:to_do_app/model/job.dart';
import 'package:to_do_app/model/table_enum.dart';
import 'package:to_do_app/service/utility.dart';
import 'package:to_do_app/view_model/job_detail_model.dart';

class JobDetailView extends AlertDialog with Utility {
  JobDetailView({Key? key, required this.job}) : super(key: key);
  Job job;
  TextEditingController _captionController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _captionController.text = job.caption ?? '';
    _contentController.text = job.content ?? '';
    return AlertDialog(
      title: TextField(
        decoration: const InputDecoration(
            border: OutlineInputBorder(), labelText: 'Başlık'),
        controller: _captionController,
        minLines: 1,
        maxLines: 2,
      ),
      content: TextField(
        decoration: const InputDecoration(
            border: OutlineInputBorder(), labelText: 'Açıklama'),
        controller: _contentController,
        minLines: 2,
        maxLines: 8,
      ),
      actions: [
        deleteTextButton(context),
        TextButton(
          onPressed: () async {
            job.caption = _captionController.text;
            job.content = _contentController.text;
            job.creationDate = DateTime.now().millisecondsSinceEpoch.toString();

            int result = await JobDetailsModel.updateJob(job);
            Navigator.pop(context);
            updateInfo(context, result > 0 ? 'Başarılı' : ' Hata oluştu');
          },
          child: const Text('Güncelle'),
        ),
        cancelTextButton(context),
      ],
    );
  }

  TextButton cancelTextButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('İptal'));
  }

  TextButton deleteTextButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          JobDetailsModel.delete(job.id, TableEnum.job.name);
          Navigator.pop(context);
          updateInfo(context, 'silindi');
        },
        child: const Text('Sil'));
  }

  Future<dynamic> updateInfo(BuildContext context, String explanation) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Tamam'))
            ],
            title: Text('Bilgi'),
            content: Text(explanation),
          );
        });
  }
}
