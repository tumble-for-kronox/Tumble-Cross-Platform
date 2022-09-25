// ignore_for_file: constant_identifier_names

part of 'resource_cubit.dart';

enum ResourceStatus { LOADING, LOADED, ERROR, INITIAL }

class ResourceState extends Equatable {
  const ResourceState();

  ResourceState copyWith() => const ResourceState();

  @override
  List<Object?> get props => [];
}
