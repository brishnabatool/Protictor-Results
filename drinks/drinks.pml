mtype = { milk, lemonade, water };
bool bought_milk = false, bought_lemonade = false, bought_water = false;
int num_drinks = 0;

/*
inline buy_item(a_drink, bought_a_drink) {
(item==a_drink) -> 
            bought_a_drink = true;
}
*/

proctype perhaps_buy(mtype item) {
bool bought_something;

    atomic
    {
      bought_something = true;

      if
        ::  (item == milk) -> 
            bought_milk = true; 
            num_drinks++;
        ::  (item == lemonade)  -> 
            bought_lemonade = true; 
            num_drinks++;
        ::  (item == water) -> 
            bought_water = true; 
            num_drinks++;
        ::  true -> 
            bought_something = false;
      fi;

    }
}

init {
  if
    ::  run perhaps_buy(milk);
    ::  run perhaps_buy(lemonade);
    ::  run perhaps_buy(water);
  fi
  if
    ::  run perhaps_buy(milk);
    ::  run perhaps_buy(lemonade);
    ::  run perhaps_buy(water);
  fi
  if
    ::  run perhaps_buy(milk);
    ::  run perhaps_buy(lemonade);
    ::  run perhaps_buy(water);
  fi
}

ltl p0 {[](num_drinks <= 2)};