import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';

class GeneralSubwidgets {
  ActionPane slidableGeneralActionPane({
    Function(BuildContext context)? onDelete,
    Function(BuildContext context)? onEdit,
    List<Widget>? moreButtons,
  }) {
    return ActionPane(
      motion: const StretchMotion(),
      children: [
        if (onDelete != null)
          SlidableAction(
            onPressed: onDelete,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: appTranslate('delete'),
          ),
        if (onEdit != null)
          SlidableAction(
            onPressed: onEdit,
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: appTranslate('edit'),
          ),
        ...moreButtons ?? [],
      ],
    );
  }
}
