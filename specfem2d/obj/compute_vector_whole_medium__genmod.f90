        !COMPILER-GENERATED INTERFACE MODULE: Thu Apr  4 12:15:03 2019
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE COMPUTE_VECTOR_WHOLE_MEDIUM__genmod
          INTERFACE 
            SUBROUTINE COMPUTE_VECTOR_WHOLE_MEDIUM(FIELD_ACOUSTIC,      &
     &FIELD_GRAVITOACOUSTIC,FIELD_GRAVITO,FIELD_ELASTIC,                &
     &FIELDS_POROELASTIC)
              USE SPECFEM_PAR
              REAL(KIND=4) :: FIELD_ACOUSTIC(NGLOB_ACOUSTIC)
              REAL(KIND=4) :: FIELD_GRAVITOACOUSTIC(                    &
     &NGLOB_GRAVITOACOUSTIC)
              REAL(KIND=4) :: FIELD_GRAVITO(NGLOB_GRAVITOACOUSTIC)
              REAL(KIND=4) :: FIELD_ELASTIC(3,NGLOB_ELASTIC)
              REAL(KIND=4) :: FIELDS_POROELASTIC(2,NGLOB_POROELASTIC)
            END SUBROUTINE COMPUTE_VECTOR_WHOLE_MEDIUM
          END INTERFACE 
        END MODULE COMPUTE_VECTOR_WHOLE_MEDIUM__genmod
