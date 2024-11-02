abstract class CategoryListAction {
  const CategoryListAction();
}

class FindItemAction extends CategoryListAction {
  final int id;

  const FindItemAction(this.id);
}

