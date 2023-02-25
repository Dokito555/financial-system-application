import 'package:equatable/equatable.dart';

abstract class Usecase<Type, A> {
  const Usecase();

  Type execute(A params);
}

abstract class UsecaseTwoParams<Type, A, B> {
  const UsecaseTwoParams();

  Type execute(A paramsOne, B paramsTwo);
}

abstract class UsecaseThreeParams<Type, A, B, C> {
  const UsecaseThreeParams();

  Type execute(A paramsOne, B paramsTwo, C paramsThree);
}

class NoParams extends Equatable {

  const NoParams();

  @override
  List<Object?> get props => [];

}