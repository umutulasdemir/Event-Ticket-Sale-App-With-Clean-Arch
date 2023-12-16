import 'package:injectable/injectable.dart';
import 'package:event_ticket_sale_app_with_clean_arch/core/usecase/usecase_template.dart';
import 'package:event_ticket_sale_app_with_clean_arch/features/home/domain/entity/event_entity.dart';
import 'package:event_ticket_sale_app_with_clean_arch/features/home/domain/usecase/get_events_usecase.dart';
import 'package:mobx/mobx.dart';
part 'home_screen_logic_holder.g.dart';


@injectable
class HomeScreenLogicHolder = _HomeScreenLogicHolderBase
    with _$HomeScreenLogicHolder;

abstract class _HomeScreenLogicHolderBase with Store {
  GetEventsUsecase getEventsUsecase;
  _HomeScreenLogicHolderBase(
    this.getEventsUsecase,
  );

  @observable
  bool isEventsLoading = false;

   @observable
  bool isEventsLoading2 = false;

  List<EventEntity> events = [];

  Future<List<EventEntity>> getEvents() async {
    if (events.isEmpty) {
      isEventsLoading = true;
      var result = await getEventsUsecase.call(NoParams());
      isEventsLoading = false;
      events = result.getOrElse(() => []);
      // for (var element in events) {
      //   if (element.id != null) {
      //     // maybe do something here
      //   }
      // }
    }
    return events;
  }
}