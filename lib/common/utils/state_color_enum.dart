import 'package:flutter/material.dart';

import 'color_constants.dart';

enum StateColor
{
  draft,
  sale,
  sent,
  in_progress,
  done,
  cancel,
  extra,
  client_cancel,
  on_the_way
}

extension ExtraFunctionality on StateColor
{
  Color get colorData
  {
    switch (this)
    {
      case StateColor.draft:
        return AppColors.draftColor;
      case StateColor.sale:
        return AppColors.saleColor;
      case StateColor.sent:
        return AppColors.sentColor;
      case StateColor.in_progress:
        return AppColors.progressColor;
      case StateColor.done:
        return AppColors.doneColor;
      case StateColor.cancel:
        return AppColors.cancelColor;
      case StateColor.extra:
        return AppColors.darkBlueLight;
      case StateColor.client_cancel:
        return AppColors.cancelColor;
      case StateColor.on_the_way:
        return AppColors.onTheWayColor;
    }
  }

  String get string
  {
    switch (this)
    {
      case StateColor.draft:
        return "draft";
      case StateColor.sale:
        return "sale";
      case StateColor.sent:
        return "sent";
      case StateColor.in_progress:
        return "in_progress";
      case StateColor.done:
        return "done";
      case StateColor.cancel:
        return "cancel";
      case StateColor.extra:
        return "extra";
      case StateColor.client_cancel:
        return "client_cancel";
      case StateColor.on_the_way:
        return "on_the_way";
    }
  }

}