        !COMPILER-GENERATED INTERFACE MODULE: Thu Apr  4 12:15:49 2019
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE LAGRANGE_DERIV_GLL__genmod
          INTERFACE 
            FUNCTION LAGRANGE_DERIV_GLL(I,J,ZGLL,NZ)
              INTEGER(KIND=4) :: NZ
              INTEGER(KIND=4) :: I
              INTEGER(KIND=4) :: J
              REAL(KIND=8) :: ZGLL(0:NZ-1)
              REAL(KIND=8) :: LAGRANGE_DERIV_GLL
            END FUNCTION LAGRANGE_DERIV_GLL
          END INTERFACE 
        END MODULE LAGRANGE_DERIV_GLL__genmod
