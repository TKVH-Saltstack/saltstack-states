highstate_apply:
  schedule.present:
    - function: state.apply
    - seconds: 300
