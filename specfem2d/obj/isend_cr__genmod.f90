        !COMPILER-GENERATED INTERFACE MODULE: Thu Apr  4 12:15:18 2019
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE ISEND_CR__genmod
          INTERFACE 
            SUBROUTINE ISEND_CR(SENDBUF,SENDCOUNT,DEST,SENDTAG,REQ)
              INTEGER(KIND=4) :: SENDCOUNT
              REAL(KIND=4) :: SENDBUF(SENDCOUNT)
              INTEGER(KIND=4) :: DEST
              INTEGER(KIND=4) :: SENDTAG
              INTEGER(KIND=4) :: REQ
            END SUBROUTINE ISEND_CR
          END INTERFACE 
        END MODULE ISEND_CR__genmod
