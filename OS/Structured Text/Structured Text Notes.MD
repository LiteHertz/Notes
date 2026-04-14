# Structured Text Notes

## Default priority order (high to low)

1. `NOT`
2. `*`, `/`, `MOD`
3. `+`, `-`
4. `<`, `>`, `<=`, `>=`, `=`, `<>`
5. `AND`
6. `XOR`
7. `OR`

So `AND` always binds tighter than `OR`, and `NOT` binds tightest of all.

## Practical examples

```plaintext
(* NOT needs no parens on a single variable *)
NOT PIECE_PRESENT

(* BUT if you NOT a compound expression, you need parens *)
NOT (PIECE_PRESENT OR SENSOR_FAULT)

(* AND binds before OR, so this... *)
A OR B AND C
(* ...is actually read as: *)
A OR (B AND C)

(* If you meant (A OR B) AND C, you must write it explicitly *)
(A OR B) AND C
```

The safe rule of thumb : **just always use parentheses**
