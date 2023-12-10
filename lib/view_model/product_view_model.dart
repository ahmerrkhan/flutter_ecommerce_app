import 'package:flutter_application_3/models/get_product_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


///Using here a Cubit(BLoC) to emit states and event when user
///taps the Heart Icon
class ProductViewModel extends Cubit<List<GetProductListModel>> {
  ProductViewModel() : super([]);

  void addProduct(GetProductListModel product) {

    ///Adding item into the cart
    state.add(product);
    emit(List.from(state));
  }

  void deleteProduct(int index) {

    ///Removing item from the cart
    state.removeAt(index);
    emit(List.from(state));
  }
}