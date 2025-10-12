import 'package:dartz/dartz.dart';
import 'package:medapp/data/suggestions/model/suggestions.dart';

import '../../../core/errors/failure.dart';

abstract class SuggestionsRepository {
   Future<Either<Failure, SuggestionResponse>> suggestions({
    required String title,
    required String description,
   });
 }