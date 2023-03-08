import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vitalminds/views/calendar_page/calendar_page_view_model.dart';
import 'package:vitalminds/widgets/dumb_widgets/Themes.dart';
import 'package:intl/intl.dart';

class TableCalendarWidget extends StatelessWidget {
  final CalendarPageViewModel viewModel;
  const TableCalendarWidget({Key key, this.viewModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height * 0.45,
      padding: EdgeInsets.all(height * 0.015),
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.1),
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      margin: EdgeInsets.only(
          top: height * 0.02, left: width * 0.05, right: width * 0.05),
      child: TableCalendar(
        lastDay: viewModel.last,
        firstDay: viewModel.start,
        focusedDay: viewModel.focusedDay,
        onDaySelected: viewModel.onDaySelected,
        selectedDayPredicate: (day) => isSameDay(viewModel.selectedDay, day),
        rowHeight: height / 20,
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarBuilders: CalendarBuilders(
          singleMarkerBuilder: (context, date, events) {
            return Container(
              decoration: new BoxDecoration(
                color: Color.fromRGBO(255, 197, 1, 1),
                shape: BoxShape.circle,
              ),
              margin: EdgeInsets.all(width / 100),
            );
          },
          selectedBuilder: (context, date, _) {
            return Container(
              decoration: new BoxDecoration(
                color: Themes.color,
                shape: BoxShape.circle,
              ),
              margin: EdgeInsets.all(width / 100),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle(
                      fontFamily: 'Cambria',
                      color: Colors.white,
                      fontSize: height * 0.015,
                      fontWeight: FontWeight.w600),
                ),
              ),
            );
          },
        ),
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: Color.fromRGBO(39, 51, 72, 1),
          ),
          todayTextStyle: TextStyle(
              fontFamily: 'Cambria',
              color: Color(0xff082649),
              fontSize: height * 0.017,
              fontWeight: FontWeight.w600),
          defaultTextStyle: TextStyle(
              fontFamily: 'Cambria',
              color: Colors.white,
              fontSize: height * 0.017,
              fontWeight: FontWeight.w600),
          weekendTextStyle: TextStyle(
              fontFamily: 'Cambria',
              color: Colors.white,
              fontSize: height * 0.017,
              fontWeight: FontWeight.w600),
          outsideTextStyle: TextStyle(
              fontFamily: 'Cambria',
              color: Colors.white.withOpacity(0.4),
              fontSize: height * 0.017,
              fontWeight: FontWeight.w600),
          disabledTextStyle: TextStyle(
              fontFamily: 'Cambria',
              color: Colors.white.withOpacity(0.4),
              fontSize: height * 0.017,
              fontWeight: FontWeight.w600),
        ),
        headerStyle: HeaderStyle(
          leftChevronMargin: EdgeInsets.only(right: width * 0.2),
          leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white,),
          rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white,),
          leftChevronPadding: EdgeInsets.zero,
          rightChevronMargin: EdgeInsets.zero,
          rightChevronPadding: EdgeInsets.zero,
          headerMargin: EdgeInsets.only(bottom: height * 0.02),
          titleTextStyle: TextStyle(
              fontFamily: 'Cambria',
              color: Colors.white,
              fontSize: height * 0.024,
              fontWeight: FontWeight.w500),
          formatButtonVisible: false,
        ),
        daysOfWeekHeight: height * 0.03,
        daysOfWeekStyle: DaysOfWeekStyle(
          dowTextFormatter: (date, locale) {
            return DateFormat.E(locale).format(date).substring(0, 2);
          },
          weekdayStyle: TextStyle(
              fontFamily: 'Cambria',
              color: Colors.white,
              fontSize: height * 0.019,
              fontWeight: FontWeight.w400),
          weekendStyle: TextStyle(
              fontFamily: 'Cambria',
              color: Colors.white,
              fontSize: height * 0.019,
              fontWeight: FontWeight.w400),
        ),
        headerVisible: true,
      ),
    );
  }
}
