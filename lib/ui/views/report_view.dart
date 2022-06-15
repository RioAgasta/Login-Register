import 'package:projectrio/constants/const.dart';
import 'package:projectrio/constants/route_name.dart';
import 'package:projectrio/ui/shared/shared_style.dart';
import 'package:projectrio/ui/widgets/list_content_widget.dart';
import 'package:projectrio/viewmodels/report_view_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:flutter/services.dart';

class ReportView extends StatefulWidget {
  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView>{
  int page;
  @override

  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    return ViewModelBuilder<ReportViewModel>.reactive(
      viewModelBuilder: () => ReportViewModel(),
      onModelReady: (model) => model.getAllReport(1),
      disposeViewModel: true,
      builder: (context, model, child) => Scaffold(
        appBar:AppBar(
          title: Text('Aplikasi Pelaporan', style: TextStyle(fontFamily: 'meri'),),
          backgroundColor: Colors.grey,
        ),
        backgroundColor: Color(0xffF3F6FF),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    print('refresh');
                    model.getAllReport(1);
                  },
                  child: Container(
                    color: Color(0xffF8F8FA),
                    child: Column(
                      children: <Widget> [
                        Expanded(
                          child: model.absenData.length != 0 ? NotificationListener<ScrollNotification> (
                            onNotification: (ScrollNotification scrollInfo){
                              if(!model.isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent){
                                model.pages += 1;
                                model.loadMoreData(model.pages);
                              }
                            },
                            child: ListView.builder(
                              padding: EdgeInsets.only(
                                top: 8.0,
                                bottom: 8.0,
                                right: 4.0,
                                left: 4.0
                              ),
                              itemCount: model.absenData.length,
                              itemBuilder: (ctx, idx) => ListContentWidget(
                                content: '${model.absenData[idx].description}',
                                date: '${model.formatDate(model.absenData[idx].timestamp)}',
                                address: '${model.absenData[idx].address}',
                                imageUrl: '',
                                name: '${model.absenData[idx].name}',
                                imageLocal: '${model.absenData[idx].localImage}'
                              )
                            )
                          ) : Center(
                            child: Text(
                              'none',
                              style: profileTextStyle
                            )
                          )
                        ),
                        Container(
                          height: model.isLoading ? 50.0 : 0,
                          color: Colors.transparent,
                          child: Center(
                            child: new CircularProgressIndicator()
                          )
                        )
                      ]
                    )
                  )
                )
              )
            ]
          )
        ),
        floatingActionButton: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.add,
                    color: Color(0xffF8F8FA)
                  ),
                  onPressed: (){
                    model.goAnotherView(ReportViewRoute);
                  },
                  heroTag: "ReportViewRoute",
                )
              ],
            )
          ]
        ),
      )
    );
  }
}