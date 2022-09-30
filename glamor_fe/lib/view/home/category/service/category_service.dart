import 'package:client/product/enums/product_serivce_enum.dart';
import 'package:client/view/home/category/models/category_model.dart';
import 'package:client/view/home/category/models/subcategory_model.dart';
import 'package:client/view/home/category/service/ICategoryService.dart';
import 'package:vexana/vexana.dart';

class CategoryService extends ICategoryService {
  CategoryService(INetworkManager networkManager) : super(networkManager);

  @override
  Future<List<Category>?> fetchAllCategories() async {
    final response = await networkManager.send<Category, List<Category>>(
      '${ProductServicePath.category.name}/all',
      parseModel: Category(),
      method: RequestType.GET,
    );
    return response.data;
  }

  @override
  Future<Subcategory?> fetchSubcategories({required int id}) async {
    final response = await networkManager.send(
        '/${ProductServicePath.category.name}/$id',
        parseModel: Subcategory(),
        method: RequestType.GET);
    return response.data;
  }
}
