
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'cash_n_carry_di.config.dart';

final getIt = GetIt.instance;

@injectableInit
void initCashnCarry()=>$initGetIt(getIt);