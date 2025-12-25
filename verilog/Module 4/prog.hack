// This program computes the sum of all natural numbers from 1 to n
@R0 // The result will be stored at R0
M = 0 // Initialize R0 with 0
@10 // The value to be stored in n
D = A // Store it in D to transfer it to n
@n
M = D // Now n has the value of 10
(LOOP)
@n
D = M // Store the current value of n into D
@R0 // load R0
M = D + M // store the sum of R0 and current value of n
@n
M = M - 1 // decrement the value of n by 1
@n
D = M // Load the value of n into D
@LOOP // Go back to loop, where we get the current value of n, after next step
D; JGT // If current value of n is greater than 0 then jump to LOOP
@END
0;JMP // Infinite loop to avoid accessing further instruction memory