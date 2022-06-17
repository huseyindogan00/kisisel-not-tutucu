// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/model/job.dart';
import 'package:to_do_app/model/page_enum.dart';
import 'package:to_do_app/service/utility.dart';
import 'package:to_do_app/view_model/home_view_model.dart';
import 'package:to_do_app/view_model/job_detail_model.dart';

List<Job> jobList = [];

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with Utility {
  Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
  }

  void sessionControl() {}

  // TÜM LİSTENİN GETİRLMESİ
  void getList() async {
    await HomeViewModel.getJobList().then((data) {
      setState(() {
        jobList = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _floatinButtonAddJob(context),
        backgroundColor: Colors.grey.shade300,
        body: WillPopScope(
          onWillPop: () {
            return exitShowDialog(context).then(
              (value) {
                return Future.value(value);
              },
            );
          },
          child: CustomScrollView(
            slivers: [
              sliverAppBarView(),
              jobList.isNotEmpty ? sliverGridCountView() : infoTitle(),
            ],
          ),
        ));
  }

  // ***************** İŞLERİN TUTULDUĞU SLİVERGRİD WİDGETI ***************** //
  SliverGrid sliverGridCountView() {
    return SliverGrid.count(
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: buildJobList(),
      crossAxisCount: 2,
    );
  }

  // ***************** İŞ YOKSA ÇIKAN UYARI YAZISI ***************** //
  SliverList infoTitle() {
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        SizedBox(
          height: 200,
        ),
        Center(child: Text('Lütfen  +   butonu ile iş ekleyin...'))
      ]),
    );
  }

  // ***************** SLİVER APPBAR METHODU ***************** //
  SliverAppBar sliverAppBarView() {
    return SliverAppBar(
      centerTitle: true,
      pinned: true,
      automaticallyImplyLeading: false,
      expandedHeight: 160,
      bottom: PreferredSize(
          child: Text(
            'YAPILACAKLAR',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 3, color: Colors.white),
          ),
          preferredSize: Size.zero),
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset('assets/images/banner1.jpg', fit: BoxFit.cover),
      ),
    );
  }

  // ***************** UYGULAMADAN TAMAMEN ÇIKMAK İÇİN GÖSTERİLEN ALERTDIALOG ***************** //
  Future<dynamic> exitShowDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Uyarı'),
            content: Text('Çıkmak istediğinizden eminmisiniz?'),
            actions: [
              TextButton(
                  onPressed: () async {
                    bool result = await Navigator.of(context).maybePop();
                    if (result) {
                      Navigator.pushReplacementNamed(context, '/');
                    }
                  },
                  child: Text('Evet')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Hayır'))
            ],
          );
        });
  }

  // ***************** VERİTABANINDA EĞER EKLENMİŞ İŞ VAR İSE ONU GETİREN METHOD ***************** //
  List<Widget> buildJobList() {
    int indexFake = 0;
    return jobList.map((job) {
      indexFake++;
      return _cardWidget(indexFake, job);
    }).toList();
  }

  // ***************** VERİTABANINDAN GELEN İŞLERİ CARDLARA YAZAN METHOD ***************** //
  Widget _cardWidget(int indexFake, Job job) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onLongPress: () => jobDetailShow(context, job),
        onTap: () => setJobState(job.id!),
        child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: job.jobState! > 0 ? Colors.green.shade400 : Colors.amber.shade500,
              boxShadow: const <BoxShadow>[BoxShadow(blurRadius: 5)],
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    rowCaption(indexFake, job),
                    Divider(color: Colors.black),
                    rowContent(job),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Kayıt Tarihi : ${getDate(job.creationDate)}',
                        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.green.shade900, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  // ***************** BAŞLIK KISMININ DÜZENLENDİĞİ METHOD ***************** //
  Row rowCaption(int index, Job job) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          maxRadius: 15,
          child: Text(
            '$index',
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(width: 5),
        Flexible(
          child: Text(
            job.caption.toString(),
            style: TextStyle(fontSize: 16, color: Colors.deepOrangeAccent.shade700),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // ***************** AÇIKLAMA KISMININ DÜZENLENDİĞİ METHOD ***************** //
  Row rowContent(Job job) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            job.content.toString(),
            style: TextStyle(fontSize: 15, color: Colors.black),
            overflow: TextOverflow.ellipsis,
            maxLines: 6,
          ),
        ),
      ],
    );
  }

  // ***************** İŞLERE UZUN BASILINCA GÜNCELLEMEK VEYA SİLMEK İÇİN AÇILAN ALERTDIALOG ***************** //
  void jobDetailShow(BuildContext context, Job job) async {
    var alertDialog = JobDetailsModel.showAlertDialog(context, job);
    await showDialog(context: context, builder: (context) => alertDialog);
    getList();
  }

  // ***************** FLOATİNACTİONBUTTON JOB EKLE BUTONU ***************** //
  FloatingActionButton _floatinButtonAddJob(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
      onPressed: () => addJob(context),
      child: Icon(Icons.add, size: 35),
      splashColor: Colors.grey,
    );
  }

  // ***************** EKLEYE BASINCA ÇALIŞAN METHOD ***************** //
  void addJob(BuildContext context) async {
    await Navigator.pushNamed(context, '/${PageEnum.jobInsertView.name}');
    getList();
  }

  setJobState(int id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('İşi yaptığınız mı?'),
            actions: [
              TextButton(
                child: Text('Evet'),
                onPressed: () {
                  HomeViewModel.updateJobState(id, 1);
                  getList();
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('Hayır'),
                onPressed: () {
                  HomeViewModel.updateJobState(id, 0);
                  getList();
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
