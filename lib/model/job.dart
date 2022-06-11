class Job {
  int? id;
  String? caption;
  String? content;
  String? creationDate;
  int? jobState = 0;

  Job({this.caption, this.content, this.creationDate, this.jobState});
  Job.withId({this.id, this.caption, this.content, this.creationDate, this.jobState});

  Job.fromObject(dynamic job) {
    this.id = job['id'] as int;
    this.caption = job['caption'] as String;
    this.content = job['content'] as String;
    this.creationDate = job['creationDate'].toString();
    this.jobState = job['jobState'] ?? 0;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'caption': this.caption,
      'content': this.content,
      'creationDate': this.creationDate,
      'jobState': this.jobState ?? 0,
    };
    return map;
  }
}
