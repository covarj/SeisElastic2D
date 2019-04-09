        !COMPILER-GENERATED INTERFACE MODULE: Thu Apr  4 12:15:49 2019
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE HGLJ__genmod
          INTERFACE 
            FUNCTION HGLJ(I,Z,ZGLJ,NZ)
              INTEGER(KIND=4) :: NZ
              INTEGER(KIND=4) :: I
              REAL(KIND=8) :: Z
              REAL(KIND=8) :: ZGLJ(0:NZ-1)
              REAL(KIND=8) :: HGLJ
            END FUNCTION HGLJ
          END INTERFACE 
        END MODULE HGLJ__genmod
