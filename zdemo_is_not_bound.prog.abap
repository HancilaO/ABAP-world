*&---------------------------------------------------------------------*
*& Report  ZDEMO_IS_NOT_BOUND
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
*Definitions!
*IS BOUND
*It checks whether a reference variable contains a valid reference.
*A data reference variable that contains a stack reference, on the other hand,
*can become invalid even if the reference data object is removed from the stack.

*IS INITIAL
*checks whether the operand operand is initial.
*The expression is true, if the operand contains its type-friendly initial value.

*Is Assigned
*checks whether a memory area is assigned to a field symbol.
*The expression is true if the field symbol points to a memory area.

REPORT ZDEMO_IS_NOT_BOUND.

CLASS cls DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA dref TYPE REF TO i.
    CLASS-METHODS: main,check.
ENDCLASS.

CLASS cls IMPLEMENTATION.
  METHOD main.
    DATA number TYPE i.
    dref = REF #( number ).
  ENDMETHOD.

  METHOD check.

    WRITE: / 'dref IS BOUND? ', boolc( dref IS BOUND ).
    WRITE: / 'dref IS INITIAL? ', boolc( dref IS INITIAL ).

    FIELD-SYMBOLS: <any> TYPE i.

    WRITE: / '<any> IS ASSIGNED? ', boolc( <any> IS ASSIGNED ).
    IF <any> IS ASSIGNED.
      WRITE: / '<any> IS NOT INITIAL? ', boolc( <any> IS NOT INITIAL ). "It will dump without above IS ASSIGNED check
    ENDIF.


    ASSIGN dref->* TO <any>.
    WRITE: / '<any> IS ASSIGNED? ', boolc( <any> IS ASSIGNED ).
    IF <any> IS ASSIGNED.
      WRITE: / '<any> IS NOT INITIAL? ', boolc( <any> IS NOT INITIAL ). "It will dump without above IS ASSIGNED check
    ENDIF.

    DATA: a TYPE REF TO i.
    DATA: b LIKE REF TO a.

    FIELD-SYMBOLS: <any2> TYPE REF TO i.

    b = REF #( dref ).
    ASSIGN b->* TO <any2>.
    WRITE: / '<any2> IS BOUND? ', boolc( <any2> IS BOUND ).
    WRITE: / '<any2> IS INITIAL? ', boolc( <any2> IS INITIAL ).
    WRITE: / '<any2> IS ASSIGNED? ', boolc( <any2> IS ASSIGNED ).

    CLEAR: dref.
    WRITE: / 'After clear'.
    WRITE: / 'dref IS BOUND? ', boolc( dref IS BOUND ).
    WRITE: / 'dref IS INITIAL? ', boolc( dref IS INITIAL ).
    WRITE: / '<any2> IS BOUND? ', boolc( <any2> IS BOUND ).
    WRITE: / '<any2> IS INITIAL? ', boolc( <any2> IS INITIAL ).
    WRITE: / '<any2> IS ASSIGNED? ', boolc( <any2> IS ASSIGNED ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  cls=>main( ).
  cls=>check( ).
