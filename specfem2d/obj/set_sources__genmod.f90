        !COMPILER-GENERATED INTERFACE MODULE: Thu Apr  4 12:16:56 2019
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE SET_SOURCES__genmod
          INTERFACE 
            SUBROUTINE SET_SOURCES
              USE SPECFEM_PAR, ONLY :                                   &
     &          MYRANK,                                                 &
     &          NSOURCES,                                               &
     &          SOURCE_TYPE,                                            &
     &          TIME_FUNCTION_TYPE,                                     &
     &          X_SOURCE,                                               &
     &          Z_SOURCE,                                               &
     &          MXX,                                                    &
     &          MZZ,                                                    &
     &          MXZ,                                                    &
     &          F0,                                                     &
     &          TSHIFT_SRC,                                             &
     &          FACTOR,                                                 &
     &          ANGLESOURCE,                                            &
     &          AVAL,                                                   &
     &          T0,                                                     &
     &          INITIALFIELD,                                           &
     &          DELTAT,                                                 &
     &          USER_T0
            END SUBROUTINE SET_SOURCES
          END INTERFACE 
        END MODULE SET_SOURCES__genmod
