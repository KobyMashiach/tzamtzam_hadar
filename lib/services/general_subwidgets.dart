import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';

class GeneralSubwidgets {
  ActionPane slidableGeneralActionPane({
    required Function(BuildContext context)? onDelete,
    required Function(BuildContext context)? onEdit,
  }) {
    return ActionPane(
      motion: const StretchMotion(),
      children: [
        SlidableAction(
          onPressed: onDelete,
          backgroundColor: Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: appTranslate('delete'),
        ),
        SlidableAction(
          onPressed: onEdit,
          backgroundColor: Color(0xFF21B7CA),
          foregroundColor: Colors.white,
          icon: Icons.share,
          label: appTranslate('edit'),
        ),
      ],
    );
  }
}
