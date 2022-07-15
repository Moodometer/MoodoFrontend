import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moodometer/data/models/user.model.dart';
import 'package:moodometer/logic/cubit/internet_cubit.dart';
import 'package:platform_device_id/platform_device_id.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final InternetCubit? internetCubit;
  late StreamSubscription? internetStreamSubscription;
  late UserModel user =
      UserModel(id: 0, deviceId: '', phonenumber: '', mood: 0);

  HomeBloc({this.internetCubit}) : super(HomeStateInitial()) {
    print("HomeState initializing...");
    on<AppStartedEvent>((event, emit) async {
      print('HomeState AppStartedEvent');
      emit(HomeStateLoading());
      user.deviceId = await PlatformDeviceId.getDeviceId;
      emit(HomeStateLoaded(user: user));
      print('HomeState Loaded');
    });
    on<DataRequestEvent>((event, emit) async {
      emit(HomeStateLoading());
      user.deviceId = await PlatformDeviceId.getDeviceId;
      emit(HomeStateLoaded(user: user));
      print('HomeState Loaded');
    });
  }
  @override
  Future<void> close() {
    internetStreamSubscription?.cancel();
    return super.close();
  }
}
