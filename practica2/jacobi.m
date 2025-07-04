% JACOBI ITERATIVE ALGORITHM 7.1
% (updated Paco 20 Feb 2014)
% To solve Ax = b given an initial approximation x(0).
%
% INPUT:   the number of equations and unknowns n; the entries
%          A(I,J), 1<=I, J<=n, of the matrix A; the entries
%          B(I), 1<=I<=n, of the inhomogeneous term b; the
%          entries XO(I), 1<=I<=n, of x(0); tolerance TOL;
%          maximum number of iterations N.
%
%  OUTPUT: the approximate solution X(1),...,X(n) or a message
%          that the number of iterations was exceeded.
%OBSOLETO syms('AA', 'OK', 'NAME', 'INP', 'N', 'I', 'J', 'A', 'X1');
%OBSOLETO syms('TOL', 'NN', 'K', 'ERR', 'S', 'X2', 'FLAG', 'OUP');
 TRUE = 1;
 FALSE = 0;
 fprintf(1,'This is the Jacobi Method for Linear Systems.\n');
 fprintf(1,'The array will be input from a text file with the format\n');
 fprintf(1,'A(1,1)  A(1,2)  ...  A(1,n+1) \n');
 fprintf(1,'A(2,1)  A(2,2)  ...  A(2,n+1) \n');
 fprintf(1,'............................. \n');
 fprintf(1,'A(n,1)  A(n,2)  ...  A(n,n+1) \n');
 fprintf(1,'The elements in the last column are the those of the \n');
 fprintf(1,'independent term of the linear system.\n');
 fprintf(1,'Place as many entries as desired on each line, but \n');
 fprintf(1,'separate entries with at least one blank.\n\n');
 fprintf(1,'IMPORTANT: the initial approximation should follow \n');
 fprintf(1,'(as last line of the file) using the same format.\n\n');
 fprintf(1,'Has the input file been created? - enter Y or N.\n');
 AA = input(' ','s');
 OK = FALSE;
 if AA == 'Y' | AA == 'y' 
 fprintf(1,'Input the file name in the form - drive:\\name.ext\n');
 fprintf(1,'for example:   C:\\data.txt\n');
 NAME = input(' ','s');
 INP = fopen(NAME,'rt');
 OK = FALSE;
 while OK == FALSE 
 fprintf(1,'Input the number of equations - an integer.\n');
 N = input(' ');
 if N > 0 
 A = zeros(N,N+1);
 X1 = zeros(N);
 X2 = zeros(N);
 for I = 1 : N 
 for J = 1 : N+1 
 A(I,J) = fscanf(INP, '%f',1);
 end;
 end;
 for I = 1 : N 
 X1(I) = fscanf(INP, '%f',1);
 end;
 OK = TRUE;
 fclose(INP);
 else
 fprintf(1,'The number must be a positive integer\n');
 end;
 end;
 OK = FALSE;
 while OK == FALSE 
 fprintf(1,'Input the tolerance.\n');
 TOL = input(' ');
 if TOL > 0 
 OK = TRUE;
 else
 fprintf(1,'Tolerance must be a positive.\n');
 end;
 end;
 OK = FALSE;
 while OK == FALSE 
 fprintf(1,'Input maximum number of iterations.\n');
 NN = input(' ');
 if NN > 0 
 OK = TRUE;
 else
 fprintf(1,'Number must be a positive integer.\n');
 end;
 end;
 else
 fprintf(1,'The program will end so the input file can be created.\n');
 end;
 if OK == TRUE 
% STEP 1
 K = 1;
 OK = FALSE;
% STEP 2
 while OK == FALSE & K <= NN 
% err is used to test accuracy - it measures the infinity-norm
 ERR = 0;
% STEP 3
 for I = 1 : N 
 S = 0;
 for J = 1 : N 
 S = S-A(I,J)*X1(J);
 end;
 S = (S+A(I,N+1))/A(I,I);
 if abs(S) > ERR 
 ERR = abs(S);
 end;
% use X2 for X
 X2(I) = X1(I)+S;
 end;
% STEP 4
 if ERR <= TOL 
% process is complete
 OK = TRUE;
 else
% STEP 5
 K = K+1;
% STEP 6
 for I = 1 : N 
 X1(I) = X2(I);
 end;
 end;
 end;
 if OK == FALSE 
 fprintf(1,'Maximum Number of Iterations Exceeded.\n');
% STEP 7
% procedure completed unsuccessfully
 else
 fprintf(1,'Choice of output method:\n');
 fprintf(1,'1. Output to screen\n');
 fprintf(1,'2. Output to text file\n');
 fprintf(1,'Please enter 1 or 2.\n');
 FLAG = input(' ');
 if FLAG == 2 
 fprintf(1,'Input the file name in the form - drive:\\name.ext\n');
 fprintf(1,'for example:   A:\\OUTPUT.DTA\n');
 NAME = input(' ','s');
 OUP = fopen(NAME,'wt');
 else
 OUP = 1;
 end;
 fprintf(OUP, 'JACOBI ITERATIVE METHOD FOR LINEAR SYSTEMS\n\n');
 fprintf(OUP, 'The solution vector is :\n');
 for I = 1 : N 
 fprintf(OUP, ' %11.8f', X2(I));
 end;
 fprintf(OUP, '\nusing %d iterations\n', K);
 fprintf(OUP, 'with Tolerance  %.10e in infinity-norm\n', TOL);
 if OUP ~= 1 
 fclose(OUP);
 fprintf(1,'Output file %s created successfully \n',NAME);
 end;
 end;
 end;
