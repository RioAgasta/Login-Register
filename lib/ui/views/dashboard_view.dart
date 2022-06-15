import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectrio/ui/shared/ui_helper.dart';
import 'package:projectrio/viewmodels/dashboard_view_model.dart';
import 'package:stacked/stacked.dart';

class DashboardView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(),
      onModelReady: (model) => model.initData(context),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
                'Dashboard Register'
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Selamat Datang!",
                        style: TextStyle(
                            fontSize: 40
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        MaterialButton(
                          onPressed: (){
                            model.signOut(context);
                          },
                          child: Text(
                              "Log Out"
                          ),
                        ),
                        horizontalSpaceMedium,
                        MaterialButton(
                          onPressed: (){
                            model.report(context);
                          },
                          child: Text(
                              "Pelaporan"
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
