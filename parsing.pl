:- use_module(library(chr)).

:- chr_constraint sentence_atom/1, char/1, word_done/0, letter/1, partial_word/1, partial_sentence/1, sentence/1, sentence_done/0.

sentence_atom(SentenceAtom) <=>
    partial_sentence([]),
    atom_codes(SentenceAtom, Codes),
    maplist(char, Codes).

% is it a letter?
char(X) <=> X >= 0'a , X =< 0'z | letter(X).
char(X) <=> X >= 0'A , X =< 0'Z | letter(X).
char(0'.) <=> word_done, sentence_done.
char(_) <=> word_done.   % everything else ends words

letter(X), partial_word(List) <=>
            partial_word([X | List]).
letter(X) <=> partial_word([X]).

word_done, partial_word(List), partial_sentence(Sentence) <=>
    partial_word_word(List, Word),
    partial_sentence([Word|Sentence]).
word_done <=> true.  % eg comma followed by space we just ignore the space

sentence_done, partial_sentence(S) <=>
    reverse(S, Sentence),
    sentence(Sentence).

partial_word_word(List, Word) :-
    reverse(List, CodeWord),
    atom_codes(Word, CodeWord).
