        !COMPILER-GENERATED INTERFACE MODULE: Thu Apr  4 12:15:49 2019
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE HGLL__genmod
          INTERFACE 
            FUNCTION HGLL(I,Z,ZGLL,NZ)
              INTEGER(KIND=4) :: NZ
              INTEGER(KIND=4) :: I
              REAL(KIND=8) :: Z
              REAL(KIND=8) :: ZGLL(0:NZ-1)
              REAL(KIND=8) :: HGLL
            END FUNCTION HGLL
          END INTERFACE 
        END MODULE HGLL__genmod
