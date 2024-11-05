was_sold_repeatedly(Car):- car_sold(Auction, Car), car_sold(Auction2, Car), Auction \== Auction2.
was_sold_within_one_year(Car):- car_sold(Auction, Car), car(Vin, _, _, ProdYear, _, _), auction(Auction, _, _, _, AuctYear, _ , _, _, _, _, _), Delta is AuctYear - ProdYear, Delta < 365.
most_recent_sale(Car, Auction) :- car_sold(Auction, Car), auction(Auction, _, _, _, _, _, _, _, _, _, Recent), Recent == true.
current_car_color(Car, Color):- most_recent_sale(Car, Auction), auction(Auction, _, _, _, _, _, _, Color, _, _, _).
current_car_interior(Car, Interior):- most_recent_sale(Car, Auction), auction(Auction, _, _, _, _, _, _, _, Interior, _, _).
current_car_mmr(Car, MMR):- most_recent_sale(Car, Auction), auction(Auction, _, _, _, _, _, _, _, _, MMR, _).
current_car_selling_price(Car, Price):- most_recent_sale(Car, Auction), auction(Auction, _, _, Price, _, _, _, _, _, _, _).
current_car_condition(Car, Condition):- most_recent_sale(Car, Auction), auction(Auction, _, _, _, _, Condition, _, _, _, _, _).
current_car_odometer(Car, Odometer):- most_recent_sale(Car, Auction), auction(Auction, _, _, _, _, _, Odometer, _, _, _, _).
last_seller(Car, Seller):- most_recent_sale(Car, Auction), auction(Auction, Seller, _, _, _, _, _, _, _, _, _).
does_color_match_interior(Car):- current_car_color(Car, Color), current_car_interior(Car, Interior), Color == Interior.
was_sold_above_mmr(Car):- current_car_selling_price(Car, SP), current_car_mmr(Car, MP), SP > MP.
was_sold_below_mmr(Car):- current_car_selling_price(Car, SP), current_car_mmr(Car, MP), SP < MP.
was_sold_at_mmr(Car):- current_car_selling_price(Car, SP), current_car_mmr(Car, MP), SP == MP.
is_same_color(Car1, Car2):- Car1 \== Car2, current_car_color(Car1, Color), current_car_color(Car2, Color).
is_same_interior(Car1, Car2):- Car1 \== Car2, current_car_interior(Car1, Interior), current_car_interior(Car2, Interior).
is_same_market_price(Car1, Car2):- Car1 \== Car2, current_car_mmr(Car1, MMR), current_car_mmr(Car2, MMR).
is_same_selling_price(Car1, Car2):- Car1 \== Car2, current_car_selling_price(Car1, Price), current_car_selling_price(Car2, Price).
is_same_condition(Car1, Car2):- Car1 \== Car2, current_car_condition(Car1, Condition), current_car_condition(Car2, Condition).
is_same_odometer(Car1, Car2):- Car1 \== Car2, current_car_odometer(Car1, Odometer), current_car_odometer(Car2, Odometer).
is_same_make(Car1, Car2) :- Car1 \== Car2, car(Car1, Make, _, _, _, _), car(Car2, Make, _, _, _, _).
is_same_production_year(Car1, Car2):- Car1 \== Car2, car(Car1, _, _, Year, _, _), car(Car2, _, _, Year, _, _).
is_same_body(Car1, Car2):- Car1 \== Car2, car(Car1, _, _, _, Body, _), car(Car2, _, _, _, Body, _).
is_same_transmission(Car1, Car2):- Car1 \== Car2, car(Car1, _, _, _, _, Transmission), car(Car2, _, _, _, _, Transmission).
high_volume_seller(Seller):- findall(Auction, auction(Auction, Seller, _, _, _, _, _, _, _, _, _), List), length(List, N), N > 200.
highly_traded_make(Make):- findall(Auction, (car_sold(Auction, Car), car(Car, Make, _, _, _, _)), List), length(List, N), N > 1000.