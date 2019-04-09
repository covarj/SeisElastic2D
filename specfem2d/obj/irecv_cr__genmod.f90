        !COMPILER-GENERATED INTERFACE MODULE: Thu Apr  4 12:15:18 2019
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE IRECV_CR__genmod
          INTERFACE 
            SUBROUTINE IRECV_CR(RECVBUF,RECVCOUNT,DEST,RECVTAG,REQ)
              INTEGER(KIND=4) :: RECVCOUNT
              REAL(KIND=4) :: RECVBUF(RECVCOUNT)
              INTEGER(KIND=4) :: DEST
              INTEGER(KIND=4) :: RECVTAG
              INTEGER(KIND=4) :: REQ
            END SUBROUTINE IRECV_CR
          END INTERFACE 
        END MODULE IRECV_CR__genmod
