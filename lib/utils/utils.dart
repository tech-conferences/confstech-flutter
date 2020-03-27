import 'package:intl/intl.dart';

class Utils {
  static formatDate(String startDate, String endDate){
    if(startDate.length == 7) {
      //when there is no day, we append it. eg. 2020-02 will be parsed 2020-02-01
      return DateFormat.MMMM(DateTime.parse('$startDate-01'));
    }

    DateTime parsedStartDate = DateTime.parse(startDate);

    if(endDate != null && endDate.isNotEmpty && startDate != endDate){
      DateTime parsedEndDate = DateTime.parse(endDate);

      if(DateFormat.MMMM().format(parsedStartDate) ==
          DateFormat.MMMM().format(parsedEndDate)){
        return '${DateFormat.MMMMd().format(parsedStartDate)}'
            '-'
            '${DateFormat.d().format(parsedEndDate)}';
      } else {
        return '${DateFormat.MMMMd().format(parsedStartDate)}'
            '-'
            '${DateFormat.MMMd().format(parsedEndDate)}';
      }
    } else {
      return DateFormat.MMMMd().format(parsedStartDate);
    }
  }
}