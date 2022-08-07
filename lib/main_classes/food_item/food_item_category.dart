enum FoodItemCategory {
  BEEFBURGER,
  CHICKENBURGER,
  SIDES,
  FRIES,
}
// Would of liked to have done this better but because I chose to use enums to identify
// what type of food it was I then had to write a map for the category strings on the menu.
// Still this is a very scalable solution but I feel it could have been done better.
Map<FoodItemCategory, String> categoryStrings = {
  FoodItemCategory.BEEFBURGER: "Beef Burgers",
  FoodItemCategory.CHICKENBURGER: "Chicken Burgers",
  FoodItemCategory.SIDES: "Sides",
  FoodItemCategory.FRIES: "Fries",
};