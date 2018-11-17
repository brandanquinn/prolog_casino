% cards
card(h, 2).
card(h, 3).
card(h, 4).
card(h, 5).
card(h, 6).
card(h, 7).
card(h, 8).
card(h, 9).
card(h, x).
card(h, j).
card(h, q).
card(h, k).
card(h, a).

card(s, 2).
card(s, 3).
card(s, 4).
card(s, 5).
card(s, 6).
card(s, 7).
card(s, 8).
card(s, 9).
card(s, x).
card(s, j).
card(s, q).
card(s, k).
card(s, a).

card(d, 2).
card(d, 3).
card(d, 4).
card(d, 5).
card(d, 6).
card(d, 7).
card(d, 8).
card(d, 9).
card(d, x).
card(d, j).
card(d, q).
card(d, k).
card(d, a).

card(c, 2).
card(c, 3).
card(c, 4).
card(c, 5).
card(c, 6).
card(c, 7).
card(c, 8).
card(c, 9).
card(c, x).
card(c, j).
card(c, q).
card(c, k).
card(c, a).

deck([
    (h, 2), (h, 2), (h, 3), (h, 4), (h, 5), (h, 6), (h, 7), (h, 8), (h, 9), (h, x), (h, j), (h, q), (h, k), (h, a),
    (s, 2), (s, 2), (s, 3), (s, 4), (s, 5), (s, 6), (s, 7), (s, 8), (s, 9), (s, x), (s, j), (s, q), (s, k), (s, a),
    (d, 2), (d, 2), (d, 3), (d, 4), (d, 5), (d, 6), (d, 7), (d, 8), (d, 9), (d, x), (d, j), (d, q), (d, k), (d, a),
    (c, 2), (c, 2), (c, 3), (c, 4), (c, 5), (c, 6), (c, 7), (c, 8), (c, 9), (c, x), (c, j), (c, q), (c, k), (c, a)
]).

shuffledeck(ShuffledDeck) :-    deck(Deck),
                                random_permutation(Deck, ShuffledDeck).

isfirstcard(h, 2).

printdeck([]).
printdeck([Top | Rest]) :- write(card(Top)),
                            printdeck(Rest).

:- initialization forall(shuffledeck(ShuffledDeck), printdeck(ShuffledDeck)).

