import 'package:flutter/material.dart';
import 'package:vio_film/model/drawer_model.dart';
import 'package:vio_film/model/user_model.dart';
import 'package:vio_film/view/widget/drawer/see_edit_info.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class DrawerData{

  List<DrawerModel> drawerElements(UserModel user) => [
    DrawerModel(
      leading: Icons.person,
      trailing: Icons.arrow_forward_ios,
      title: "Mon profil",
      subTitle: "Modifier mes information",
      widget: SeeEditInfo(user: user),
    ),
    DrawerModel(
      leading: Icons.movie,
      trailing: Icons.arrow_forward_ios,
      title: "Prochaines sorties",
      subTitle: "Trailer à venir",
      widget: Container(),
    ),
    DrawerModel(
      leading: Icons.onetwothree,
      trailing: Icons.arrow_forward_ios,
      title: "Tendances",
      subTitle: "Films et séries les mieux noter",
      widget: Container(),
    ),
    DrawerModel(
      leading: Icons.settings,
      trailing: Icons.arrow_forward_ios,
      title: "Paramètres",
      subTitle: "Modifier la langue et le thème",
      widget: Container(),
    ),
    DrawerModel(
      leading: Icons.question_mark,
      trailing: Icons.arrow_forward_ios,
      title: "A propos",
      subTitle: "Version , API utilisée",
      widget: Container(),
    ),
    DrawerModel(
      leading: Icons.support_agent,
      trailing: Icons.arrow_forward_ios,
      title: "Aide et support",
      subTitle: "Version , API utilisée",
      widget: Container(),
    ),
  ];


}