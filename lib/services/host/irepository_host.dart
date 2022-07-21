import '../../models/host.dart';

abstract class IrepositoryHost {
  Future<List<Host>> getHosts();
  Future<dynamic> registerHost(Host request,);
}