// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:confs_tech/blocs/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('BottomBarBloc', () {
    BottomBarBloc bottomBarBloc;

    setUp(() {
      bottomBarBloc = BottomBarBloc();
    });

    tearDown(() {
      bottomBarBloc?.close();
    });

    test('initial state.selectedIndex is 0', () {
      expect(bottomBarBloc.state.selectedIndex, 0);
    });

    blocTest(
      'emits [BottomBarSelectedSuccess(selectedIndex: 1)] when BottomBarSelected(1) event is added',
      build: () => bottomBarBloc,
      act: (BottomBarBloc bloc) => bloc.add(BottomBarSelected(1)),
      expect: [BottomBarSelectedSuccess(selectedIndex: 1)],
    );
  });
}
