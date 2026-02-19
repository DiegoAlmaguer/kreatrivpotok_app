import 'package:flutter/material.dart';
import '../staff/staff_project_screen.dart';

class AdminProjectScreen extends StatelessWidget {
  final String projectId;
  const AdminProjectScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return StaffProjectScreen(
      projectId: projectId,
      mode: ProjectMode.admin,
    );
  }
}
