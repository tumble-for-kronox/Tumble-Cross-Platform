import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'resource_state.dart';

class ResourceCubit extends Cubit<ResourceState> {
  ResourceCubit() : super(ResourceState());
}
