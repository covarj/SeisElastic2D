        !COMPILER-GENERATED INTERFACE MODULE: Thu Apr  4 12:15:52 2019
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE SNAPSHOTS_NOISE__genmod
          INTERFACE 
            SUBROUTINE SNAPSHOTS_NOISE(NCOL,NGLOB,FILENAME,ARRAY_ALL)
              INTEGER(KIND=4) :: NGLOB
              INTEGER(KIND=4) :: NCOL
              CHARACTER(LEN=512) :: FILENAME
              REAL(KIND=4) :: ARRAY_ALL(NCOL,NGLOB)
            END SUBROUTINE SNAPSHOTS_NOISE
          END INTERFACE 
        END MODULE SNAPSHOTS_NOISE__genmod
