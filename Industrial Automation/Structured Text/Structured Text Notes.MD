# Structured Text Notes

## Operation priorities

### Default priority order (high to low)

1. `NOT`
2. `*`, `/`, `MOD`
3. `+`, `-`
4. `<`, `>`, `<=`, `>=`, `=`, `<>`
5. `AND`
6. `XOR`
7. `OR`

So `AND` always binds tighter than `OR`, and `NOT` binds tightest of all.

### Practical examples

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

## Timers

**For some obscur reason, the TON timers don't work in ST. TONR timers must be used.**  
To use a timer, the settings in the timer must be written and then the timer itself executed.
The settings for tonr timers are the following

- `TONR_TIMER.TIMERENABLE := 0`
- `TONR_TIMER.RESET := 0`

Timers are different than in ladder logic since they require being executed. Toggling the .EN bit of the timer will not execute the timer itself.

```ST
// this would not work
MYTIMER.EN := 1;

// this would work
MYTIMER.TimerEnable := 1;
MYTIMER.Reset := 0
TONR(MYTIMER)
```

Timer arguments :
`TON(MyTimer, MyEnableCondition, MyPresetValue, 525);`

## Grafcet first states

It's important to make sure that the **first states of the grafcet don't have tags that get set** in them because they can overwrite the ones from other routines.
