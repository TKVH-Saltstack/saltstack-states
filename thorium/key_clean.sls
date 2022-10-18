statreg:
  status.reg

keydel:
  key.timeout:
    - delete: 300
    - require:
      - status: statreg
