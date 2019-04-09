        !COMPILER-GENERATED INTERFACE MODULE: Thu Apr  4 12:16:57 2019
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE SWAP_ALL_BUFFERS__genmod
          INTERFACE 
            SUBROUTINE SWAP_ALL_BUFFERS(IA,IB,A,B,IW,W,IND,N)
              INTEGER(KIND=4) :: N
              INTEGER(KIND=4) :: IA(N)
              INTEGER(KIND=4) :: IB(N)
              REAL(KIND=8) :: A(N)
              REAL(KIND=8) :: B(N)
              INTEGER(KIND=4) :: IW(N)
              REAL(KIND=8) :: W(N)
              INTEGER(KIND=4) :: IND(N)
            END SUBROUTINE SWAP_ALL_BUFFERS
          END INTERFACE 
        END MODULE SWAP_ALL_BUFFERS__genmod
