# test case 2
## Codes
``` arm
addi $1, $2, 10  // $1 <- $2 + 10
001000 00010 00001 0000000000001010

// ReservationStation deal with bc and write conflict
add $3, $1, $2 // $3 <- $1(depend) + $2
000000 00001 00010 00011 00000 100000

sub $1, $3, $0 // $1 <- $3(depend) - $0
000000 00011 00000 00001 00000 100011
```
## Coverage
