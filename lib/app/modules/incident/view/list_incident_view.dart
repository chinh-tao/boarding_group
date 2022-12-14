import 'package:boarding_group/app/modules/incident/view/components/list_incident.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../common/config.dart';
import '../../../common/primary_style.dart';
import '../controller/incident_controller.dart';

class ListIncidentView extends ConsumerStatefulWidget {
  const ListIncidentView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListIncidentState();
}

class _ListIncidentState extends ConsumerState<ListIncidentView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(incidentController.notifier).initData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 7),
        Expanded(
            child: RefreshIndicator(
                onRefresh: () async => ref
                    .read(incidentController.notifier)
                    .loadDataIncident(isRefresh: true),
                backgroundColor: kPrimaryColor,
                color: kWhiteColor,
                child: ref.watch(showList)))
      ],
    );
  }
}

final showList = Provider.autoDispose<Widget>((ref) {
  if (ref.watch(incidentController).isLoading) {
    return const Center(
      child: CircularProgressIndicator(color: kPrimaryColor),
    );
  } else {
    return const ListIncident();
  }
});
