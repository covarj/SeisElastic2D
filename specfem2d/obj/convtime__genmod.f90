        !COMPILER-GENERATED INTERFACE MODULE: Thu Apr  4 12:15:12 2019
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE CONVTIME__genmod
          INTERFACE 
            SUBROUTINE CONVTIME(TIMESTAMP,YR,MON,DAY,HR,MINVALUE)
              INTEGER(KIND=4), INTENT(OUT) :: TIMESTAMP
              INTEGER(KIND=4), INTENT(IN) :: YR
              INTEGER(KIND=4), INTENT(IN) :: MON
              INTEGER(KIND=4), INTENT(IN) :: DAY
              INTEGER(KIND=4), INTENT(IN) :: HR
              INTEGER(KIND=4), INTENT(IN) :: MINVALUE
            END SUBROUTINE CONVTIME
          END INTERFACE 
        END MODULE CONVTIME__genmod
