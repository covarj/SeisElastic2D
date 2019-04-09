        !COMPILER-GENERATED INTERFACE MODULE: Thu Apr  4 12:15:49 2019
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE LAGRANGE_ANY__genmod
          INTERFACE 
            SUBROUTINE LAGRANGE_ANY(XI,NGLL,XIGLL,H,HPRIME)
              INTEGER(KIND=4) :: NGLL
              REAL(KIND=8) :: XI
              REAL(KIND=8) :: XIGLL(NGLL)
              REAL(KIND=8) :: H(NGLL)
              REAL(KIND=8) :: HPRIME(NGLL)
            END SUBROUTINE LAGRANGE_ANY
          END INTERFACE 
        END MODULE LAGRANGE_ANY__genmod
