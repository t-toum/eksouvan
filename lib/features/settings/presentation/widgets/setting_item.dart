import 'package:eksouvan/core/utils/constants.dart';
import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final String? icon;
  final Widget? trailing;
  final GestureTapCallback? onTap;
  const SettingItem(
      {Key? key, required this.title, this.icon, this.trailing, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(icon ?? AppImages.default_avatar),
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 25),
        ),
        trailing: trailing ??
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primaryColor,
            ),
        onTap: onTap,
      ),
    );
  }
}
