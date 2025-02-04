// lab2exD.c
// ENCM 369 Winter 2025 Lab 2 Exercise D
//
// INSTRUCTIONS
//   Your overall goal is to translate this program into RARS
//   assembly language.  Proceed using the following steps:
//
//   1. Make sure you know what this C program does.  If you're not
//      sure, add calls to printf.
//
//   2. Translate the program to Goto-C.  If you're not sure your
//      translation is correct, add calls to printf. 
//
//   3. Write down a list of local variables and the registers
//      you need for them.  (You will later type this in as
//      a comment in your RARS source code.)   
//
//   4. Using the products of Steps 2 and 3, write a RARS translation
//      of this program, in a file called lab2xD.asm.  Use comments (a)
//      to describe allocation of local variables to s-registers and
//      (b) to explain what each RARS instruction does.
//
//      Your RARS code must closely match the C code.  In particular,
//      the translation of the do-while loop should use pointer
//      arithmetic, and the translation of the for loop should include
//      generation of the addresses of alpha[i] and beta[j] by adding
//      4 times i to the address of alpha[0] and 4 times j to the
//      address of beta[0].
//
//   5. Test your translation using RARS.
#include <stdio.h>

int alpha[8] = {0xb1, 0xe1, 0x91, 0xc1, 0x81, 0xa1, 0xf1, 0xd1};
int beta[8] = {0x0, 0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70};

int main(void)
{
  int *p;
  int *guard;
  int min, i, j;

  // Put value of smallest element of alpha into min.
  p = alpha;
  min = *p;
  guard = p + 8;
  p++;

do_loop_start:
  if (*p < min) goto update_min;
update_min_end:
  p++;
  if (p == guard) goto do_loop_end;
  goto do_loop_start;
update_min:
  min = *p;
  goto update_min_end;
do_loop_end:

  /*do {
    if (*p < min)
      min = *p;
    p++;
  }
  while (p != guard); */
    
  // Copy elements from beta to alpha in reverse order,
  // writing over the initial values in alpha.
  i = 0;
  j = 7;
for_loop_start:
  if (i >= 8) goto for_loop_end;
  alpha[i] = beta[j];
  i++;
  j--;
  goto for_loop_start;
for_loop_end:

/*  for (i = 0, j = 7; i < 8; i++, j--)
    alpha[i] = beta[j];*/
  
  printf("%d\n", min);
  for (i = 0; i < 8; i++) {
    printf("%d ", alpha[i]);
  }

  return 0;
}
