import 'package:flutter/material.dart';
//sol tarafta providerdan alınan bilgilerle alınan user ismi yazılacak
// Assuming you have a ProfilePage widget defined elsewhere

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(

      backgroundColor: Theme.of(context).colorScheme.background, 
      elevation: 0,
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}