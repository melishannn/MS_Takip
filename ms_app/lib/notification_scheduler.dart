//bildirimlerin planlanmasını burada yaparız
import 'package:flutter/material.dart';
import 'package:ms_app/services/notification_service.dart';
import 'package:ms_app/viewmodels/profile_view_model.dart';
import 'package:provider/provider.dart';

class NotificationScheduler {
  final BuildContext context;

  NotificationScheduler(this.context);

  void scheduleNotifications(ProfileViewModel viewModel) {
    final notificationService = Provider.of<NotificationService>(context, listen: false);
    
    // MR randevusundan 1 ay önce
    if (viewModel.nextMRApptDate != null) {
      final mrOneMonthBefore = viewModel.nextMRApptDate!.subtract(const Duration(days: 30));
      print('MR ve Doktor randevularını planla bildirimi $mrOneMonthBefore tarihinde planlandı.');
      notificationService.scheduleNotification(
        0,
        'Yaklaşan MR ve Doktor Randevuları',
        'Yaklaşan MR ve doktor randevularınızı planlayın.',
        mrOneMonthBefore,
      );

      // MR randevusundan 1 hafta önce
      final mrOneWeekBefore = viewModel.nextMRApptDate!.subtract(const Duration(days: 7));
      print('Yaklaşan MR randevunuz var bildirimi $mrOneWeekBefore tarihinde planlandı.');
      notificationService.scheduleNotification(
        1,
        'Yaklaşan MR Randevusu',
        'Yaklaşan MR randevunuz var.',
        mrOneWeekBefore,
      );
    }

    // Tahlil randevusundan 1 gün önce
    if (viewModel.nextTestDate != null) {
      final testOneDayBefore = viewModel.nextTestDate!.subtract(const Duration(days: 1));
      print('Yaklaşan tahlil randevularınız var bildirimi $testOneDayBefore tarihinde planlandı.');
      notificationService.scheduleNotification(
        2,
        'Yaklaşan Tahlil Randevuları',
        'Yaklaşan tahlil randevularınız var.',
        testOneDayBefore,
      );
    }

    // Doktor randevusundan 1 gün önce
    if (viewModel.nextDoctorVisitDate != null) {
      final doctorOneDayBefore = viewModel.nextDoctorVisitDate!.subtract(const Duration(days: 1));
      print('Yaklaşan doktor randevunuz var bildirimi $doctorOneDayBefore tarihinde planlandı.');
      notificationService.scheduleNotification(
        3,
        'Yaklaşan Doktor Randevusu',
        'Yaklaşan doktor randevunuz var.',
        doctorOneDayBefore,
      );
    }
  }
}
