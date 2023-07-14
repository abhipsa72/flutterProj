abstract class WishListStates {}
class WishListAddedState extends WishListStates{
  final bool isPressed;

  WishListAddedState( this.isPressed);
  @override
  List<Object?> get props => [isPressed];
}